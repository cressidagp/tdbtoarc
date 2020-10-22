/*
==============================================
	Title: creature_template to creature_names
	
	From TDB: 335.20101
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO:
	
	*) questitem1-6 (WTF IS THIS?)
	
==============================================
*/

DROP TABLE IF EXISTS `creature_names`;

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

ALTER TABLE `creature_template` DROP COLUMN `AIName`;

ALTER TABLE `creature_template` DROP COLUMN `HoverHeight`;

ALTER TABLE `creature_template` DROP COLUMN `RegenHealth`;

ALTER TABLE `creature_template` DROP COLUMN `exp`;

ALTER TABLE `creature_template` DROP COLUMN `ExperienceModifier`;

ALTER TABLE `creature_template` DROP COLUMN `gossip_menu_id`;

--
-- Drop creature_proto stuff
--

ALTER TABLE `creature_template` DROP COLUMN `npcflag`;

ALTER TABLE `creature_template` DROP COLUMN `scale`;

ALTER TABLE `creature_template` DROP COLUMN `faction`;

ALTER TABLE `creature_template` DROP COLUMN `minlevel`;

ALTER TABLE `creature_template` DROP COLUMN `maxlevel`;

ALTER TABLE `creature_template` DROP COLUMN `VehicleId`;

ALTER TABLE `creature_template` DROP COLUMN `PetSpellDataId`;

--
-- Drop creature_spawns stuff
--

ALTER TABLE `creature_template` DROP COLUMN `MovementType`;

--
-- Here we go...
--

ALTER TABLE `creature_template` CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';

-- KillCredit1: gona change this to killcredit1 later (A)

-- KillCredit2: change this to killcredit2 later (B)

-- modelid1: will change to male_displayid later (C)

-- modelid2: will change to female_displayid (D)

-- modelid3: will change to male_displayid2 (E)

-- modelid4: will change to female_displayid2 (F)

ALTER TABLE `creature_template` CHANGE COLUMN `name` `name` varchar(100) NOT NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `subname` `subname` varchar(100); -- NOT NULL

ALTER TABLE `creature_template` CHANGE COLUMN `IconName` `info_str` varchar(500); -- NOT NULL

ALTER TABLE `creature_template` CHANGE COLUMN `speed_walk` `unknown_float1` float NOT NULL DEFAULT '1';

ALTER TABLE `creature_template` CHANGE COLUMN `speed_run` `unknown_float2` float NOT NULL DEFAULT '1';

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

ALTER TABLE `creature_template` CHANGE COLUMN `type_flags` `flags1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `info_str`;

ALTER TABLE `creature_template` DROP COLUMN `lootid`;

ALTER TABLE `creature_template` DROP COLUMN `pickpocketloot`;

ALTER TABLE `creature_template` DROP COLUMN `skinloot`;

ALTER TABLE `creature_template` DROP COLUMN `mingold`;

ALTER TABLE `creature_template` DROP COLUMN `maxgold`;

ALTER TABLE `creature_template` DROP COLUMN `HealthModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ManaModifier`;

ALTER TABLE `creature_template` DROP COLUMN `ArmorModifier`;

ALTER TABLE `creature_template` DROP COLUMN `DamageModifier`;

ALTER TABLE `creature_template` CHANGE COLUMN `RacialLeader` `leader` tinyint(3) unsigned NOT NULL DEFAULT '0';

--
-- Now lets add kickass emu wonderfull columns:
--

ALTER TABLE `creature_template` ADD COLUMN `questitem1` int(11) unsigned NOT NULL DEFAULT '0' AFTER `leader`;

ALTER TABLE `creature_template` ADD COLUMN `questitem2` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem1`;

ALTER TABLE `creature_template` ADD COLUMN `questitem3` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem2`;

ALTER TABLE `creature_template` ADD COLUMN `questitem4` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem3`;

ALTER TABLE `creature_template` ADD COLUMN `questitem5` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem4`;

ALTER TABLE `creature_template` ADD COLUMN `questitem6` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem5`;

ALTER TABLE `creature_template` CHANGE COLUMN `movementId` `waypointid` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template` DROP COLUMN `mechanic_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `spell_school_immune_mask`;

ALTER TABLE `creature_template` DROP COLUMN `flags_extra`;
 
-- Lets take care of (I):

ALTER TABLE `creature_template` CHANGE COLUMN `type` `type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `flags1`;

-- Lets take care of (H):

ALTER TABLE `creature_template` CHANGE COLUMN `family` `family` int(10) unsigned NOT NULL DEFAULT '0' AFTER `type`;

-- Lets take care of (G):

ALTER TABLE `creature_template` CHANGE COLUMN `rank` `rank` int(10) unsigned NOT NULL DEFAULT '0' AFTER `family`;

/* Lets take care of (A) and (B):

	fixed all quests like http://www.wowhead.com/?quest=10702 
	creatures KillCredit 1 and 2 in db set, when killing a mob it count it as kill of that creature 
	and all creatures from KillCredit fields (these values are in retail SMSG_CREATURE_QUERY_RESPONSE)
	example: add killcredit = 6 to kobold laborer, and then when you kill a laborer it will count as a vermin.
*/

ALTER TABLE `creature_template` CHANGE COLUMN `KillCredit1` `killcredit1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `rank`;

ALTER TABLE `creature_template` CHANGE COLUMN `KillCredit2` `killcredit2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `killcredit1`;

-- Now lets do (C), (D), (E) and (F):

ALTER TABLE `creature_template` CHANGE COLUMN `modelid1` `male_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `killcredit2`;

ALTER TABLE `creature_template` CHANGE COLUMN `modelid2` `female_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid`;

ALTER TABLE `creature_template` CHANGE COLUMN `modelid3` `male_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `female_displayid`;

ALTER TABLE `creature_template` CHANGE COLUMN `modelid4` `female_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid2`;

--
-- Cleanups:
--

ALTER TABLE `creature_template` DROP COLUMN `ScriptName`;

ALTER TABLE `creature_template` DROP COLUMN `VerifiedBuild`;

UPDATE `creature_template` SET `subname` = '' WHERE `subname` IS NULL;

UPDATE `creature_template` SET `info_str` = '' WHERE `info_str` IS NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `subname` `subname` varchar(100) NOT NULL;

ALTER TABLE `creature_template` CHANGE COLUMN `info_str` `info_str` varchar(500) NOT NULL;

--
-- The End: rename to kickass way
--

RENAME TABLE `creature_template` TO `creature_names`;

--
-- Rename our backup table
--

RENAME TABLE `creature_template2` TO `creature_template`;
