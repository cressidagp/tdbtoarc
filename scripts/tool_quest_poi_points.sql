/*
==============================================
	Title: quest_poi_points to quest_poi_points
	
	From TDB: 335.20101
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `quest_poi_points2`;

--
-- Create a backup of original table...
--

CREATE TABLE `quest_poi_points2` SELECT * FROM `quest_poi_points`;

--
-- Drop not supported columns
--

ALTER TABLE `quest_poi_points` DROP PRIMARY KEY;

ALTER TABLE `quest_poi_points` DROP COLUMN `Idx2`;

--
-- Here we go...
--

ALTER TABLE `quest_poi_points` CHANGE COLUMN `QuestID` `questId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi_points` CHANGE COLUMN `Idx1` `poiId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi_points` CHANGE COLUMN `X` `x` int(10) NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi_points` CHANGE COLUMN `Y` `y` int(10) NOT NULL DEFAULT '0';