/*
===========================================================
	Title: waypoint_data to creature_waypoints
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	[waypoint_data]		[creature_addon]		[creature]
			id -------------> path_id
							  guid ----------------> guid

===========================================================
*/

DROP TABLE IF EXISTS `creature_waypoints`;

--
-- Create a backup of original table(s)...
--

CREATE TABLE `waypoint_data2` SELECT * FROM `waypoint_data`;

--
-- Here we go...
--

ALTER TABLE `waypoint_data` ADD COLUMN `guid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `id`;

UPDATE waypoint_data, creature_addon
SET waypoint_data.guid = creature_addon.guid 
WHERE waypoint_data.id = creature_addon.path_id;

-- ALTER TABLE `waypoint_data` DROP COLUMN `id`;

ALTER TABLE `waypoint_data` CHANGE COLUMN `point` `waypointid` int(10) unsigned NOT NULL DEFAULT '0';

-- position_x: OK!

-- position_y: OK!

-- position_z: OK!

ALTER TABLE `waypoint_data` DROP COLUMN `orientation`;

ALTER TABLE `waypoint_data` CHANGE COLUMN `delay` `waittime` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `waypoint_data` CHANGE COLUMN `move_type` `flags` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `waypoint_data` DROP COLUMN `action`;

ALTER TABLE `waypoint_data` DROP COLUMN `action_chance`;

ALTER TABLE `waypoint_data` DROP COLUMN `wpguid`;

--
-- Now lets add kickass emu wonderfull columns:
--

ALTER TABLE `waypoint_data` ADD COLUMN `forwardemoteoneshot` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `flags`;

ALTER TABLE `waypoint_data` ADD COLUMN `forwardemoteid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `forwardemoteoneshot`;

ALTER TABLE `waypoint_data` ADD COLUMN `backwardemoteoneshot` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `forwardemoteid`;
 
ALTER TABLE `waypoint_data` ADD COLUMN `backwardemoteid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `backwardemoteoneshot`;

ALTER TABLE `waypoint_data` ADD COLUMN `forwardskinid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `backwardemoteid`;

ALTER TABLE `waypoint_data` ADD COLUMN `backwardskinid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `forwardskinid`;

-- TODO: fill `forwardemoteoneshot`

-- TODO: fill `forwardemoteid`

-- TODO: fill `backwardemoteoneshot`

-- TODO: fill `backwardemoteid`

-- TODO: fill `forwardskinid`

DELETE FROM `waypoint_data` WHERE `guid` = 0;

ALTER TABLE `waypoint_data` CHANGE COLUMN `guid` `spawnid` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `waypoint_data` DROP PRIMARY KEY;

ALTER TABLE `waypoint_data` DROP COLUMN `id`;

--
-- Rename to kickass way
--

RENAME TABLE `waypoint_data` TO `creature_waypoints`;

ALTER TABLE `creature_waypoints` ADD PRIMARY KEY (`spawnid`, `waypointid`);

--
-- Rename our backup table(s)
--

RENAME TABLE `waypoint_data2` TO `waypoint_data`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `waypoint_data` ADD PRIMARY KEY (`id`, `point`);