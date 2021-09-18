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
	
	DROP COLUMN `action`,
	
	DROP COLUMN `action_chance`,
	
	DROP COLUMN `wpguid`,
	
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
	
/* TODO: fill `forwardemoteoneshot` */

/* TODO: fill `forwardemoteid` */

/* TODO: fill `backwardemoteoneshot` */

/* TODO: fill `backwardemoteid` */

/* TODO: fill `forwardskinid` */

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

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `waypoint_data` ADD PRIMARY KEY (`id`, `point`);