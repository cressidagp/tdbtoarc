/*
==============================================
	Title: playercreateinfo_action to playercreateinfo_bars
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `playercreateinfo_bars`;

--
-- Create a backup of original table...
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

ALTER TABLE `playercreateinfo_action` ADD COLUMN `misc` int(10) unsigned DEFAULT NULL AFTER `type`;

UPDATE `playercreateinfo_action` SET `misc` = '0' WHERE `misc` IS NULL;

--
-- The End: rename to kickass way
--

RENAME TABLE `playercreateinfo_action` TO `playercreateinfo_bars`;

--
-- Rename our backup table
--

RENAME TABLE `playercreateinfo_action2` TO `playercreateinfo_action`;