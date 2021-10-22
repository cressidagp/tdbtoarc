/*
=================================================

	TDBtoARC
	
	Title: waypoint_data to creature_waypoints
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	[waypoint_data]		[creature_addon]		[creature]
			id -------------> path_id
							  guid ----------------> guid

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `creature_waypoints`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `waypoint_data2` SELECT * FROM `waypoint_data`;

CREATE TABLE `creature_addon2` SELECT * FROM `creature_addon`;

--
--
-- Remove transports waypoints
--
--
/*
ALTER TABLE `creature_addon` ADD COLUMN `temp_map` smallint(5) unsigned NOT NULL DEFAULT '0' AFTER `auras`;

UPDATE creature_addon, creature
SET creature_addon.temp_map = creature.map
WHERE creature_addon.guid = creature.guid;

DELETE FROM `creature_addon` WHERE `temp_map` IN ( 582, 584, 586, 587, 588, 589, 590, 591, 593, 594, 610, 612, 613, 614, 620, 621, 622, 623, 647 );

ALTER TABLE `creature_addon` DROP COLUMN `temp_map`;
/*

--
--
-- Remove event waypoints (example: guid 178)
--
--
/*
ALTER TABLE `creature_addon` ADD COLUMN `temp_event` smallint(5) NOT NULL DEFAULT '0' AFTER `auras`;

UPDATE creature_addon, game_event_creature
SET creature_addon.temp_event = game_event_creature.eventEntry
WHERE creature_addon.guid = game_event_creature.guid;

DELETE FROM `creature_addon` WHERE `temp_event` NOT IN ( 0, 25, -25 );

ALTER TABLE `creature_addon` DROP COLUMN `temp_event`;
*/

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `waypoint_data` 

	/* #10 */
	DROP COLUMN `action_chance`,

	/* #11 */
	DROP COLUMN `wpguid`;

--
--
-- Here we go...
--
--

ALTER TABLE `waypoint_data` 

	ADD COLUMN `guid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `id`,
	
	CHANGE COLUMN `point` `waypointid` int(10) unsigned NOT NULL DEFAULT '0',
	
	/* position_x: */

	/* position_y: */

	/* position_z: */
	
	DROP COLUMN `orientation`,
	
	CHANGE COLUMN `delay` `waittime` int(10) unsigned NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `move_type` `flags` int(10) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `forwardemoteoneshot` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `flags`,
	
	ADD COLUMN `forwardemoteid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `forwardemoteoneshot`,
	
	ADD COLUMN `backwardemoteoneshot` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `forwardemoteid`,
	
	ADD COLUMN `backwardemoteid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `backwardemoteoneshot`,
	
	ADD COLUMN `forwardskinid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `backwardemoteid`,
	
	ADD COLUMN `backwardskinid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `forwardskinid`;

/* guid: */
	
UPDATE waypoint_data, creature_addon
SET waypoint_data.guid = creature_addon.guid 
WHERE waypoint_data.id = creature_addon.path_id;

DELETE FROM `waypoint_data` WHERE `guid` = 0;

ALTER TABLE `waypoint_data` 

	CHANGE COLUMN `guid` `spawnid` int(10) unsigned NOT NULL DEFAULT '0',

	DROP PRIMARY KEY,

	DROP COLUMN `id`;
	
/* `flags`: */

UPDATE `waypoint_data` SET `flags` = 256 WHERE `flags` = 1;

UPDATE `waypoint_data` SET `flags` = 768 WHERE `flags` = 2;
	
/* `forwardemoteoneshot` */

UPDATE waypoint_data, waypoint_scripts
SET waypoint_data.forwardemoteoneshot = waypoint_scripts.datalong
WHERE (waypoint_data.action = waypoint_scripts.id and waypoint_scripts.command = 1 and waypoint_scripts.delay = 0 and waypoint_scripts.datalong2 = 0);

/* `forwardemoteid` */

UPDATE waypoint_data, waypoint_scripts
SET waypoint_data.forwardemoteid = waypoint_scripts.datalong
WHERE (waypoint_data.action = waypoint_scripts.id and waypoint_scripts.command = 1 and waypoint_scripts.delay = 0 and waypoint_scripts.datalong2 = 1);

/* TODO: fill `backwardemoteoneshot` */

/* TODO: fill `backwardemoteid` */

/* TODO: fill `forwardskinid` */

ALTER TABLE `waypoint_data` DROP COLUMN `action`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `waypoint_data` TO `creature_waypoints`;

ALTER TABLE `creature_waypoints` ADD PRIMARY KEY (`spawnid`, `waypointid`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `waypoint_data2` TO `waypoint_data`;

DROP TABLE IF EXISTS `creature_addon`;

RENAME TABLE `creature_addon2` TO `creature_addon`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `waypoint_data` ADD PRIMARY KEY (`id`, `point`);

ALTER TABLE `creature_addon` ADD PRIMARY KEY (`guid`);