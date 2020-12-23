/*
==============================================
	Title: creature to creature_spawns
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO:
	
	*) research if canfly its used by hovers in arcemu, like that spiders in icc
	*) STANDSTATE_SUBMERGE (not implemented in core)
	*) creature.equipment_id = -1 (random)
	*) death_state
	*) bytes0 (WTF IS THIS?)
	*) npc_respawn_link (THIS IS WORKING?)
	*) channel_spell
	*) channel_target_sqlid
	*) channel_target_sqlid_creature
	
==============================================
*/

DROP TABLE IF EXISTS `creature_spawns`;

--
-- Create a backup of original table(s)...
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
-- Drop not supported columns
--

ALTER TABLE `creature` DROP COLUMN `zoneId`;

ALTER TABLE `creature` DROP COLUMN `areaId`;

ALTER TABLE `creature` DROP COLUMN `spawnMask`;

ALTER TABLE `creature` DROP COLUMN `wander_distance`;

ALTER TABLE `creature` DROP COLUMN `curhealth`;

ALTER TABLE `creature` DROP COLUMN `curmana`;

ALTER TABLE `creature` DROP COLUMN `currentwaypoint`;

ALTER TABLE `creature` DROP COLUMN `ScriptName`;

ALTER TABLE `creature` DROP COLUMN `VerifiedBuild`;

--
-- Drop creature_proto stuff
--

ALTER TABLE `creature` DROP COLUMN `spawntimesecs`;

ALTER TABLE `creature` DROP COLUMN `npcflag`;

--
-- Here we go...
--

-- guid: gona change this to id later (A)

-- id: change this to entry later (B)

ALTER TABLE `creature` CHANGE COLUMN `map` `map` int(30) NOT NULL;

-- phaseMask: change this to phase later (C)

-- modelid: change this to displayid later (D)

-- equipment_id: do nothing for now (E)

ALTER TABLE `creature` CHANGE COLUMN `position_x` `position_x` float NOT NULL AFTER `map`;

ALTER TABLE `creature` CHANGE COLUMN `position_y` `position_y` float NOT NULL AFTER `position_x`;

ALTER TABLE `creature` CHANGE COLUMN `position_z` `position_z` float NOT NULL AFTER `position_y`;

ALTER TABLE `creature` CHANGE COLUMN `orientation` `orientation` float NOT NULL AFTER `position_z`;

ALTER TABLE `creature` CHANGE COLUMN `MovementType` `movetype` int(30) NOT NULL DEFAULT '0' AFTER `orientation`;

-- Now take care of (D)
ALTER TABLE `creature` CHANGE COLUMN  `modelid` `displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `movetype`;

UPDATE creature, creature_template
SET creature.displayid = creature_template.modelid1
WHERE creature.id = creature_template.entry 
AND (creature.displayid = 0 and creature_template.modelid1 != 0 and creature_template.modelid2 = 0 and creature_template.modelid3 = 0 and creature_template.modelid4 = 0);

UPDATE creature, creature_template
SET creature.displayid = creature_template.modelid2
WHERE creature.id = creature_template.entry 
AND (creature.displayid = 0 and creature_template.modelid1 = 0 and creature_template.modelid2 != 0 and creature_template.modelid3 = 0 and creature_template.modelid4 = 0);

UPDATE creature, creature_template
SET creature.displayid = creature_template.modelid3
WHERE creature.id = creature_template.entry 
AND (creature.displayid = 0 and creature_template.modelid1 = 0 and creature_template.modelid2 = 0 and creature_template.modelid3 != 0 and creature_template.modelid4 = 0);

UPDATE creature, creature_template
SET creature.displayid = creature_template.modelid4
WHERE creature.id = creature_template.entry 
AND (creature.displayid = 0 and creature_template.modelid1 = 0 and creature_template.modelid2 = 0 and creature_template.modelid3 = 0 and creature_template.modelid4 != 0);

-- TODO: fill 32000 displayid (got a extra tool for this, need to find a SQL way)

ALTER TABLE `creature` ADD COLUMN `faction` int(30) NOT NULL DEFAULT '14' AFTER `displayid`; -- goin to fill it in (*)

ALTER TABLE `creature` DROP COLUMN `dynamicflags`;

ALTER TABLE `creature` ADD COLUMN `flags` int(30) NOT NULL DEFAULT '0' AFTER `faction`;

UPDATE creature, creature_template
SET creature.flags = creature_template.unit_flags
WHERE creature.id = creature_template.entry;

ALTER TABLE `creature` CHANGE COLUMN `unit_flags` `temp_flags` int(30) NOT NULL DEFAULT '0';

UPDATE `creature` SET `flags` = `temp_flags` WHERE `temp_flags` != 0;

ALTER TABLE `creature` DROP COLUMN `temp_flags`;

ALTER TABLE `creature` ADD COLUMN `bytes0` int(30) NOT NULL DEFAULT '0' AFTER `flags`; -- WTF ARE THIS???

ALTER TABLE `creature` ADD COLUMN `bytes1` int(30) NOT NULL DEFAULT '0' AFTER `bytes0`; -- Stand State

ALTER TABLE `creature` ADD COLUMN `bytes2` int(30) NOT NULL DEFAULT '0' AFTER `bytes1`; -- Sheath Info

ALTER TABLE `creature` ADD COLUMN `emote_state` int(30) NOT NULL DEFAULT '0' AFTER `bytes2`;

ALTER TABLE `creature` ADD COLUMN `npc_respawn_link` int(30) NOT NULL DEFAULT '0' AFTER `emote_state`;

ALTER TABLE `creature` ADD COLUMN `channel_spell` int(30) NOT NULL DEFAULT '0' AFTER `npc_respawn_link`;

ALTER TABLE `creature` ADD COLUMN `channel_target_sqlid` int(30) NOT NULL DEFAULT '0' AFTER `channel_spell`;

ALTER TABLE `creature` ADD COLUMN `channel_target_sqlid_creature` int(30) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid`;

/* standstate (seems to override bytes1):

    STANDSTATE_STAND			 = 0
    STANDSTATE_SIT				 = 1
    STANDSTATE_SIT_CHAIR		 = 2
    STANDSTATE_SLEEP			 = 3
    STANDSTATE_SIT_LOW_CHAIR	 = 4
    STANDSTATE_SIT_MEDIUM_CHAIR  = 5
    STANDSTATE_SIT_HIGH_CHAIR    = 6
    STANDSTATE_DEAD				 = 7
    STANDSTATE_KNEEL			 = 8
	STANDSTATE_SUBMERGE 	     = 9 				// NOT IMPLEMENTED: Submerges the creature below the ground
    STANDSTATE_FORM_ALL          = 0x00FF0000
    STANDSTATE_FLAG_ALWAYS_STAND = 0x01             // byte 4
    STANDSTATE_FLAG_CREEP        = 0x02000000
    STANDSTATE_FLAG_UNTRACKABLE  = 0x04000000
    STANDSTATE_FLAG_ALL          = 0xFF000000
	
	need to test:
	131072 = stealth mode
	33554432 = Hover mode    use this spiders 36725
	50331648 = Hover mode 2
	
*/

ALTER TABLE `creature` ADD COLUMN `standstate` int(10) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid_creature`;

UPDATE creature, creature_addon
SET creature.standstate = creature_addon.bytes1
WHERE creature.guid = creature_addon.guid;

/* death_state:

    CREATURE_STATE_ALIVE 		= 0	// no special death state
    CREATURE_STATE_APPEAR_DEAD  = 1	// these creatures are actually alive but appears as dead for client
    CREATURE_STATE_DEAD 		= 2	// these creatures are dead
	
*/

ALTER TABLE `creature` ADD COLUMN `death_state` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `standstate`;

-- TODO: fill me

ALTER TABLE `creature` ADD COLUMN `mountdisplayid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `death_state`;

ALTER TABLE `creature` ADD COLUMN `slot1item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `mountdisplayid`;

ALTER TABLE `creature` ADD COLUMN `slot2item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot1item`;

ALTER TABLE `creature` ADD COLUMN `slot3item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot2item`;

/* CanFly:

	0: always landed
	1: spawned in air with flying animation
	2: spawned in air with landing animation (on gameobject) aka DisabledGravity on trinity (1)
	
*/

ALTER TABLE `creature` ADD COLUMN `CanFly` smallint(3) NOT NULL DEFAULT '0' AFTER `slot3item`;

UPDATE creature, creature_template_movement
SET creature.CanFly = creature_template_movement.Flight
WHERE creature.id = creature_template_movement.CreatureId;

UPDATE creature, creature_movement_override
SET creature.CanFly = creature_movement_override.Flight
WHERE creature.guid = creature_movement_override.SpawnId;

UPDATE `creature` SET `CanFly` = 3 WHERE `CanFly` = 1; -- This are hovers in TDB

UPDATE `creature` SET `CanFly` = 4 WHERE `CanFly` = 2; -- This are CanFly on TDB

UPDATE `creature` SET `CanFly` = 1 WHERE `CanFly` = 4;

UPDATE `creature` SET `CanFly` = 2 WHERE `CanFly` = 3;

-- Now take care of (C)

ALTER TABLE `creature` CHANGE COLUMN  `phaseMask` `phase` int(10) unsigned NOT NULL DEFAULT '1' AFTER `CanFly`;

-- Lets fill (*)

UPDATE creature, creature_template
SET creature.faction = creature_template.faction 
WHERE creature.id = creature_template.entry;

-- TODO: bytes0

-- bytes1:

UPDATE creature, creature_template_addon
SET creature.bytes1 = creature_template_addon.bytes1
WHERE creature.id = creature_template_addon.entry;

/* bytes2:
	
	STATE_UNARMED = 0    // not prepared weapon
	STATE_MELEE   = 1    // prepared melee weapon
	STATE_RANGED  = 2    // prepared ranged weapon
	              = 4027 // will make the npc hold there items in there hands instead of sheaths.
	not tested:
	Twohands = 256 
	Staffs = 512
	Onehand = 789
	Shields = 1038
	
*/

UPDATE creature, creature_template_addon
SET creature.bytes2 = creature_template_addon.bytes2
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.bytes2 = creature_addon.bytes2
WHERE creature.guid = creature_addon.guid and creature_addon.bytes2 != 0;

-- emote_state:

UPDATE creature, creature_template_addon
SET creature.emote_state = creature_template_addon.emote
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.emote_state = creature_addon.emote
WHERE creature.guid = creature_addon.guid and creature_addon.emote != 0;

-- TODO: `npc_respawn_link`

-- TODO: `channel_spell`

-- TODO: `channel_target_sqlid`

-- TODO: `channel_target_sqlid_creature`

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

-- Take care of (B) and (A)

ALTER TABLE `creature` CHANGE COLUMN `id` `entry` int(30) NOT NULL;

ALTER TABLE `creature` CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT;

--
-- Rename to kickass way
--

RENAME TABLE `creature` TO `creature_spawns`;

ALTER TABLE `creature_spawns` DROP INDEX `idx_map`;

ALTER TABLE `creature_spawns` DROP INDEX `idx_id`;

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