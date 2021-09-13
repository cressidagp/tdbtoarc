/*
=================================================

	TDBtoARC
	
	Title: gameobject_questender to gameobject_quest_finisher
	
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

DROP TABLE IF EXISTS `gameobject_quest_finisher`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gameobject_questender2` SELECT * FROM `gameobject_questender`;

--
--
-- Here we go...
--
--

ALTER TABLE `gameobject_questender`

	CHANGE COLUMN `id` `id` int(11) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `quest` `quest` int(11) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to kickass way and set/remove key(s) if needed
--
--

RENAME TABLE `gameobject_questender` TO `gameobject_quest_finisher`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject_questender2` TO `gameobject_questender`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gameobject_questender` ADD PRIMARY KEY (`id`, `quest`);