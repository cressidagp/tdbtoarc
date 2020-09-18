/*
==============================================
	Title: creature_template to creature_proto
	
	From TDB: 335.20092
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/
DROP TABLE IF EXISTS `creature_proto`;

ALTER TABLE `creature_template` CHANGE COLUMN `entry` `entry` int(30) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_1`;
ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_2`;
ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_3`;

ALTER TABLE `creature_template` DROP COLUMN `KillCredit1`;
ALTER TABLE `creature_template` DROP COLUMN `KillCredit2`;

ALTER TABLE `creature_template` DROP COLUMN `modelid1`;
ALTER TABLE `creature_template` DROP COLUMN `modelid2`;
ALTER TABLE `creature_template` DROP COLUMN `modelid3`;
ALTER TABLE `creature_template` DROP COLUMN `modelid4`;

ALTER TABLE `creature_template` DROP COLUMN `name`;

ALTER TABLE `creature_template` DROP COLUMN `subname`;

ALTER TABLE `creature_template` DROP COLUMN `IconName`;

ALTER TABLE `creature_template` DROP COLUMN `gossip_menu_id`;

ALTER TABLE `creature_template` CHANGE COLUMN `minlevel` `minlevel` int(30) unsigned NOT NULL;
ALTER TABLE `creature_template` CHANGE COLUMN `maxlevel` `maxlevel` int(30) unsigned NOT NULL;

ALTER TABLE `creature_template` DROP COLUMN `exp`;

ALTER TABLE `creature_template` CHANGE COLUMN `faction` `faction` int(30) unsigned NOT NULL DEFAULT '0';

-- Will be filled with precious data in (I)
ALTER TABLE `creature_template` ADD COLUMN `minhealth` int(30) unsigned NOT NULL AFTER `faction`;
ALTER TABLE `creature_template` ADD COLUMN `maxhealth` int(30) unsigned NOT NULL AFTER `minhealth`;

-- Will be filled with precious data in (II):
ALTER TABLE `creature_template` ADD COLUMN `mana` int(30) unsigned NOT NULL DEFAULT '0' AFTER `maxhealth`;

ALTER TABLE `creature_template` CHANGE COLUMN `scale` `scale` float NOT NULL DEFAULT '0' AFTER `mana`;

ALTER TABLE `creature_template` CHANGE COLUMN `npcflag` `npcflags` int(30) unsigned NOT NULL DEFAULT '0' AFTER `scale`;

-- speed_walk: do nothing for now, will return later (A)

-- speed_run: do nothing for now, will return later (B)

ALTER TABLE `creature_template` CHANGE COLUMN `BaseAttackTime` `attacktime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `npcflags`;
UPDATE `creature_template` SET `attacktime` =  `attacktime` * `BaseVariance`;

ALTER TABLE `creature_template` DROP COLUMN `rank`;

ALTER TABLE `creature_template` CHANGE COLUMN `dmgschool` `attacktype` int(4) NOT NULL DEFAULT '0' AFTER `attacktime`;

-- Will be filled with precious info in (III):
ALTER TABLE `creature_template` ADD COLUMN `mindamage` float NOT NULL DEFAULT '0' AFTER `attacktype`;
ALTER TABLE `creature_template` ADD COLUMN `maxdamage` float NOT NULL DEFAULT '0' AFTER `mindamage`;

-- Will be filled with precious info in (V):
ALTER TABLE `creature_template` ADD COLUMN `can_ranged` int(11) unsigned NOT NULL DEFAULT '0' AFTER `maxdamage`;

ALTER TABLE `creature_template` CHANGE COLUMN `RangeAttackTime` `rangedattacktime` int(30) unsigned NOT NULL DEFAULT '0';
UPDATE `creature_template` SET `rangedattacktime` =  `rangedattacktime` * `RangeVariance`;

-- Will be filled with precious info in (IV):
ALTER TABLE `creature_template` ADD COLUMN `rangedmindamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedattacktime`;
ALTER TABLE `creature_template` ADD COLUMN `rangedmaxdamage` float unsigned NOT NULL DEFAULT '0' AFTER `rangedmindamage`;

-- Will be filled with precious info in (VII):
ALTER TABLE `creature_template` ADD COLUMN `respawntime` int(30) unsigned NOT NULL DEFAULT '0' AFTER `rangedmaxdamage`;

-- Will be filled with precious info in (VIII):
ALTER TABLE `creature_template` ADD COLUMN `armor` int(30) unsigned NOT NULL DEFAULT '0' AFTER `respawntime`;

-- Lets add kick ass emu wonderfull columns: will return to this in (IX)
ALTER TABLE `creature_template` ADD COLUMN `resistance1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `armor`;
ALTER TABLE `creature_template` ADD COLUMN `resistance2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance1`;
ALTER TABLE `creature_template` ADD COLUMN `resistance3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance2`;
ALTER TABLE `creature_template` ADD COLUMN `resistance4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance3`;
ALTER TABLE `creature_template` ADD COLUMN `resistance5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance4`;
ALTER TABLE `creature_template` ADD COLUMN `resistance6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `resistance5`;

-- More kick ass emu column: return to this in (X)
ALTER TABLE `creature_template` ADD COLUMN `combat_reach` float NOT NULL DEFAULT '0' AFTER `resistance6`;

-- And more kick ass emu column: return to this in (XI)
ALTER TABLE `creature_template` ADD COLUMN `bounding_radius` float NOT NULL DEFAULT '0' AFTER `combat_reach`;

-- Even more kick ass emu column: return to this in (XII)
ALTER TABLE `creature_template` ADD COLUMN `auras` longtext NOT NULL AFTER `bounding_radius`;

-- Never ending story: return to this in (XIII)
ALTER TABLE `creature_template` ADD COLUMN `boss` int(11) unsigned NOT NULL DEFAULT '0' AFTER `auras`;

ALTER TABLE `creature_template` DROP COLUMN `BaseVariance`;

ALTER TABLE `creature_template` DROP COLUMN `RangeVariance`;

--ALTER TABLE `creature_template` DROP COLUMN `unit_class`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags2`;

ALTER TABLE `creature_template` DROP COLUMN `dynamicflags`;

ALTER TABLE `creature_template` DROP COLUMN `family`;

ALTER TABLE `creature_template` DROP COLUMN `type`;

ALTER TABLE `creature_template` DROP COLUMN `type_flags`;

ALTER TABLE `creature_template` DROP COLUMN `lootid`;

ALTER TABLE `creature_template` DROP COLUMN `pickpocketloot`;

ALTER TABLE `creature_template` DROP COLUMN `skinloot`;

-- PetSpellDataId: return to this later (C)

-- VehicleId: return to this later (D)

ALTER TABLE `creature_template` DROP COLUMN `mingold`;

ALTER TABLE `creature_template` CHANGE COLUMN `maxgold` `money` int(30) NOT NULL DEFAULT '0' AFTER `boss`;

-- Again... return to this in (XIV)
ALTER TABLE `creature_template` ADD COLUMN `invisibility_type` int(30) unsigned NOT NULL AFTER `money`;

-- Now lets take care of (A) and (B):
ALTER TABLE `creature_template` CHANGE COLUMN `speed_walk` `walk_speed` float NOT NULL DEFAULT '2.5' AFTER `invisibility_type`;
ALTER TABLE `creature_template` CHANGE COLUMN `speed_run` `run_speed` float NOT NULL DEFAULT '8' AFTER `walk_speed`;

-- And again... return to this in (XV)
ALTER TABLE `creature_template` ADD COLUMN `fly_speed` float NOT NULL DEFAULT '14' AFTER `run_speed`;

-- More pain... return to this in (XVI)
ALTER TABLE `creature_template` ADD COLUMN `extra_a9_flags`  int(30) NOT NULL DEFAULT '0' AFTER `fly_speed`;

-- And yet... (XVII)
ALTER TABLE `creature_template` ADD COLUMN `spell1` int(30) unsigned NOT NULL DEFAULT '0' AFTER `extra_a9_flags`;
ALTER TABLE `creature_template` ADD COLUMN `spell2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell1`;
ALTER TABLE `creature_template` ADD COLUMN `spell3` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell2`;
ALTER TABLE `creature_template` ADD COLUMN `spell4` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell3`;
ALTER TABLE `creature_template` ADD COLUMN `spell5` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell4`;
ALTER TABLE `creature_template` ADD COLUMN `spell6` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell5`;
ALTER TABLE `creature_template` ADD COLUMN `spell7` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell6`;
ALTER TABLE `creature_template` ADD COLUMN `spell8` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell7`;
ALTER TABLE `creature_template` ADD COLUMN `spell_flags` int(30) NOT NULL DEFAULT '0' AFTER `spell8`;

-- OMG... (XVIII)
ALTER TABLE `creature_template` ADD COLUMN `modImmunities` int(30) unsigned NOT NULL DEFAULT '0' AFTER `spell_flags`;

-- JESUS... (XIX)
ALTER TABLE `creature_template` ADD COLUMN `isTrainingDummy` int(10) unsigned NOT NULL DEFAULT '0' AFTER `modImmunities`;

-- Light save my soul... (XX)
ALTER TABLE `creature_template` ADD COLUMN `guardtype` int(10) unsigned NOT NULL DEFAULT '0' AFTER `isTrainingDummy`;

-- Almost there (XXI)
ALTER TABLE `creature_template` ADD COLUMN `summonguard` int(10) unsigned NOT NULL DEFAULT '0' AFTER `guardtype`;

ALTER TABLE `creature_template` DROP COLUMN `AIName`;

ALTER TABLE `creature_template` DROP COLUMN `MovementType`;

ALTER TABLE `creature_template` DROP COLUMN `HoverHeight`;

-- ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ArmorModifier`;

-- ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ExperienceModifier`;

ALTER TABLE `creature_template` DROP COLUMN `RacialLeader`;

ALTER TABLE `creature_template` DROP COLUMN `movementId`;

ALTER TABLE `creature_template` DROP COLUMN `RegenHealth`;

ALTER TABLE `creature_template` DROP COLUMN `mechanic_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `spell_school_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `flags_extra`;

-- Last one (XXII)
ALTER TABLE `creature_template` ADD COLUMN `rooted` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`;

-- ScriptName: leave it be, it wont harm

-- VerifiedBuild: leave it be, it wont harm

-- Now lets take care of (C) and (D):
ALTER TABLE `creature_template` CHANGE COLUMN `PetSpellDataId` `spelldataid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `summonguard`;
ALTER TABLE `creature_template` CHANGE COLUMN `VehicleId` `vehicleid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spelldataid`;

-- (I): Fill `minhealth` with data:

ALTER TABLE `creature_template` ADD COLUMN `temp_minhealth` float NOT NULL DEFAULT '0' AFTER `VerifiedBuild`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `minhealth` =  `temp_minhealth` * `HealthModifier`;

-- (I): Fill `maxhealth` with data:

ALTER TABLE `creature_template` ADD COLUMN `temp_maxhealth` float NOT NULL DEFAULT '0' AFTER `temp_minhealth`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxhealth = creature_classlevelstats.basehp0
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxhealth` =  `temp_maxhealth` * `HealthModifier`;

-- (II): Fill `mana` with data:

ALTER TABLE `creature_template` ADD COLUMN `temp_mana` float NOT NULL DEFAULT '0' AFTER `temp_maxhealth`;

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

ALTER TABLE `creature_template` ADD COLUMN `temp_minattackpower` float NOT NULL DEFAULT '0' AFTER `temp_mana`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_minattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `mindamage` =  `temp_minattackpower` * `DamageModifier`;

-- (III): `maxdamage`

ALTER TABLE `creature_template` ADD COLUMN `temp_maxattackpower` float NOT NULL DEFAULT '0' AFTER `temp_minattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.temp_maxattackpower = creature_classlevelstats.attackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

UPDATE `creature_template` SET `maxdamage` =  `temp_maxattackpower` * `DamageModifier`;

-- (IV): `rangedmindamage`

-- ALTER TABLE `creature_template` ADD COLUMN `temp_minrangedattackpower` float NOT NULL DEFAULT '0' AFTER `temp_maxattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmindamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.minlevel = creature_classlevelstats.level);

-- (IV): `rangedmaxdamage`

-- ALTER TABLE `creature_template` ADD COLUMN `temp_maxrangedattackpower` float NOT NULL DEFAULT '0' AFTER `temp_minrangedattackpower`;

UPDATE creature_template, creature_classlevelstats
SET creature_template.rangedmaxdamage = creature_classlevelstats.rangedattackpower
WHERE (creature_template.unit_class = creature_classlevelstats.class AND creature_template.maxlevel = creature_classlevelstats.level);

-- (V): `can_ranged`
UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmindamage` != 0;
UPDATE `creature_template` SET `can_ranged` = 1 WHERE `rangedmaxdamage` != 0;

-- Cleanups:

ALTER TABLE `creature_template` DROP COLUMN `temp_minhealth`;
ALTER TABLE `creature_template` DROP COLUMN `temp_maxhealth`;
ALTER TABLE `creature_template` DROP COLUMN `temp_mana`;
ALTER TABLE `creature_template` DROP COLUMN `temp_minattackpower`;
ALTER TABLE `creature_template` DROP COLUMN `temp_maxattackpower`;
ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;
ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;
ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;

-- The End: rename to kickass way
RENAME TABLE `creature_template` TO `creature_proto`;