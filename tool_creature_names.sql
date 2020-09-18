/*
==============================================
	Title: creature_template to creature_names
	
	From TDB: 335.20092
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/
ALTER TABLE `creature_template` CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_1`;
ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_2`;
ALTER TABLE `creature_template` DROP COLUMN `difficulty_entry_3`;

-- KillCredit1: gona change this to killcredit1 later (A)
-- KillCredit2: change this to killcredit2 later (B)

-- modelid1: will change to male_displayid later (C)
-- modelid2: will change to female_displayid (D)
-- modelid3: will change to male_displayid2 (E)
-- modelid4: will change to female_displayid2 (F)

ALTER TABLE `creature_template` CHANGE COLUMN `name` `name` varchar(100) NOT NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `subname` `subname` varchar(100); -- NOT NULL

-- TODO: how to set NULL VALUES TO = ''

ALTER TABLE `creature_template` CHANGE COLUMN `IconName` `info_str` varchar(500); -- NOT NULL

-- TODO: how to set NULL VALUES TO = ''

ALTER TABLE `creature_template` DROP COLUMN `gossip_menu_id`;

ALTER TABLE `creature_template` DROP COLUMN `minlevel`;

ALTER TABLE `creature_template` DROP COLUMN `maxlevel`;

ALTER TABLE `creature_template` DROP COLUMN `exp`;

ALTER TABLE `creature_template` DROP COLUMN `faction`;

ALTER TABLE `creature_template` CHANGE COLUMN `npcflag` `flags1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template` CHANGE COLUMN `speed_walk` `unknown_float1` float NOT NULL DEFAULT '1';

ALTER TABLE `creature_template` CHANGE COLUMN `speed_run` `unknown_float2` float NOT NULL DEFAULT '1';

ALTER TABLE `creature_template` DROP COLUMN `scale`;

-- rank: return to this later (G)

ALTER TABLE `creature_template` DROP COLUMN `dmgschool`;

ALTER TABLE `creature_template` DROP COLUMN `BaseAttackTime`;

ALTER TABLE `creature_template` DROP COLUMN `RangeAttackTime`;

ALTER TABLE `creature_template` DROP COLUMN `BaseVariance`;

ALTER TABLE `creature_template` DROP COLUMN `RangeVariance`;

ALTER TABLE `creature_template` DROP COLUMN `unit_class`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags`;

ALTER TABLE `creature_template` DROP COLUMN `unit_flags2`;

ALTER TABLE `creature_template` DROP COLUMN `dynamicflags`;

-- family: return to this later (H)

-- type: return to this later (I)

ALTER TABLE `creature_template` DROP COLUMN `type_flags`;

ALTER TABLE `creature_template` DROP COLUMN `lootid`;

ALTER TABLE `creature_template` DROP COLUMN `pickpocketloot`;

ALTER TABLE `creature_template` DROP COLUMN `skinloot`;

ALTER TABLE `creature_template` DROP COLUMN `PetSpellDataId`;

ALTER TABLE `creature_template` DROP COLUMN `VehicleId`;

ALTER TABLE `creature_template` DROP COLUMN `mingold`;

ALTER TABLE `creature_template` DROP COLUMN `maxgold`;

ALTER TABLE `creature_template` DROP COLUMN `AIName`;

ALTER TABLE `creature_template` DROP COLUMN `MovementType`;

ALTER TABLE `creature_template` DROP COLUMN `HoverHeight`;

ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ArmorModifier`;

ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ExperienceModifier`;

ALTER TABLE `creature_template` CHANGE COLUMN `RacialLeader` `leader` tinyint(3) unsigned NOT NULL DEFAULT '0';

-- Now lets add kickass emu wonderfull columns:
ALTER TABLE `creature_template` ADD COLUMN `questitem1` int(11) unsigned NOT NULL DEFAULT '0' AFTER `leader`;
ALTER TABLE `creature_template` ADD COLUMN `questitem2` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem1`;
ALTER TABLE `creature_template` ADD COLUMN `questitem3` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem2`;
ALTER TABLE `creature_template` ADD COLUMN `questitem4` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem3`;
ALTER TABLE `creature_template` ADD COLUMN `questitem5` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem4`;
ALTER TABLE `creature_template` ADD COLUMN `questitem6` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem5`;

ALTER TABLE `creature_template` CHANGE COLUMN `movementId` `waypointid` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template` DROP COLUMN `RegenHealth`;

ALTER TABLE `creature_template` DROP COLUMN `mechanic_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `spell_school_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `flags_extra`;
 
-- ScriptName: leave it be, it wont harm

-- VerifiedBuild: leave it be, it wont harm

-- Lets take care of (I):
ALTER TABLE `creature_template` CHANGE COLUMN `type` `type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `flags1`;

-- Lets take care of (H):
ALTER TABLE `creature_template` CHANGE COLUMN `family` `family` int(10) unsigned NOT NULL DEFAULT '0' AFTER `type`;

-- Lets take care of (G):
ALTER TABLE `creature_template` CHANGE COLUMN `rank` `rank` int(10) unsigned NOT NULL DEFAULT '0' AFTER `family`;

-- Lets take care of (A) and (B):
ALTER TABLE `creature_template` CHANGE COLUMN `KillCredit1` `killcredit1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `rank`;
ALTER TABLE `creature_template` CHANGE COLUMN `KillCredit2` `killcredit2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `killcredit1`;

-- Now lets do (C), (D), (E) and (F):
ALTER TABLE `creature_template` CHANGE COLUMN `modelid1` `male_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `killcredit2`;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid2` `female_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid`;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid3` `male_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `female_displayid`;
ALTER TABLE `creature_template` CHANGE COLUMN `modelid4` `female_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid2`;

-- The End: rename to kickass way
RENAME TABLE `creature_template` TO `creature_names`;