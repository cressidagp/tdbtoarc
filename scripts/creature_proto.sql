/*
=================================================

	TDBtoARC

	Title: creature_template to creature_proto
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql

	TODO:
	
	*) extra_a9_flags (not working in arcemu)
	*) spell_flags (not working in arcemu)
	*) summonguard (not working in arcemu)
	*) port to lua rooted of creature_movement_override?
	*) set auras on spawnid

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `creature_proto`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_template2` SELECT * FROM `creature_template`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `creature_template`

	/* #2 */
	DROP COLUMN `difficulty_entry_1`,

	/* #3 */
	DROP COLUMN `difficulty_entry_2`,

	/* #4 */
	DROP COLUMN `difficulty_entry_3`,

	/* #14 */
	DROP COLUMN `gossip_menu_id`,

	/* #17 */
	DROP COLUMN `exp`,

	/* #31 */
	DROP COLUMN `unit_flags2`,

	/* #32 */
	DROP COLUMN `dynamicflags`,

	/* #36 */
	DROP COLUMN `lootid`,

	/* #37 */
	DROP COLUMN `pickpocketloot`,

	/* #38 */
	DROP COLUMN `skinloot`,

	/* #43 */
	DROP COLUMN `AIName`,

	/* #45 */
	DROP COLUMN `HoverHeight`,

	/* #50 */
	DROP COLUMN `ExperienceModifier`,

	/* #53 */
	DROP COLUMN `RegenHealth`,

	/* #55 */
	DROP COLUMN `spell_school_immune_mask`,

	/* #56 */
	DROP COLUMN `flags_extra`,

	/* #57 */
	DROP COLUMN `ScriptName`;

--
--
-- Drop creature_names column(s)
--
--

ALTER TABLE `creature_template`

	/* #5 */
	DROP COLUMN `KillCredit1`,

	/* #6 */
	DROP COLUMN `KillCredit2`,

	/* #8 */
	DROP COLUMN `modelid2`,

	/* #9 */
	DROP COLUMN `modelid3`,

	/* #10 */
	DROP COLUMN `modelid4`,

	/* #11 */
	DROP COLUMN `name`,

	/* #12 */
	DROP COLUMN `subname`,

	/* #13 */
	DROP COLUMN `IconName`,

	/* #33 */
	DROP COLUMN `family`,

	/* #34 */
	DROP COLUMN `type`,

	/* #35 */
	DROP COLUMN `type_flags`,

	/* #51 */
	DROP COLUMN `RacialLeader`,

	/* #52 */
	DROP COLUMN `movementId`;

--
--
-- Drop creature_spawns column(s)
--
--

ALTER TABLE `creature_template` 

	/* #30 */
	DROP COLUMN `unit_flags`,

	/* #44 */
	DROP COLUMN `MovementType`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature_template` 

	CHANGE COLUMN `entry` `entry` int(30) unsigned NOT NULL DEFAULT '0',

	/* modelid1: leave it be for now, will be used. */

	CHANGE COLUMN `minlevel` `minlevel` int(30) unsigned NOT NULL,

	CHANGE COLUMN `maxlevel` `maxlevel` int(30) unsigned NOT NULL,

	CHANGE COLUMN `faction` `faction` int(30) unsigned NOT NULL DEFAULT '0',

	/* Will be filled with precious data in (I) */
	ADD COLUMN `minhealth` int(30) unsigned NOT NULL AFTER `faction`,
	ADD COLUMN `maxhealth` int(30) unsigned NOT NULL AFTER `minhealth`,

	/* Will be filled with precious data in (II) */
	ADD COLUMN `mana` int(30) unsigned NOT NULL DEFAULT '0' AFTER `maxhealth`,
	CHANGE COLUMN `scale` `scale` float NOT NULL DEFAULT '0' AFTER `mana`,
	CHANGE COLUMN `npcflag` `npcflags` int(30) unsigned NOT NULL DEFAULT '0' AFTER `scale`,

	/* speed_walk: do nothing for now, will return later (A) */

	/* speed_run: do nothing for now, will return later (B) */

	CHANGE COLUMN `BaseAttackTime` `attacktime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `npcflags`,
	
	/* rank: do nothing for now, will be used. */

	CHANGE COLUMN `dmgschool` `attacktype` int(4) NOT NULL DEFAULT '0' AFTER `attacktime`,

	/* Will be filled with precious info in (III) */
	ADD COLUMN `mindamage` float NOT NULL DEFAULT '0' AFTER `attacktype`,
	ADD COLUMN `maxdamage` float NOT NULL DEFAULT '0' AFTER `mindamage`,

	/* Will be filled with precious info in (V) */
	ADD COLUMN `can_ranged` int(11) unsigned NOT NULL DEFAULT '0' AFTER `maxdamage`,

	CHANGE COLUMN `RangeAttackTime` `rangedattacktime` int(30) unsigned NOT NULL DEFAULT '0',

	/* Will be filled with precious info in (IV) */
	ADD COLUMN `rangedmindamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedattacktime`,
	ADD COLUMN `rangedmaxdamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedmindamage`,

	/* Will be filled with precious info in (VI) */
	ADD COLUMN `respawntime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `rangedmaxdamage`,

	/* Will be filled with precious info in (VII) */
	ADD COLUMN `armor` int(30) unsigned NOT NULL DEFAULT '0' AFTER `respawntime`,

	/* Lets add kick ass emu wonderfull columns: will return to this in (VIII) */
	ADD COLUMN `resistance1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `armor`,
	ADD COLUMN `resistance2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance1`,
	ADD COLUMN `resistance3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance2`,
	ADD COLUMN `resistance4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance3`,
	ADD COLUMN `resistance5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance4`,
	ADD COLUMN `resistance6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance5`,

	/* More kick ass emu column: return to this in (IX) */
	ADD COLUMN `combat_reach` float NOT NULL DEFAULT '0' AFTER `resistance6`,

	/* And more kick ass emu column: return to this in (X) */
	ADD COLUMN `bounding_radius` float NOT NULL DEFAULT '0' AFTER `combat_reach`,

	/* Even more kick ass emu column: return to this in (XI) */
	ADD COLUMN `auras` longtext NOT NULL AFTER `bounding_radius`,
	
	ADD COLUMN `boss` int(11) unsigned NOT NULL DEFAULT '0' AFTER `auras`,

	/* PetSpellDataId: return to this later (C) */

	/* VehicleId: return to this later (D) */
	
	CHANGE COLUMN `maxgold` `money` int(30) NOT NULL DEFAULT '0' AFTER `boss`,
	
	/* Again... return to this in (XIII) */
	ADD COLUMN `invisibility_type` int(30) unsigned NOT NULL AFTER `money`,
	
	/* Now lets take care of (A) and (B): */
	CHANGE COLUMN `speed_walk` `walk_speed` float NOT NULL DEFAULT '2.5' AFTER `invisibility_type`,
	CHANGE COLUMN `speed_run` `run_speed` float NOT NULL DEFAULT '8' AFTER `walk_speed`,
	
	ADD COLUMN `fly_speed` float NOT NULL DEFAULT '14' AFTER `run_speed`,

	ADD COLUMN `extra_a9_flags` int(30) NOT NULL DEFAULT '0' AFTER `fly_speed`,
	
	/* spell1-8 */
	ADD COLUMN `spell1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `extra_a9_flags`,
	ADD COLUMN `spell2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell1`,
	ADD COLUMN `spell3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell2`,
	ADD COLUMN `spell4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell3`,
	ADD COLUMN `spell5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell4`,
	ADD COLUMN `spell6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell5`,
	ADD COLUMN `spell7` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell6`,
	ADD COLUMN `spell8` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell7`,
	
	ADD COLUMN `spell_flags` int(30) NOT NULL DEFAULT '0' AFTER `spell8`,

	ADD COLUMN `isTrainingDummy` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spell_flags`,

	ADD COLUMN `guardtype` int(10) unsigned NOT NULL DEFAULT '0' AFTER `isTrainingDummy`,

	ADD COLUMN `summonguard` int(10) unsigned NOT NULL DEFAULT '0' AFTER `guardtype`,

	ADD COLUMN `rooted` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`,
	
	/* Now lets take care of (C) and (D): */
	
	CHANGE COLUMN `PetSpellDataId` `spelldataid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`,
	CHANGE COLUMN `VehicleId` `vehicleid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spelldataid`;


/* attacktime: */
UPDATE `creature_template` SET `attacktime` =  `attacktime` * `BaseVariance`;
ALTER TABLE `creature_template` DROP COLUMN `BaseVariance`;

/* rangedattacktime: */
UPDATE `creature_template` SET `rangedattacktime` = `rangedattacktime` * `RangeVariance`;
ALTER TABLE `creature_template` DROP COLUMN `RangeVariance`;

/* Boss:

	0: Normal 
	1: Boss */	
	
UPDATE `creature_template` SET `boss` = 1 WHERE `rank` = 3;

/* money: */
UPDATE `creature_template` SET `money` = (`money` + `mingold`) / 2;
ALTER TABLE `creature_template` DROP COLUMN `mingold`;

/* Now lets take care of (A) and (B): */
UPDATE `creature_template` SET `walk_speed` = `walk_speed` * 2.5;
UPDATE `creature_template` SET `run_speed` = `run_speed` * 7;

/* spells1-8: */
UPDATE creature_template, creature_template_spell
SET creature_template.spell1 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 0);

UPDATE creature_template, creature_template_spell
SET creature_template.spell2 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 1);

UPDATE creature_template, creature_template_spell
SET creature_template.spell3 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 2);

UPDATE creature_template, creature_template_spell
SET creature_template.spell4 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 3);

UPDATE creature_template, creature_template_spell
SET creature_template.spell5 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 4);

UPDATE creature_template, creature_template_spell
SET creature_template.spell6 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 5);

UPDATE creature_template, creature_template_spell
SET creature_template.spell7 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 6);

UPDATE creature_template, creature_template_spell
SET creature_template.spell8 = creature_template_spell.Spell
WHERE (creature_template.entry = creature_template_spell.CreatureID AND creature_template_spell.Index = 7);

UPDATE creature_template, creature_template_movement
SET creature_template.rooted = creature_template_movement.Rooted
WHERE creature_template.entry = creature_template_movement.CreatureId;

/* (I): minhealth */

ALTER TABLE `creature_template` ADD COLUMN `temp_minhealth` int(5) unsigned NOT NULL DEFAULT '1' AFTER `VerifiedBuild`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `minhealth` =  `temp_minhealth` * `HealthModifier`;

/* (I): maxhealth */

ALTER TABLE `creature_template` ADD COLUMN `temp_maxhealth` int(5) unsigned NOT NULL DEFAULT '1' AFTER `temp_minhealth`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxhealth` =  `temp_maxhealth` * `HealthModifier`;

/* (II): mana */

ALTER TABLE `creature_template` ADD COLUMN `temp_mana` int(5) unsigned NOT NULL DEFAULT '0' AFTER `temp_maxhealth`;

-- For Warriors or Rogues:
UPDATE `creature_template` SET `mana` = 0 WHERE `unit_class` = 1 OR `unit_class` = 4;

-- For Paladins (will use min level for them):
UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_mana = creature_classlevelstats.basemana
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.unit_class = 2 AND creature_template.minlevel = creature_classlevelstats.level);

-- For Mages (will use max level for them):
UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_mana = creature_classlevelstats.basemana
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.unit_class = 8 AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `mana` =  `temp_mana` * `ManaModifier`;

/* (III): mindamage */

ALTER TABLE `creature_template` ADD COLUMN `temp_minattackpower` int(5) unsigned NOT NULL DEFAULT '0' AFTER `temp_mana`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `mindamage` =  `temp_minattackpower` * `DamageModifier`;

/* (III): maxdamage */

ALTER TABLE `creature_template` ADD COLUMN `temp_maxattackpower` int(5) unsigned NOT NULL DEFAULT '0' AFTER `temp_minattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxdamage` =  `temp_maxattackpower` * `DamageModifier`;

/* (IV): rangedmindamage */

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmindamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

/* (IV): rangedmaxdamage */

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmaxdamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

/* (V): can_ranged */

UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmindamage` != 0;
UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmaxdamage` != 0;

/* (VI): respawntime */

UPDATE creature_template, creature
SET creature_template.respawntime = creature.spawntimesecs
WHERE creature_template.entry = creature.id;

/* (VII): armor */

ALTER TABLE `creature_template` ADD COLUMN `temp_basearmor` int(5) unsigned NOT NULL DEFAULT '1' AFTER `temp_maxattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_basearmor = creature_classlevelstats.basearmor
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `armor` = `temp_basearmor` * `ArmorModifier`;

/* (VIII): resistance

	ArcEmu = { Holy, Fire, Nature, Frost, Shadow, Arcane } */

UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 3); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 12265 AND `School` = 4); -- (-186)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11666 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11667 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11668 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 8909 AND `School` = 4); -- (-52)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 5); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 6); -- (-93)

/* resistance1-6: */

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance1 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 1);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance2 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 2);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance3 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 3);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance4 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 4);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance5 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 5);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance6 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 6);

/* (IX): combat_reach */

UPDATE creature_template, creature_model_info
SET creature_template.combat_reach = creature_model_info.CombatReach
WHERE creature_template.modelid1 = creature_model_info.DisplayID;

/* (X): bounding_radius */

UPDATE creature_template, creature_model_info
SET creature_template.bounding_radius = creature_model_info.BoundingRadius
WHERE creature_template.modelid1 = creature_model_info.DisplayID;

/* (XI): auras */

UPDATE creature_template_addon SET `auras` = '' WHERE `auras` IS NULL;

UPDATE creature_template, creature_template_addon
SET creature_template.auras = creature_template_addon.auras
WHERE creature_template.entry = creature_template_addon.entry;

/* modImmunities */

ALTER TABLE `creature_template` CHANGE COLUMN `mechanic_immune_mask` `modImmunities` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spell_flags`;

/*	isTrainingDummy

	0: False
	1: True
	
	TDB dont have this.
	
	Got some data in arcemu forums, seems to be OK but it should be more, all credits to KFL.
*/

UPDATE `creature_template` SET `isTrainingDummy` = 1 WHERE `entry` IN ( 32542, 32546, 32666, 31144, 31146, 32545, 32541, 32667, 30527, 32543, 32547 );

/*	guardtype

	0: None
	1: City
	2: Neutral
	
	TDB seems to dont have this.
	
	Got some data in arcemu forums, seems to be OK but it should be more, all credits to KFL. 
*/

UPDATE `creature_template` SET `guardtype` = 1 WHERE `entry` IN ( 68, 1423, 1756, 15858, 15859, 16864, 20556, 18948, 18949, 1642, 3296, 15852, 15853, 15854, 18950, 5624, 18971, 16432, 16733, 18815, 3084, 16221, 17029, 16222, 727, 5595, 12996 );

UPDATE `creature_template` SET `guardtype` = 2 WHERE `entry` IN ( 3502, 4624, 15088, 9460, 11102, 16378, 15184, 11822, 11190, 17855, 18099, 18101, 18102, 20484, 20485, 22494, 23636, 23721, 26253, 24994 );

--
--
-- Cleanup table
--
--

ALTER TABLE `creature_template` 

	DROP COLUMN `temp_minhealth`,

	DROP COLUMN `temp_maxhealth`,

	DROP COLUMN `temp_mana`,

	DROP COLUMN `temp_minattackpower`,

	DROP COLUMN `temp_maxattackpower`,

	DROP COLUMN `temp_basearmor`,

	DROP COLUMN `HealthModifier`,

	DROP COLUMN `ManaModifier`,

	DROP COLUMN `DamageModifier`,

	DROP COLUMN `ArmorModifier`,

	DROP COLUMN `modelid1`,

	DROP COLUMN `rank`,

	DROP COLUMN `unit_class`,

	DROP COLUMN `VerifiedBuild`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_template` TO `creature_proto`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature_template2` TO `creature_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature_template` 

	ADD PRIMARY KEY (`entry`),

	ADD KEY `idx_name` (`name`);