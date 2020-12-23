/*
==============================================
	Title: creature_questender to creature_quest_finisher
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `creature_quest_finisher`;

--
-- Create a backup of original table...
--

CREATE TABLE `creature_questender2` SELECT * FROM `creature_questender`;

--
-- Lets start...
--

ALTER TABLE `creature_questender` CHANGE COLUMN `id` `id` int(11) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_questender` CHANGE COLUMN `quest` `quest` int(11) unsigned NOT NULL DEFAULT '0';

--
-- The End: rename to kickass emu way
--

RENAME TABLE `creature_questender` TO `creature_quest_finisher`;

--
-- Rename our backup table(s)
--

RENAME TABLE `creature_questender2` TO `creature_questender`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `creature_questender` ADD PRIMARY KEY (`id`, `quest`);