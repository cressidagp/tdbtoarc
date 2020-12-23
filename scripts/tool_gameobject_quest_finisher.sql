/*
==============================================
	Title: gameobject_questender to gameobject_quest_finisher
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
		
==============================================
*/

DROP TABLE IF EXISTS `gameobject_quest_finisher`;

--
-- Create a backup of original table...
--

CREATE TABLE `gameobject_questender2` SELECT * FROM `gameobject_questender`;

--
-- Here we go...
--

ALTER TABLE `gameobject_questender` CHANGE COLUMN `id` `id` int(11) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_questender` CHANGE COLUMN `quest` `quest` int(11) unsigned NOT NULL DEFAULT '0';

--
-- The End: rename to kickass way and set/remove keys if needed
--

RENAME TABLE `gameobject_questender` TO `gameobject_quest_finisher`;

--
-- Rename our backup table
--

RENAME TABLE `gameobject_questender2` TO `gameobject_questender`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `gameobject_questender` ADD PRIMARY KEY (`id`, `quest`);