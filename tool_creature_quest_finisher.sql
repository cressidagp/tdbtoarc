/*
==============================================
	Title: creature_questender to creature_quest_finisher
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `creature_quest_starter`;

--
-- Lets start...
--

ALTER TABLE `creature_questender` CHANGE COLUMN `id` `id` int(11) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_questender` CHANGE COLUMN `quest` `quest` int(11) unsigned NOT NULL DEFAULT '0';

--
-- The End: rename to kickass emu way
--

RENAME TABLE `creature_questender` TO `creature_quest_finisher`;

