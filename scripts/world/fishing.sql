/*
=================================================

	TDBtoARC
	
	Title: skill_fishing_base_level to fishing
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo: if there isnt an area entry it should look for a zoneId (arcemu bug)

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `fishing`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `skill_fishing_base_level2` SELECT * FROM `skill_fishing_base_level`;

--
--
-- Here we go...
--
--

ALTER TABLE `skill_fishing_base_level` 

	CHANGE COLUMN `entry` `Zone` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `skill` `MinSkill` int(10) unsigned DEFAULT NULL,

	ADD COLUMN `MaxSkill` int(10) unsigned DEFAULT NULL AFTER `MinSkill`;

UPDATE `skill_fishing_base_level` SET `MaxSkill` = `MinSkill`;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 1 WHERE `MinSkill` = 25;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 25 WHERE `MinSkill` = 75;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 75 WHERE `MinSkill` = 100;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 100 WHERE `MinSkill` = 150;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 150 WHERE `MinSkill` = 225;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 225 WHERE `MinSkill` = 300;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 300 WHERE `MinSkill` = 375;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 375 WHERE `MinSkill` = 400;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 400 WHERE `MinSkill` = 425;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 425 WHERE `MinSkill` = 450;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 450 WHERE `MinSkill` = 475;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 475 WHERE `MinSkill` = 490;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 490 WHERE `MinSkill` = 500;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 500 WHERE `MinSkill` = 525;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 525 WHERE `MinSkill` = 550;

UPDATE `skill_fishing_base_level` SET `MinSkill` = 550 WHERE `MinSkill` = 575;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `skill_fishing_base_level` TO `fishing`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `skill_fishing_base_level2` TO `skill_fishing_base_level`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `skill_fishing_base_level` ADD PRIMARY KEY (`entry`);