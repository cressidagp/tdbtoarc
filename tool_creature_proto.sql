/*
==============================================
	Title: creature_template to creature_proto
	
	From TDB: 335.20101
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

	TODO:
	
	*) extra_a9_flags (not working in arcemu)
	*) spell_flags (not working in arcemu)
	*) isTrainingDummy (got some data in arcemu forums)
	*) guardtype (got some data in arcemu forums)
	*) summonguard

==============================================
*/

DROP TABLE IF EXISTS `creature_proto`;

--
-- Create a backup of original table...
--

CREATE TABLE `creature_template2` SELECT * FROM `creature_template`;

--
-- Drop not supported columns
--

ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_1`;

ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_2`;

ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_3`;

ALTER TABLE `creature_template` DROP COLUMN `exp`;

ALTER TABLE `creature_template` DROP COLUMN `RegenHealth`;

ALTER TABLE `creature_template` DROP COLUMN `HoverHeight`;

ALTER TABLE `creature_template` DROP COLUMN `AIName`;

ALTER TABLE `creature_template` DROP COLUMN `ScriptName`;

ALTER TABLE `creature_template` DROP COLUMN `ExperienceModifier`;

--
-- Drop creature_names stuff
--

ALTER TABLE `creature_template` DROP COLUMN `KillCredit1`;

ALTER TABLE `creature_template` DROP COLUMN `KillCredit2`;

ALTER TABLE `creature_template` DROP COLUMN `modelid2`;

ALTER TABLE `creature_template` DROP COLUMN `modelid3`;

ALTER TABLE `creature_template` DROP COLUMN `modelid4`;

ALTER TABLE `creature_template` DROP COLUMN `name`;

ALTER TABLE `creature_template` DROP COLUMN `subname`;

ALTER TABLE `creature_template` DROP COLUMN `IconName`;

ALTER TABLE `creature_template` DROP COLUMN `family`;

ALTER TABLE `creature_template` DROP COLUMN `RacialLeader`;

ALTER TABLE `creature_template` DROP COLUMN `type_flags`;

ALTER TABLE `creature_template` DROP COLUMN `type`;

ALTER TABLE `creature_template` DROP COLUMN `movementId`;

--
-- Here we go...
--

ALTER TABLE `creature_template` CHANGE COLUMN `entry` `entry` int(30) unsigned NOT NULL DEFAULT '0';

-- modelid1: leave it be for now, will be used.

ALTER TABLE `creature_template` DROP COLUMN `gossip_menu_id`;

ALTER TABLE `creature_template` CHANGE COLUMN `minlevel` `minlevel` int(30) unsigned NOT NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `maxlevel` `maxlevel` int(30) unsigned NOT NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `faction` `faction` int(30) unsigned NOT NULL DEFAULT '0';

-- Will be filled with precious data in (I)

ALTER TABLE `creature_template` ADD COLUMN `minhealth` int(30) unsigned NOT NULL AFTER `faction`;

ALTER TABLE `creature_template` ADD COLUMN `maxhealth` int(30) unsigned NOT NULL AFTER `minhealth`;

-- Will be filled with precious data in (II)

ALTER TABLE `creature_template` ADD COLUMN `mana` int(30) unsigned NOT NULL DEFAULT '0' AFTER `maxhealth`;

ALTER TABLE `creature_template` CHANGE COLUMN `scale` `scale` float NOT NULL DEFAULT '0' AFTER `mana`;

ALTER TABLE `creature_template` CHANGE COLUMN `npcflag` `npcflags` int(30) unsigned NOT NULL DEFAULT '0' AFTER `scale`;

-- speed_walk: do nothing for now, will return later (A)

-- speed_run: do nothing for now, will return later (B)

ALTER TABLE `creature_template` CHANGE COLUMN `BaseAttackTime` `attacktime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `npcflags`;

UPDATE `creature_template` SET `attacktime` =  `attacktime` * `BaseVariance`;

-- rank: do nothing for now, will be used. 

ALTER TABLE `creature_template` CHANGE COLUMN `dmgschool` `attacktype` int(4) NOT NULL DEFAULT '0' AFTER `attacktime`;

-- Will be filled with precious info in (III)

ALTER TABLE `creature_template` ADD COLUMN `mindamage` float NOT NULL DEFAULT '0' AFTER `attacktype`;

ALTER TABLE `creature_template` ADD COLUMN `maxdamage` float NOT NULL DEFAULT '0' AFTER `mindamage`;

-- Will be filled with precious info in (V)

ALTER TABLE `creature_template` ADD COLUMN `can_ranged` int(11) unsigned NOT NULL DEFAULT '0' AFTER `maxdamage`;

ALTER TABLE `creature_template` CHANGE COLUMN `RangeAttackTime` `rangedattacktime` int(30) unsigned NOT NULL DEFAULT '0';

UPDATE `creature_template` SET `rangedattacktime` = `rangedattacktime` * `RangeVariance`;

-- Will be filled with precious info in (IV)

ALTER TABLE `creature_template` ADD COLUMN `rangedmindamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedattacktime`;

ALTER TABLE `creature_template` ADD COLUMN `rangedmaxdamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedmindamage`;

-- Will be filled with precious info in (VI)

ALTER TABLE `creature_template` ADD COLUMN `respawntime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `rangedmaxdamage`;

-- Will be filled with precious info in (VII)

ALTER TABLE `creature_template` ADD COLUMN `armor` int(30) unsigned NOT NULL DEFAULT '0' AFTER `respawntime`;

-- Lets add kick ass emu wonderfull columns: will return to this in (VIII)

ALTER TABLE `creature_template` ADD COLUMN `resistance1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `armor`;
ALTER TABLE `creature_template` ADD COLUMN `resistance2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance1`;
ALTER TABLE `creature_template` ADD COLUMN `resistance3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance2`;
ALTER TABLE `creature_template` ADD COLUMN `resistance4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance3`;
ALTER TABLE `creature_template` ADD COLUMN `resistance5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance4`;
ALTER TABLE `creature_template` ADD COLUMN `resistance6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance5`;

-- More kick ass emu column: return to this in (IX)

ALTER TABLE `creature_template` ADD COLUMN `combat_reach` float NOT NULL DEFAULT '0' AFTER `resistance6`;

-- And more kick ass emu column: return to this in (X)

ALTER TABLE `creature_template` ADD COLUMN `bounding_radius` float NOT NULL DEFAULT '0' AFTER `combat_reach`;

-- Even more kick ass emu column: return to this in (XI)

ALTER TABLE `creature_template` ADD COLUMN `auras` longtext NOT NULL AFTER `bounding_radius`;

/* Boss:

	Normal = 0
	Boss = 1
*/

ALTER TABLE `creature_template` ADD COLUMN `boss` int(11) unsigned NOT NULL DEFAULT '0' AFTER `auras`;

UPDATE `creature_template` SET `boss` = 1 WHERE `rank` = 3;

ALTER TABLE `creature_template` DROP COLUMN `BaseVariance`;

ALTER TABLE `creature_template` DROP COLUMN `RangeVariance`;

--ALTER TABLE `creature_template` DROP COLUMN `unit_class`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags2`;

ALTER TABLE `creature_template` DROP COLUMN `dynamicflags`;

ALTER TABLE `creature_template` DROP COLUMN `lootid`;

ALTER TABLE `creature_template` DROP COLUMN `pickpocketloot`;

ALTER TABLE `creature_template` DROP COLUMN `skinloot`;

-- PetSpellDataId: return to this later (C)

-- VehicleId: return to this later (D)

ALTER TABLE `creature_template` DROP COLUMN `mingold`;

ALTER TABLE `creature_template` CHANGE COLUMN `maxgold` `money` int(30) NOT NULL DEFAULT '0' AFTER `boss`;

-- Again... return to this in (XIII)

ALTER TABLE `creature_template` ADD COLUMN `invisibility_type` int(30) unsigned NOT NULL AFTER `money`;

-- Now lets take care of (A) and (B):

ALTER TABLE `creature_template` CHANGE COLUMN `speed_walk` `walk_speed` float NOT NULL DEFAULT '2.5' AFTER `invisibility_type`;

ALTER TABLE `creature_template` CHANGE COLUMN `speed_run` `run_speed` float NOT NULL DEFAULT '8' AFTER `walk_speed`;

UPDATE `creature_template` SET `walk_speed` = '2.5' WHERE `walk_speed` = 1;

-- And again... return to this in (XIV)

ALTER TABLE `creature_template` ADD COLUMN `fly_speed` float NOT NULL DEFAULT '14' AFTER `run_speed`;

ALTER TABLE `creature_template` ADD COLUMN `extra_a9_flags` int(30) NOT NULL DEFAULT '0' AFTER `fly_speed`;

-- And yet... (XVI)

ALTER TABLE `creature_template` ADD COLUMN `spell1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `extra_a9_flags`;
ALTER TABLE `creature_template` ADD COLUMN `spell2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell1`;
ALTER TABLE `creature_template` ADD COLUMN `spell3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell2`;
ALTER TABLE `creature_template` ADD COLUMN `spell4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell3`;
ALTER TABLE `creature_template` ADD COLUMN `spell5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell4`;
ALTER TABLE `creature_template` ADD COLUMN `spell6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell5`;
ALTER TABLE `creature_template` ADD COLUMN `spell7` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell6`;
ALTER TABLE `creature_template` ADD COLUMN `spell8` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell7`;
ALTER TABLE `creature_template` ADD COLUMN `spell_flags` int(30) NOT NULL DEFAULT '0' AFTER `spell8`;

-- JESUS... (XVII)
ALTER TABLE `creature_template` ADD COLUMN `isTrainingDummy` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spell_flags`;

-- Light save my soul... (XIII)
ALTER TABLE `creature_template` ADD COLUMN `guardtype` int(10) unsigned NOT NULL DEFAULT '0' AFTER `isTrainingDummy`;

-- Almost there (XIX)
ALTER TABLE `creature_template` ADD COLUMN `summonguard` int(10) unsigned NOT NULL DEFAULT '0' AFTER `guardtype`;

ALTER TABLE `creature_template` DROP COLUMN `MovementType`;

-- ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `ArmorModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `mechanic_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `spell_school_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `flags_extra`;

-- Last one (XX)
ALTER TABLE `creature_template` ADD COLUMN `rooted` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`;

-- Now lets take care of (C) and (D):
ALTER TABLE `creature_template` CHANGE COLUMN `PetSpellDataId` `spelldataid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`;
ALTER TABLE `creature_template` CHANGE COLUMN `VehicleId` `vehicleid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spelldataid`;

-- (I): Fill `minhealth` with data:

ALTER TABLE `creature_template` ADD COLUMN `temp_minhealth` int(5) unsigned NOT NULL DEFAULT '1' AFTER `VerifiedBuild`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `minhealth` =  `temp_minhealth` * `HealthModifier`;

-- (I): Fill `maxhealth` with data:

ALTER TABLE `creature_template` ADD COLUMN `temp_maxhealth` int(5) unsigned NOT NULL DEFAULT '1' AFTER `temp_minhealth`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxhealth` =  `temp_maxhealth` * `HealthModifier`;

-- (II): Fill `mana` with data:

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

-- (III): `mindamage`

ALTER TABLE `creature_template` ADD COLUMN `temp_minattackpower` int(5) unsigned NOT NULL DEFAULT '0' AFTER `temp_mana`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `mindamage` =  `temp_minattackpower` * `DamageModifier`;

-- (III): `maxdamage`

ALTER TABLE `creature_template` ADD COLUMN `temp_maxattackpower` int(5) unsigned NOT NULL DEFAULT '0' AFTER `temp_minattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxdamage` =  `temp_maxattackpower` * `DamageModifier`;

-- (IV): `rangedmindamage`

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmindamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

-- (IV): `rangedmaxdamage`

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmaxdamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

-- (V): `can_ranged`

UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmindamage` != 0;
UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmaxdamage` != 0;

-- (VI): `respawntime`

UPDATE creature_template, creature
SET creature_template.respawntime = creature.spawntimesecs
WHERE creature_template.entry = creature.id;

-- (VII): `armor`

ALTER TABLE `creature_template` ADD COLUMN `temp_basearmor` int(5) unsigned NOT NULL DEFAULT '1' AFTER `temp_maxattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_basearmor = creature_classlevelstats.basearmor
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `armor` = `temp_basearmor` * `ArmorModifier`;

-- (VIII): resistance
-- ArcEmu = { Holy, Fire, Nature, Frost, Shadow, Arcane }
-- TDB same enum?

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance1 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 1);

UPDATE creature_template, creature_template_resistance
SET creature_template.resistance2 = creature_template_resistance.Resistance
WHERE (creature_template.entry = creature_template_resistance.CreatureID AND creature_template_resistance.School = 2);

-- TEMPORARY BYPASS (TDB BUG???)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 3); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 12265 AND `School` = 4); -- (-186)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11666 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11667 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11668 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 4); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 8909 AND `School` = 4); -- (-52)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 5); -- (-93)
UPDATE `creature_template_resistance` SET `Resistance` = 0 WHERE (`CreatureID` = 11664 AND `School` = 6); -- (-93)

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

-- (IX): `combat_reach`

UPDATE creature_template, creature_model_info
SET creature_template.combat_reach = creature_model_info.CombatReach
WHERE creature_template.modelid1 = creature_model_info.DisplayID;

-- (X): `bounding_radius`

UPDATE creature_template, creature_model_info
SET creature_template.bounding_radius = creature_model_info.BoundingRadius
WHERE creature_template.modelid1 = creature_model_info.DisplayID;

-- (XI): `auras`

UPDATE creature_template_addon SET `auras` = '' WHERE `auras` IS NULL;

UPDATE creature_template, creature_template_addon
SET creature_template.auras = creature_template_addon.auras
WHERE creature_template.entry = creature_template_addon.entry;

-- TODO: set auras on spawnid (arcemu dont have this... go in lua?)

-- (XIII): `invisibility_type` ( TODO )
-- Aparantly TDB didnt have this

-- (XIV): `fly_speed` ( TODO )
-- Aparantly TDB didnt have this

-- (XVI): spell

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

-- `modImmunities`

ALTER TABLE `creature_template` CHANGE COLUMN `mechanic_immune_mask` `modImmunities` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spell_flags`;

/* (XVII): isTrainingDummy

	TRUE  = 1
	FALSE = 0
	
	TDB seems to dont have this.
	
	Got some data in arcemu forums, seems to be OK but it should be more, all credits to KFL. (Need to confirm this one 32547)
*/

UPDATE `creature_proto` SET `isTrainingDummy` = 1 WHERE `entry` 
IN (32542,32546,32666,31144,31146,32545,32541,32667,30527,32543,32547);

/* (XIII): guardtype

    GUARDTYPE_NONE    = 0
    GUARDTYPE_CITY    = 1
    GUARDTYPE_NEUTRAL = 2
	
	TDB seems to dont have this.
	
	Got some data in arcemu forums, seems to be OK but it should be more, all credits to KFL.
*/

UPDATE `creature_proto` SET `guardtype` = 1 WHERE `entry` 
IN (68,1423,1756,15858,15859,16864,20556,18948,18949,1642,3296,15852,15853,15854,18950,5624,18971,16432,16733,18815,3084,16221,17029,16222,727,5595,12996);

UPDATE `creature_proto` SET `guardtype` = 2 WHERE `entry` 
IN (3502,4624,15088,9460,11102,16378,15184,11822,11190,17855,18099,18101,18102,20484,20485,22494,23636,23721,26253,24994);

-- (XIX): `summonguard`
-- TDB seems to dont have this

-- (XX): `rooted`

UPDATE creature_template, creature_template_movement
SET creature_template.rooted = creature_template_movement.Rooted
WHERE creature_template.entry = creature_template_movement.CreatureId;

-- TODO: port to lua rooted of creature_movement_override?

--
-- Cleanups:
--

ALTER TABLE `creature_template` DROP COLUMN `temp_minhealth`;
ALTER TABLE `creature_template` DROP COLUMN `temp_maxhealth`;
ALTER TABLE `creature_template` DROP COLUMN `temp_mana`;
ALTER TABLE `creature_template` DROP COLUMN `temp_minattackpower`;
ALTER TABLE `creature_template` DROP COLUMN `temp_maxattackpower`;
ALTER TABLE `creature_template` DROP COLUMN `temp_basearmor`;
ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;
ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;
ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;
ALTER TABLE `creature_template` DROP COLUMN `ArmorModifier`;
ALTER TABLE `creature_template` DROP COLUMN `modelid1`;
ALTER TABLE `creature_template` DROP COLUMN `rank`;
ALTER TABLE `creature_template` DROP COLUMN `unit_class`;
ALTER TABLE `creature_template` DROP COLUMN `VerifiedBuild`;

--
-- The End: rename to kickass way
--

RENAME TABLE `creature_template` TO `creature_proto`;

ALTER TABLE `creature_proto` ADD PRIMARY KEY (`entry`);

--
-- Rename our backup table
--

RENAME TABLE `creature_template2` TO `creature_template`;