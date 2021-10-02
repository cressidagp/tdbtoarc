/*
=================================================

	TDBtoARC
	
	Title: creature to creature_spawns
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO:
	
	*) research if canfly its used by hovers in arcemu, like that spiders in icc
	*) STANDSTATE_SUBMERGE (not implemented in core)
	*) creature.equipment_id = -1 (random)
	*) death_state
	*) npc_respawn_link (THIS IS WORKING?)
	*) channel_spell
	*) channel_target_sqlid
	*) channel_target_sqlid_creature
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `creature_spawns`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature2` SELECT * FROM `creature`;

CREATE TABLE `game_event_creature2` SELECT * FROM `game_event_creature`;

--
--
-- Unload all transports
--
--

DELETE FROM `creature` WHERE `map` IN ( 582, 584, 586, 587, 588, 589, 590, 591, 593, 594, 610, 612, 613, 614, 620, 621, 622, 623, 647 );

--
--
-- Goodbay events
--
--

/* Lets keep night for now */
DELETE FROM `game_event_creature` WHERE `eventEntry` = 25;

/* Lets keep night for now */
DELETE FROM `game_event_creature` WHERE `eventEntry` = -25;

/* Add a temp column to mark all event creature except day and night */
ALTER TABLE `creature` ADD COLUMN `eventEntry` int(4) NOT NULL DEFAULT '0' AFTER `map`;

/* Fill our new column */
UPDATE creature, game_event_creature
SET creature.eventEntry = game_event_creature.eventEntry 
WHERE creature.guid = game_event_creature.guid;

/* Remove all marked creatures */
DELETE FROM `creature` WHERE `eventEntry` != 0;

/* Not needed anymore */
ALTER TABLE `creature` DROP COLUMN `eventEntry`;

/* Not needed anymore */
DROP TABLE IF EXISTS `game_event_creature`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `creature` 

	/* #4 */
	DROP COLUMN `zoneId`,

	/* #5 */
	DROP COLUMN `areaId`,

	/* #6 */
	DROP COLUMN `spawnMask`,

	/* #15 */
	DROP COLUMN `wander_distance`,

	/* #16 */
	DROP COLUMN `currentwaypoint`,

	/* #17 */
	DROP COLUMN `curhealth`,

	/* #18 */
	DROP COLUMN `curmana`,

	/* #23 */
	DROP COLUMN `ScriptName`,

	/* #24 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Drop creature_proto column(s)
--
--

ALTER TABLE `creature` 

	/* #14 */
	DROP COLUMN `spawntimesecs`,

	/* #20 */
	DROP COLUMN `npcflag`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature` 

	/* guid: gona change this to id later (A) */

	/* id: change this to entry later (B) */

	CHANGE COLUMN `map` `map` int(30) NOT NULL,

	/* phaseMask: change this to phase later (C) */

	/* modelid: change this to displayid later (D) */

	/* equipment_id: do nothing for now (E) */

	CHANGE COLUMN `position_x` `position_x` float NOT NULL AFTER `map`,

	CHANGE COLUMN `position_y` `position_y` float NOT NULL AFTER `position_x`,

	CHANGE COLUMN `position_z` `position_z` float NOT NULL AFTER `position_y`,

	CHANGE COLUMN `orientation` `orientation` float NOT NULL AFTER `position_z`,

	CHANGE COLUMN `MovementType` `movetype` int(30) NOT NULL DEFAULT '0' AFTER `orientation`,

	/* Now take care of (D): */
	CHANGE COLUMN  `modelid` `displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `movetype`,
	
	/* goin to fill it in (F) */
	ADD COLUMN `faction` int(30) NOT NULL DEFAULT '14' AFTER `displayid`,
	
	DROP COLUMN `dynamicflags`,
	
	ADD COLUMN `flags` int(30) NOT NULL DEFAULT '0' AFTER `faction`,
	
	CHANGE COLUMN `unit_flags` `temp_flags` int(30) NOT NULL DEFAULT '0',
	
	/* unknown */
	ADD COLUMN `bytes0` int(30) NOT NULL DEFAULT '0' AFTER `flags`,
	
	/* Stand State */
	ADD COLUMN `bytes1` int(30) NOT NULL DEFAULT '0' AFTER `bytes0`,
	
	/* Sheath Info: need default 1 here or will have many unarmed dudes. */
	ADD COLUMN `bytes2` int(30) NOT NULL DEFAULT '1' AFTER `bytes1`,

	ADD COLUMN `emote_state` int(30) NOT NULL DEFAULT '0' AFTER `bytes2`,

	ADD COLUMN `npc_respawn_link` int(30) NOT NULL DEFAULT '0' AFTER `emote_state`,

	ADD COLUMN `channel_spell` int(30) NOT NULL DEFAULT '0' AFTER `npc_respawn_link`,

	ADD COLUMN `channel_target_sqlid` int(30) NOT NULL DEFAULT '0' AFTER `channel_spell`,

	ADD COLUMN `channel_target_sqlid_creature` int(30) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid`,
	
	ADD COLUMN `standstate` int(10) NOT NULL DEFAULT '0' AFTER `channel_target_sqlid_creature`,
	
	ADD COLUMN `death_state` tinyint(3) unsigned NOT NULL DEFAULT '0' AFTER `standstate`,

	ADD COLUMN `mountdisplayid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `death_state`,

	ADD COLUMN `slot1item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `mountdisplayid`,

	ADD COLUMN `slot2item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot1item`,

	ADD COLUMN `slot3item` int(10) unsigned NOT NULL DEFAULT '0' AFTER `slot2item`,
	
	ADD COLUMN `CanFly` smallint(3) NOT NULL DEFAULT '0' AFTER `slot3item`,
	
	/* Now take care of (C) */
	CHANGE COLUMN  `phaseMask` `phase` int(10) unsigned NOT NULL DEFAULT '1' AFTER `CanFly`;
	

/* displayid: */	

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

/* flags: */

UPDATE creature, creature_template
SET creature.flags = creature_template.unit_flags
WHERE creature.id = creature_template.entry;

UPDATE `creature` SET `flags` = `temp_flags` WHERE `temp_flags` != 0;

ALTER TABLE `creature` DROP COLUMN `temp_flags`;

/* standstate (seems to override bytes1):

	0: Stand
	1: Sit
	2: Sit chair
	3: Sleep
	4: Sit low chair
	5: Sit medium chair
	6: Sit high chair
	7: Dead
	8: Kneel
	9: Submerge (not implemented)
	0x00FF0000: Form all
	0x01: Flag always stand
	0x02000000: Flag creep
	0x04000000: Flag untrackable
	0xFF000000: Flag all
	
	need test:
	
	131072: Stealth mode
	33554432: Hover mode (like spiders 36725?)
	50331648: Hover mode 2 */

UPDATE creature, creature_addon
SET creature.standstate = creature_addon.bytes1
WHERE creature.guid = creature_addon.guid;

/* death_state:

    0: Alive
    1: Appear dead
    2: Dead */

/* CanFly:

	0: always landed
	1: spawned in air with flying animation
	2: spawned in air with landing animation (on gameobject) aka DisabledGravity on trinity (1) */

UPDATE creature, creature_template_movement
SET creature.CanFly = creature_template_movement.Flight
WHERE creature.id = creature_template_movement.CreatureId;

UPDATE creature, creature_movement_override
SET creature.CanFly = creature_movement_override.Flight
WHERE creature.guid = creature_movement_override.SpawnId;

/* This are hovers in TDB */
UPDATE `creature` SET `CanFly` = 3 WHERE `CanFly` = 1;

/* This are CanFly on TDB */
UPDATE `creature` SET `CanFly` = 4 WHERE `CanFly` = 2;

UPDATE `creature` SET `CanFly` = 1 WHERE `CanFly` = 4;

UPDATE `creature` SET `CanFly` = 2 WHERE `CanFly` = 3;

/* (F) Faction: */

UPDATE creature, creature_template
SET creature.faction = creature_template.faction 
WHERE creature.id = creature_template.entry;

/* bytes0: */

UPDATE creature, creature_template
SET creature.bytes0 = 1
WHERE (creature.id = creature_template.entry AND creature_template.unit_class = 1);

UPDATE creature, creature_template
SET creature.bytes0 = 2
WHERE (creature.id = creature_template.entry AND creature_template.unit_class = 2);

UPDATE creature, creature_template
SET creature.bytes0 = 4
WHERE (creature.id = creature_template.entry AND creature_template.unit_class = 4);

UPDATE creature, creature_template
SET creature.bytes0 = 8
WHERE (creature.id = creature_template.entry AND creature_template.unit_class = 8);

UPDATE creature, creature_model_info
SET creature.bytes0 = 256
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 1 AND creature_model_info.Gender = 0);

UPDATE creature, creature_model_info
SET creature.bytes0 = 65792
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 1 AND creature_model_info.Gender = 1);

UPDATE creature, creature_model_info
SET creature.bytes0 = 131328
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 1 AND creature_model_info.Gender = 2);

UPDATE creature, creature_model_info
SET creature.bytes0 = 512
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 2 AND creature_model_info.Gender = 0);

UPDATE creature, creature_model_info
SET creature.bytes0 = 66048
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 2 AND creature_model_info.Gender = 1);

UPDATE creature, creature_model_info
SET creature.bytes0 = 131584
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 2 AND creature_model_info.Gender = 2);

UPDATE creature, creature_model_info
SET creature.bytes0 = 1024
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 4 AND creature_model_info.Gender = 0);

UPDATE creature, creature_model_info
SET creature.bytes0 = 66560
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 4 AND creature_model_info.Gender = 1);

UPDATE creature, creature_model_info
SET creature.bytes0 = 132096
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 4 AND creature_model_info.Gender = 2);

UPDATE creature, creature_model_info
SET creature.bytes0 = 2048
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 8 AND creature_model_info.Gender = 0);

UPDATE creature, creature_model_info
SET creature.bytes0 = 67584
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 8 AND creature_model_info.Gender = 1);

UPDATE creature, creature_model_info
SET creature.bytes0 = 133120
WHERE (creature.displayid = creature_model_info.DisplayID AND creature.bytes0 = 8 AND creature_model_info.Gender = 2);

/* bytes1: */

UPDATE creature, creature_template_addon
SET creature.bytes1 = creature_template_addon.bytes1
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.bytes1 = creature_addon.bytes1
WHERE creature.guid = creature_addon.guid;

/* bytes2:
	
	0: Unarmed
	1: Melee
	2: Ranged
	4027: will make the npc hold there items in there hands instead of sheaths.
	
	not tested:
	
	256: Twohands 
	512: Staffs
	789: Onehand
	1038: Shields */

UPDATE creature, creature_template_addon
SET creature.bytes2 = creature_template_addon.bytes2
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.bytes2 = creature_addon.bytes2
WHERE creature.guid = creature_addon.guid;

/* emote_state: */

UPDATE creature, creature_template_addon
SET creature.emote_state = creature_template_addon.emote
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.emote_state = creature_addon.emote
WHERE creature.guid = creature_addon.guid;

/* channel_spell: */

ALTER TABLE `creature` CHANGE COLUMN `guid` `guid` int(30) NOT NULL DEFAULT '0';

UPDATE `creature` SET `guid` = `guid` * (-1);

UPDATE creature, smart_scripts
SET creature.channel_spell = smart_scripts.action_param1
WHERE (creature.guid = smart_scripts.entryorguid AND source_type = 0 AND smart_scripts.event_type = 1 AND smart_scripts.action_type = 11 AND (target_type = 10 OR target_type = 14));

UPDATE `creature` SET `guid` = `guid` * (-1);

/* mountdisplayid: */

UPDATE creature, creature_template_addon
SET creature.mountdisplayid = creature_template_addon.mount
WHERE creature.id = creature_template_addon.entry;

UPDATE creature, creature_addon
SET creature.mountdisplayid = creature_addon.mount
WHERE creature.guid = creature_addon.guid;

/* Now take care of (E): */

UPDATE creature, creature_equip_template
SET creature.slot1item = creature_equip_template.ItemID1
WHERE (creature.id = creature_equip_template.CreatureID and creature.equipment_id = 1);

UPDATE creature, creature_equip_template
SET creature.slot2item = creature_equip_template.ItemID2
WHERE (creature.id = creature_equip_template.CreatureID and creature.equipment_id = 1);
UPDATE creature, creature_equip_template

SET creature.slot3item = creature_equip_template.ItemID3
WHERE (creature.id = creature_equip_template.CreatureID and creature.equipment_id = 1);

ALTER TABLE `creature` DROP COLUMN `equipment_id`;

/* Take care of (B) and (A): */

ALTER TABLE `creature` 

	CHANGE COLUMN `id` `entry` int(30) NOT NULL,
	
	CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature` TO `creature_spawns`;

ALTER TABLE `creature_spawns` 

	DROP INDEX `idx_map`,

	DROP INDEX `idx_id`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE 

	`creature2` TO `creature`,

	`game_event_creature2` TO `game_event_creature`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature` 

	ADD PRIMARY KEY (`guid`),

	ADD KEY `idx_map` (`map`),

	ADD KEY `idx_id` (`id`);
	

ALTER TABLE `game_event_creature` ADD PRIMARY KEY (`guid`,`eventEntry`);