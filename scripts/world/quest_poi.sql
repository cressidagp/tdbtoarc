/*
=================================================

	TDBtoARC
	
	Title: quest_poi to quest_poi
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `quest_poi2`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `quest_poi2` SELECT * FROM `quest_poi`;

--
--
-- Drop not supported column(s)
--
--

/* #9 */
ALTER TABLE `quest_poi` DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `quest_poi` 

	CHANGE COLUMN `QuestID` `questId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `id` `poiId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `ObjectiveIndex` `objIndex` int(10) NOT NULL DEFAULT '0',

	CHANGE COLUMN `MapID` `mapId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `WorldMapAreaId` `mapAreaId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Floor` `floorId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Priority` `unk3` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Flags` `unk4` int(10) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

ALTER TABLE `quest_poi` 

	DROP PRIMARY KEY,

	DROP KEY `idx`,

	ADD KEY `questId` (`questId`,`poiId`),

	ADD KEY `id` (`poiId`,`questId`);

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `quest_poi2` 

	ADD PRIMARY KEY (`QuestID`,`id`),

	ADD KEY `idx` (`QuestID`,`id`);