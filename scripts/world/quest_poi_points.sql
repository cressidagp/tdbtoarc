/*
=================================================
	TDBtoARC
	
	Title: quest_poi_points to quest_poi_points
	
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

DROP TABLE IF EXISTS `quest_poi_points2`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `quest_poi_points2` SELECT * FROM `quest_poi_points`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `quest_poi_points` 

	DROP PRIMARY KEY,

	/* #3 */
	DROP COLUMN `Idx2`,

	/* #6 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `quest_poi_points` 

	CHANGE COLUMN `QuestID` `questId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Idx1` `poiId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `X` `x` int(10) NOT NULL DEFAULT '0',

	CHANGE COLUMN `Y` `y` int(10) NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

ALTER TABLE `quest_poi_points` 

	DROP KEY `questId_id`,

	ADD KEY `questId_id` (`questId`,`poiId`);

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `quest_poi_points2` 

	ADD PRIMARY KEY (`QuestID`,`Idx1`,`Idx2`),

	ADD KEY `questId_id` (`QuestID`,`Idx1`);