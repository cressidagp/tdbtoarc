/*
=================================================

	TDBtoARC
	
	Title: game_tele to recall
	
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

DROP TABLE IF EXISTS `recall`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `game_tele2` SELECT * FROM `game_tele`;

--
--
-- Here we go...
--
--

ALTER TABLE `game_tele`

	CHANGE COLUMN `id` `id` bigint(20) unsigned NOT NULL AUTO_INCREMENT,
	
	CHANGE COLUMN `name` `name` varchar(100) NOT NULL AFTER `id`,
	
	CHANGE COLUMN `map` `MapId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `name` ,
	
	CHANGE COLUMN `position_x` `positionX` float NOT NULL DEFAULT '0' AFTER `MapId`,
	
	CHANGE COLUMN `position_y` `positionY` float NOT NULL DEFAULT '0' AFTER `positionX`,
	
	CHANGE COLUMN `position_z` `positionZ` float NOT NULL DEFAULT '0' AFTER `positionY`,
	
	CHANGE COLUMN `orientation` `Orientation` float unsigned NOT NULL DEFAULT '0' AFTER `positionZ`;
	

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `game_tele` TO `recall`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `game_tele2` TO `game_tele`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `game_tele` ADD PRIMARY KEY (`id`);