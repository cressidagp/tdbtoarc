/*
==============================================
	TDBtoARC

	Title: playercreateinfo_action to playercreateinfo_bars
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `playercreateinfo_bars`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `playercreateinfo_action2` SELECT * FROM `playercreateinfo_action`;

--
-- Here we go...
--

ALTER TABLE `playercreateinfo_action` DISABLE KEYS;

ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `race` `race` tinyint(3) unsigned DEFAULT NULL;

ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `class` `class` tinyint(3) unsigned DEFAULT NULL;

ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `button` `button` int(10) unsigned DEFAULT NULL;

ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `action` `action` int(10) unsigned DEFAULT NULL;

ALTER TABLE `playercreateinfo_action` CHANGE COLUMN `type` `type` int(10) unsigned DEFAULT NULL;

ALTER TABLE `playercreateinfo_action` ADD COLUMN `misc` int(10) unsigned DEFAULT '0' AFTER `type`;

--
-- HACKFIX: For some reason Every man for Himselft its not being added in slot 11 for warrior, rogue, dk, mage, warlock
--

UPDATE `playercreateinfo_action` SET `button` = '83' WHERE (`race` = 1 and `class` = 1 and `action` = 59752 ); -- OK!

UPDATE `playercreateinfo_action` SET `button` = '10' WHERE (`race` = 1 and `class` = 4 and `action` = 59752 ); -- BUGGED

UPDATE `playercreateinfo_action` SET `button` = '9' WHERE (`race` = 1 and `class` = 6 and `action` = 59752 );

UPDATE `playercreateinfo_action` SET `button` = '10' WHERE (`race` = 1 and `class` = 8 and `action` = 59752 );

UPDATE `playercreateinfo_action` SET `button` = '10' WHERE (`race` = 1 and `class` = 9 and `action` = 59752 );

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `playercreateinfo_action` TO `playercreateinfo_bars`;

ALTER TABLE `playercreateinfo_bars` DROP PRIMARY KEY;

ALTER TABLE `playercreateinfo_bars` DROP KEY `playercreateinfo_race_class_index`;

--
-- Rename our backup table(s)
--

RENAME TABLE `playercreateinfo_action2` TO `playercreateinfo_action`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `playercreateinfo_action` ADD PRIMARY KEY (`race`,`class`,`button`);

ALTER TABLE `playercreateinfo_action` ADD KEY `playercreateinfo_race_class_index` (`race`,`class`);
