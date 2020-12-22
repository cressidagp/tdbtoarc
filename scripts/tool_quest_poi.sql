/*
==============================================
	Title: quest_poi to quest_poi
	
	From TDB: 335.20101
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `quest_poi2`;

--
-- Create a backup of original table...
--

CREATE TABLE `quest_poi2` SELECT * FROM `quest_poi`;

--
-- Here we go...
--

ALTER TABLE `quest_poi` CHANGE COLUMN `QuestID` `questId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `id` `poiId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `ObjectiveIndex` `objIndex` int(10) NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `MapID` `mapId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `WorldMapAreaId` `mapAreaId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `Floor` `floorId` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `Priority` `unk3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `quest_poi` CHANGE COLUMN `Flags` `unk4` int(10) unsigned NOT NULL DEFAULT '0';

-- VerifiedBuild: leave it be... it wont harm.