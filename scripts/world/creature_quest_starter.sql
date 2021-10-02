/*
=================================================

	TDBtoARC
	
	Title: creature_queststarter to creature_quest_starter
	
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

DROP TABLE IF EXISTS `creature_quest_starter`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_queststarter2` SELECT * FROM `creature_queststarter`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature_queststarter` 

	CHANGE COLUMN `id` `id` int(11) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `quest` `quest` int(11) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_queststarter` TO `creature_quest_starter`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature_queststarter2` TO `creature_queststarter`;

--
-- Since our backup table(s) will lost his key(s) we should add them again
--

ALTER TABLE `creature_queststarter` ADD PRIMARY KEY (`id`, `quest`);