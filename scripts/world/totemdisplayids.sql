/*
=================================================

	TDBtoARC
	
	Title: player_totem_model to totemdisplayids
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO: our primary key its weird.
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `totemdisplayids`;
DROP TABLE IF EXISTS `player_totem_model2`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `player_totem_model2` SELECT * FROM `player_totem_model`;

--
--
-- Remove Dwarfs
--
--

DELETE FROM `player_totem_model` WHERE `RaceId` = 3;

--
--
-- Here we go...
--
--

ALTER TABLE `player_totem_model`

	DROP PRIMARY KEY,

	/* displayid: this are Taunka */

	ADD COLUMN `draeneiid` int(10) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `trollid` int(10) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `orcid` int(10) unsigned NOT NULL DEFAULT '0';
	
	
/* draeneiid: */

UPDATE `player_totem_model` SET `draeneiid` = `displayid` WHERE `RaceId` = 11;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 11 AND t2.TotemSlot = 1
SET t1.draeneiid = t2.draeneiid
WHERE t1.RaceId = 6 AND t1.TotemSlot = 1;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 11 AND t2.TotemSlot = 2
SET t1.draeneiid = t2.draeneiid
WHERE t1.RaceId = 6 AND t1.TotemSlot = 2;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 11 AND t2.TotemSlot = 3
SET t1.draeneiid = t2.draeneiid
WHERE t1.RaceId = 6 AND t1.TotemSlot = 3;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 11 AND t2.TotemSlot = 4
SET t1.draeneiid = t2.draeneiid
WHERE t1.RaceId = 6 AND t1.TotemSlot = 4;

DELETE FROM `player_totem_model` WHERE `draeneiid` = `displayid`;

/* trollid: */

UPDATE `player_totem_model` SET `trollid` = `displayid` WHERE `RaceId` = 8;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 8 AND t2.TotemSlot = 1
SET t1.trollid = t2.trollid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 1;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 8 AND t2.TotemSlot = 2
SET t1.trollid = t2.trollid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 2;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 8 AND t2.TotemSlot = 3
SET t1.trollid = t2.trollid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 3;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 8 AND t2.TotemSlot = 4
SET t1.trollid = t2.trollid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 4;

DELETE FROM `player_totem_model` WHERE `trollid` = `displayid`;

/* orcid: */

UPDATE `player_totem_model` SET `orcid` = `displayid` WHERE `RaceId` = 2;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 2 AND t2.TotemSlot = 1
SET t1.orcid = t2.orcid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 1;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 2 AND t2.TotemSlot = 2
SET t1.orcid = t2.orcid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 2;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 2 AND t2.TotemSlot = 3
SET t1.orcid = t2.orcid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 3;

UPDATE `player_totem_model` AS t1 JOIN `player_totem_model` AS t2 ON t2.RaceId = 2 AND t2.TotemSlot = 4
SET t1.orcid = t2.orcid 
WHERE t1.RaceId = 6 AND t1.TotemSlot = 4;

DELETE FROM `player_totem_model` WHERE `orcid` = `displayid`;

--
--
-- Drop not needed column(s)
--
--

ALTER TABLE `player_totem_model`

	/* #1 */
	DROP COLUMN `TotemSlot`,
	
	/* #1 */
	DROP COLUMN `RaceId`;
	
--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `player_totem_model` TO `totemdisplayids`;

ALTER TABLE `totemdisplayids` ADD PRIMARY KEY (`displayid`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `player_totem_model2` TO `player_totem_model`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `player_totem_model` ADD PRIMARY KEY (`TotemSlot`,`RaceId`);