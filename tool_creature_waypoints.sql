/*
===========================================================
	Title: waypoint_data to creature_waypoints
	
	From TDB: 335.20082
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	[waypoint_data]		[creature_addon]		[creature]
			id -------------> path_id
							  guid ----------------> guid

===========================================================
*/
-- ALTER TABLE `waypoint_data` DISABLE KEYS;

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

-- Now added kickass emu cool columns:
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

-- ALTER TABLE waypoint_data ENABLE KEYS;
 
RENAME TABLE `waypoint_data` TO `creature_waypoints`;