/*
=================================================

	TDBtoARC
	
	Title: creature_template to creature_names
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `creature_names`;

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

	/* #29 */
	DROP COLUMN `unit_class`,

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

	/* #46 */
	DROP COLUMN `HealthModifier`,

	/* #47 */
	DROP COLUMN `ManaModifier`,

	/* #48 */
	DROP COLUMN `ArmorModifier`,

	/* #49 */
	DROP COLUMN `DamageModifier`,

	/* #50 */
	DROP COLUMN `ExperienceModifier`,

	/* #53 */
	DROP COLUMN `RegenHealth`,

	/* #54 */
	DROP COLUMN `mechanic_immune_mask`,

	/* #55 */
	DROP COLUMN `spell_school_immune_mask`,

	/* #56 */
	DROP COLUMN `flags_extra`,

	/* #57 */
	DROP COLUMN `ScriptName`,

	/* #58 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Drop creature_proto column(s)
--
--

ALTER TABLE `creature_template`

	/* #15 */
	DROP COLUMN `minlevel`,

	/* #16 */
	DROP COLUMN `maxlevel`,

	/* #18 */
	DROP COLUMN `faction`,

	/* #19 */
	DROP COLUMN `npcflag`,

	/* #22 */
	DROP COLUMN `scale`,

	/* #24 */
	DROP COLUMN `dmgschool`,

	/* #25 */
	DROP COLUMN `BaseAttackTime`,

	/* #26 */
	DROP COLUMN `RangeAttackTime`,

	/* #27 */
	DROP COLUMN `BaseVariance`,

	/* #28 */
	DROP COLUMN `RangeVariance`,

	/* #39 */
	DROP COLUMN `PetSpellDataId`,

	/* #40 */
	DROP COLUMN `VehicleId`,

	/* #41 */
	DROP COLUMN `mingold`,

	/* #42 */
	DROP COLUMN `maxgold`;

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

	CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	/* KillCredit1-2: will change this to killcredit1-2 later (A) */

	/* modelid1-4: will change to male_displayid, female_displayid, male_displayid2, female_displayid2 later (B) */

	CHANGE COLUMN `name` `name` varchar(100) NOT NULL,

	CHANGE COLUMN `subname` `subname` varchar(100),
	
	CHANGE COLUMN `IconName` `info_str` varchar(500),

	CHANGE COLUMN `speed_walk` `unknown_float1` float NOT NULL DEFAULT '1',

	CHANGE COLUMN `speed_run` `unknown_float2` float NOT NULL DEFAULT '1',

	/* rank: return to this later (C) */

	/* family: return to this later (D) */

	/* type: return to this later (E) */

	CHANGE COLUMN `type_flags` `flags1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `info_str`,

	CHANGE COLUMN `RacialLeader` `leader` tinyint(3) unsigned NOT NULL DEFAULT '0',

	ADD COLUMN `questitem1` int(11) unsigned NOT NULL DEFAULT '0' AFTER `leader`,

	ADD COLUMN `questitem2` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem1`,

	ADD COLUMN `questitem3` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem2`,

	ADD COLUMN `questitem4` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem3`,

	ADD COLUMN `questitem5` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem4`,

	ADD COLUMN `questitem6` int(11) unsigned NOT NULL DEFAULT '0' AFTER `questitem5`,

	CHANGE COLUMN `movementId` `waypointid` int(10) unsigned NOT NULL DEFAULT '0',
 
	/* Lets take care of (E): */
	CHANGE COLUMN `type` `type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `flags1`,

	/* Lets take care of (D): */
	CHANGE COLUMN `family` `family` int(10) unsigned NOT NULL DEFAULT '0' AFTER `type`,

	/* Lets take care of (C): 

		0: Normal
		1: Elite
		2: Rare Elite
		3: World Boss
		4: Rare */

	CHANGE COLUMN `rank` `rank` int(10) unsigned NOT NULL DEFAULT '0' AFTER `family`,

	/* Lets take care of (A): */

	CHANGE COLUMN `KillCredit1` `killcredit1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `rank`,

	CHANGE COLUMN `KillCredit2` `killcredit2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `killcredit1`,

	/* Now lets do (B): */

	CHANGE COLUMN `modelid1` `male_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `killcredit2`,

	CHANGE COLUMN `modelid2` `female_displayid` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid`,

	CHANGE COLUMN `modelid3` `male_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `female_displayid`,

	CHANGE COLUMN `modelid4` `female_displayid2` int(30) unsigned NOT NULL DEFAULT '0' AFTER `male_displayid2`;

/* Lets remove nulls */

UPDATE `creature_template` SET `subname` = '' WHERE `subname` IS NULL;

UPDATE `creature_template` SET `info_str` = '' WHERE `info_str` IS NULL;

/* questitem1-6 */

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem1 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 0);

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem2 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 1);

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem3 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 2);

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem4 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 3);

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem5 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 4);

UPDATE `creature_template`, `creature_questitem`
SET creature_template.questitem6 = creature_questitem.ItemId
WHERE (creature_template.entry = creature_questitem.CreatureEntry and Idx = 5);

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_template` TO `creature_names`;

ALTER TABLE `creature_names` DROP KEY `idx_name`;

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