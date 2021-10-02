/*
=================================================

	TDBtoARC

	Title: playercreateinfo_action to playercreateinfo_bars
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo: Every man for Himselft its not being added in slot 11 (arcemu bug)

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `playercreateinfo_bars`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `playercreateinfo_action2` SELECT * FROM `playercreateinfo_action`;

--
--
-- Here we go...
--
--

ALTER TABLE `playercreateinfo_action` 

	DROP PRIMARY KEY,

	CHANGE COLUMN `race` `race` tinyint(3) unsigned DEFAULT NULL,

	CHANGE COLUMN `class` `class` tinyint(3) unsigned DEFAULT NULL,

	CHANGE COLUMN `button` `button` int(10) unsigned DEFAULT NULL,

	CHANGE COLUMN `action` `action` int(10) unsigned DEFAULT NULL,

	CHANGE COLUMN `type` `type` int(10) unsigned DEFAULT NULL,

	ADD COLUMN `misc` int(10) unsigned DEFAULT '0' AFTER `type`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `playercreateinfo_action` TO `playercreateinfo_bars`;

ALTER TABLE `playercreateinfo_bars` DROP KEY `playercreateinfo_race_class_index`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `playercreateinfo_action2` TO `playercreateinfo_action`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `playercreateinfo_action` 

	ADD PRIMARY KEY (`race`,`class`,`button`),

	ADD KEY `playercreateinfo_race_class_index` (`race`,`class`);
