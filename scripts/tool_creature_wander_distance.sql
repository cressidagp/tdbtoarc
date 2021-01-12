/*
==============================================
	TDBtoARC
	
	Title: creature to creature_wander_distance
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
		
==============================================
*/

DROP TABLE IF EXISTS `creature_wander_distance`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `creature2` SELECT * FROM `creature`;

CREATE TABLE `game_event_creature2` SELECT * FROM `game_event_creature`;

--
-- Unload all transports
--

DELETE FROM `creature` WHERE `map` 
IN (582,584,586,587,588,589,590,591,593,594,610,612,613,614,620,621,622,623,647);

--
-- Goodbay events
--

DELETE FROM `game_event_creature` WHERE `eventEntry` = 25; -- Lets keep night for now

DELETE FROM `game_event_creature` WHERE `eventEntry` = -25; -- Lets keep night for now

ALTER TABLE `creature` ADD COLUMN `eventEntry` int(4) NOT NULL DEFAULT '0' AFTER `map`;
UPDATE creature, game_event_creature
SET creature.eventEntry = game_event_creature.eventEntry 
WHERE creature.guid = game_event_creature.guid;

DELETE FROM `creature` WHERE `eventEntry` != 0;

ALTER TABLE `creature` DROP COLUMN `eventEntry`;

DROP TABLE IF EXISTS `game_event_creature`; -- Not needed anymore

--
-- Here we go...
--

ALTER TABLE `creature` DROP COLUMN `id`;

--ALTER TABLE `creature` DROP COLUMN `map`;

ALTER TABLE `creature` DROP COLUMN `zoneId`;

ALTER TABLE `creature` DROP COLUMN `areaId`;

ALTER TABLE `creature` DROP COLUMN `spawnMask`;

ALTER TABLE `creature` DROP COLUMN `phaseMask`;

ALTER TABLE `creature` DROP COLUMN `modelid`;

ALTER TABLE `creature` DROP COLUMN `equipment_id`;

ALTER TABLE `creature` DROP COLUMN `position_x`;

ALTER TABLE `creature` DROP COLUMN `position_y`;

ALTER TABLE `creature` DROP COLUMN `position_z`;

ALTER TABLE `creature` DROP COLUMN `orientation`;

ALTER TABLE `creature` DROP COLUMN `spawntimesecs`;

-- wander_distance: me want this.

ALTER TABLE `creature` DROP COLUMN `currentwaypoint`;

ALTER TABLE `creature` DROP COLUMN `curhealth`;

ALTER TABLE `creature` DROP COLUMN `curmana`;

--ALTER TABLE `creature` DROP COLUMN `MovementType`;

ALTER TABLE `creature` DROP COLUMN `npcflag`;

ALTER TABLE `creature` DROP COLUMN `unit_flags`;

ALTER TABLE `creature` DROP COLUMN `dynamicflags`;

ALTER TABLE `creature` DROP COLUMN `ScriptName`;

ALTER TABLE `creature` DROP COLUMN `VerifiedBuild`;

-- Take care of (B) and (A)

ALTER TABLE `creature` CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT;

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `creature` TO `creature_wander_distance`;

--
-- Rename our backup table(s)
--

RENAME TABLE `creature2` TO `creature`;

RENAME TABLE `game_event_creature2` TO `game_event_creature`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `creature` ADD PRIMARY KEY (`guid`);

ALTER TABLE `creature` ADD KEY `idx_map` (`map`);

ALTER TABLE `creature` ADD KEY `idx_id` (`id`);

ALTER TABLE `game_event_creature` ADD PRIMARY KEY (`guid`,`eventEntry`);