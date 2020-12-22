/*
==============================================
	Title: skill_fishing_base_level to fishing
	
	From TDB: 335.20111
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `fishing`;

--
-- Create a backup of original table...
--

CREATE TABLE `skill_fishing_base_level2` SELECT * FROM `skill_fishing_base_level`;

--
-- Here we go...
--

ALTER TABLE `skill_fishing_base_level` CHANGE COLUMN `entry` `Zone` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `skill_fishing_base_level` CHANGE COLUMN `skill` `MinSkill` int(10) unsigned DEFAULT NULL;

ALTER TABLE `skill_fishing_base_level` ADD COLUMN `MaxSkill` int(10) unsigned DEFAULT NULL AFTER `MinSkill`;

--
-- The End: rename to kickass way
--

RENAME TABLE `skill_fishing_base_level` TO `fishing`;

--
-- Rename our backup table
--

RENAME TABLE `skill_fishing_base_level2` TO `skill_fishing_base_level`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `skill_fishing_base_level` ADD PRIMARY KEY (`entry`);