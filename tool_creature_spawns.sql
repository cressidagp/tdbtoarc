/*
==============================================
	Title: creature to creature_spawns
	
	From TDB: 335.20082
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/
DROP TABLE IF EXISTS `creature_spawns`;

-- Unload all transports:
DELETE FROM `creature` WHERE `map` = 582;
DELETE FROM `creature` WHERE `map` = 584;
DELETE FROM `creature` WHERE `map` = 586;
DELETE FROM `creature` WHERE `map` = 587;
DELETE FROM `creature` WHERE `map` = 588;
DELETE FROM `creature` WHERE `map` = 589;
DELETE FROM `creature` WHERE `map` = 590;
DELETE FROM `creature` WHERE `map` = 591;
DELETE FROM `creature` WHERE `map` = 593;
DELETE FROM `creature` WHERE `map` = 610;
DELETE FROM `creature` WHERE `map` = 612;
DELETE FROM `creature` WHERE `map` = 613;
DELETE FROM `creature` WHERE `map` = 614;
DELETE FROM `creature` WHERE `map` = 620;
DELETE FROM `creature` WHERE `map` = 621;
DELETE FROM `creature` WHERE `map` = 622;
DELETE FROM `creature` WHERE `map` = 623;
DELETE FROM `creature` WHERE `map` = 647;

-- Goodbay events:
DELETE FROM `game_event_creature` WHERE `eventEntry` = 25; -- Lets keep night for now
DELETE FROM `game_event_creature` WHERE `eventEntry` = -25; -- Lets keep night for now

ALTER TABLE `creature` ADD COLUMN `eventEntry` int(4) NOT NULL DEFAULT '0' AFTER `map`;
UPDATE creature, game_event_creature
SET creature.eventEntry = game_event_creature.eventEntry 
WHERE creature.guid = game_event_creature.guid;

DELETE FROM `creature` WHERE `eventEntry` != 0;
ALTER TABLE `creature` DROP COLUMN `eventEntry`;

-- guid: gona change this to id later (A)
-- id: change this to entry later (B)
-- map: OK!
ALTER TABLE `creature` DROP COLUMN `zoneId`;
ALTER TABLE `creature` DROP COLUMN `areaId`;
ALTER TABLE `creature` DROP COLUMN `spawnMask`; -- Not implemented by arcemu
-- phaseMask: change this to phase later (C)
-- modelid: change this to displayid later (D)
-- equipment_id: do nothing for now (E)
ALTER TABLE `creature` CHANGE COLUMN `position_x` `position_x` float NOT NULL AFTER `map`;
ALTER TABLE `creature` CHANGE COLUMN `position_y` `position_y` float NOT NULL AFTER `position_x`;
ALTER TABLE `creature` CHANGE COLUMN `position_z` `position_z` float NOT NULL AFTER `position_y`;
ALTER TABLE `creature` CHANGE COLUMN `orientation` `orientation` float NOT NULL AFTER `position_z`;
ALTER TABLE `creature` DROP COLUMN `spawntimesecs`; -- The respawn time, in seconds, of the creature (not implemented by arcemu)
-- ALTER TABLE `creature` DROP COLUMN `wander_distance`; -- If creature has random waypoints how far he can walk from spawnpoint (not implemented by arcemu)
ALTER TABLE `creature` DROP COLUMN `currentwaypoint`; -- The current waypoint that the creature is on, if any (not implemented by arcemu)
ALTER TABLE `creature` DROP COLUMN `curhealth`; -- The health that the creature will spawn with (not implemented by arcemu, however we have lua)
ALTER TABLE `creature` DROP COLUMN `curmana`; -- The mana that the creature will spawn with (not implemented by arcemu, however we have lua)
ALTER TABLE `creature` CHANGE COLUMN `MovementType` `movetype` int(30) NOT NULL DEFAULT '0' AFTER `orientation`;

-- Now take care of (D)
ALTER TABLE `creature` CHANGE COLUMN  `modelid` `displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `movetype`;

-- Kickass emu have this here, goin to fill it in (*)
ALTER TABLE `creature` ADD COLUMN `faction` int(30) NOT NULL DEFAULT '14' AFTER `displayid`;

ALTER TABLE `creature` DROP COLUMN `npcflag`;
ALTER TABLE `creature` DROP COLUMN `unit_flags`;
ALTER TABLE `creature` CHANGE COLUMN `dynamicflags` `flags` int(30) NOT NULL DEFAULT '0' AFTER `faction`; -- This are arcemu unit_field_flags

ALTER TABLE `creature` ADD COLUMN `bytes0` int(30) NOT NULL DEFAULT '0' AFTER `flags`; -- WTF ARE THIS???
ALTER TABLE `creature` ADD COLUMN `bytes1` int(30) NOT NULL DEFAULT '0' AFTER `bytes0`; -- Stand State
ALTER TABLE `creature` ADD COLUMN `bytes2` int(30) NOT NULL DEFAULT '0' AFTER `bytes1`; -- Sheath Info
ALTER TABLE `creature` ADD COLUMN `emote_state` int(30) NOT NULL DEFAULT '0' AFTER `bytes2`;
ALTER TABLE `creature` ADD COLUMN `npc_respawn_link` int(30) NOT NULL DEFAULT '0' AFTER `emote_state`;
ALTER TABLE `creature` ADD COLUMN `channel_spell` int(30) NOT NULL DEFAULT '0' AFTER `npc_respawn_link`;
ALTER TABLE `creature` ADD COLUMN `channel_target_sqlid` int(30) NOT NULL DEFAULT '0' AFTER `channel_spell`;
ALTER TABLE `creature` ADD COLUMN `channel_target_sqlid_creature` int(30) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid`;
ALTER TABLE `creature` ADD COLUMN `standstate` int(10) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid_creature`;
ALTER TABLE `creature` ADD COLUMN `death_state` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `standstate`;
ALTER TABLE `creature` ADD COLUMN `mountdisplayid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `death_state`;
ALTER TABLE `creature` ADD COLUMN `slot1item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `mountdisplayid`;
ALTER TABLE `creature` ADD COLUMN `slot2item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot1item`;
ALTER TABLE `creature` ADD COLUMN `slot3item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot2item`;
ALTER TABLE `creature` ADD COLUMN `CanFly` smallint(3) NOT NULL DEFAULT '0' AFTER `slot3item`;

-- Now take care of (C)
ALTER TABLE `creature` CHANGE COLUMN  `phaseMask` `phase` int(10) unsigned NOT NULL DEFAULT '1' AFTER `CanFly`;

-- I will keep this since i will try to use it (could be trough core or lua)
ALTER TABLE `creature` CHANGE COLUMN  `wander_distance` `wander_distance` int(10) unsigned NOT NULL DEFAULT '1' AFTER `phase`;
-- ScriptName: leave it be, it wont harm
-- VerifiedBuild: leave it be, it wont harm

-- Lets fill (*)
UPDATE creature, creature_template
SET creature.faction = creature_template.faction 
WHERE creature.id = creature_template.entry;

-- TODO: bytes0

-- bytes1:
UPDATE creature, creature_template_addon
SET creature.bytes1 = creature_template_addon.bytes1
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.bytes1 = creature_addon.bytes1
WHERE creature.guid = creature_addon.guid;

-- bytes2:
UPDATE creature, creature_template_addon
SET creature.bytes2 = creature_template_addon.bytes2
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.bytes2 = creature_addon.bytes2
WHERE creature.guid = creature_addon.guid;

-- emote_state:
UPDATE creature, creature_template_addon
SET creature.emote_state = creature_template_addon.emote
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.emote_state = creature_addon.emote
WHERE creature.guid = creature_addon.guid;

-- TODO: `npc_respawn_link`

-- TODO: `channel_spell`

-- TODO: `channel_target_sqlid`

-- TODO: `channel_target_sqlid_creature`

-- standstate: WTF with this?
-- if bytes1 != standstate will do nothing
-- if bytes1 = sit and standtate = 0 he will sit
-- if bytes1 = 0 and standstate = 1 he will sit -.-
-- so why 2 columns who do the same?

-- TODO: `death_state`

-- mountdisplayid:
UPDATE creature, creature_template_addon
SET creature.mountdisplayid = creature_template_addon.mount
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.mountdisplayid = creature_addon.mount
WHERE creature.guid = creature_addon.guid;

-- Now take care of (E)
UPDATE creature, creature_equip_template
SET creature.slot1item = creature_equip_template.ItemID1
WHERE (creature.id = creature_equip_template.CreatureID AND creature.equipment_id = 1);

UPDATE creature, creature_equip_template
SET creature.slot2item = creature_equip_template.ItemID2
WHERE (creature.id = creature_equip_template.CreatureID AND creature.equipment_id = 1);

UPDATE creature, creature_equip_template
SET creature.slot3item = creature_equip_template.ItemID3
WHERE (creature.id = creature_equip_template.CreatureID AND creature.equipment_id = 1);

-- TODO: creature.equipment_id = -1 (random)

ALTER TABLE `creature` DROP COLUMN `equipment_id`;

-- TODO: CanFly

-- Take care of (B)
ALTER TABLE `creature` CHANGE COLUMN `id` `entry` int(30) NOT NULL;

-- Take care of (A)
ALTER TABLE `creature` CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT;

-- The End: rename to kickass way
RENAME TABLE `creature` TO `creature_spawns`;