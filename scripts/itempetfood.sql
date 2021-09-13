/*
=================================================

	TDBtoARC
	
	Title: item_template to itempetfood
	
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

DROP TABLE IF EXISTS `itempetfood`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_template2` SELECT * FROM `item_template`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `item_template` 

	DROP COLUMN `class`,

	DROP COLUMN `subclass`,

	DROP COLUMN `SoundOverrideSubclass`,

	DROP COLUMN `name`,

	DROP COLUMN `displayid`,

	DROP COLUMN `Quality`,

	DROP COLUMN `Flags`,

	DROP COLUMN `FlagsExtra`,

	DROP COLUMN `BuyCount`,

	DROP COLUMN `BuyPrice`,
	
	DROP COLUMN `SellPrice`,

	DROP COLUMN `InventoryType`,

	DROP COLUMN `AllowableClass`,

	DROP COLUMN `AllowableRace`,

	DROP COLUMN `ItemLevel`,

	DROP COLUMN `RequiredLevel`,

	DROP COLUMN `RequiredSkill`,

	DROP COLUMN `RequiredSkillRank`,

	DROP COLUMN `requiredspell`,

	DROP COLUMN `requiredhonorrank`,

	DROP COLUMN `RequiredCityRank`,
	
	DROP COLUMN `RequiredReputationFaction`,
	
	DROP COLUMN `RequiredReputationRank`,
	
	DROP COLUMN `maxcount`,

	DROP COLUMN `stackable`,

	DROP COLUMN `ContainerSlots`,

	DROP COLUMN `StatsCount`,

	DROP COLUMN `stat_type1`,

	DROP COLUMN `stat_value1`,

	DROP COLUMN `stat_type2`,

	DROP COLUMN `stat_value2`,

	DROP COLUMN `stat_type3`,

	DROP COLUMN `stat_value3`,

	DROP COLUMN `stat_type4`,

	DROP COLUMN `stat_value4`,

	DROP COLUMN `stat_type5`,

	DROP COLUMN `stat_value5`,

	DROP COLUMN `stat_type6`,

	DROP COLUMN `stat_value6`,

	DROP COLUMN `stat_type7`,

	DROP COLUMN `stat_value7`,

	DROP COLUMN `stat_type8`,

	DROP COLUMN `stat_value8`,

	DROP COLUMN `stat_type9`,

	DROP COLUMN `stat_value9`,

	DROP COLUMN `stat_type10`,

	DROP COLUMN `stat_value10`,

	DROP COLUMN `ScalingStatDistribution`,

	DROP COLUMN `ScalingStatValue`,

	DROP COLUMN `dmg_min1`,

	DROP COLUMN `dmg_max1`,

	DROP COLUMN `dmg_type1`,

	DROP COLUMN `dmg_min2`,

	DROP COLUMN `dmg_max2`,

	DROP COLUMN `dmg_type2`,

	DROP COLUMN `armor`,

	DROP COLUMN `holy_res`,

	DROP COLUMN `fire_res`,

	DROP COLUMN `nature_res`,

	DROP COLUMN `frost_res`,

	DROP COLUMN `shadow_res`,

	DROP COLUMN `arcane_res`,

	DROP COLUMN `delay`,

	DROP COLUMN `ammo_type`,

	DROP COLUMN `RangedModRange`,

	DROP COLUMN `spellid_1`,

	DROP COLUMN `spelltrigger_1`,

	DROP COLUMN `spellcharges_1`,

	DROP COLUMN `spellppmRate_1`,

	DROP COLUMN `spellcooldown_1`,

	DROP COLUMN `spellcategory_1`,

	DROP COLUMN `spellcategorycooldown_1`,

	DROP COLUMN `spellid_2`,

	DROP COLUMN `spelltrigger_2`,

	DROP COLUMN `spellcharges_2`,

	DROP COLUMN `spellppmRate_2`,

	DROP COLUMN `spellcooldown_2`,

	DROP COLUMN `spellcategory_2`,

	DROP COLUMN `spellcategorycooldown_2`,

	DROP COLUMN `spellid_3`,

	DROP COLUMN `spelltrigger_3`,

	DROP COLUMN `spellcharges_3`,

	DROP COLUMN `spellppmRate_3`,

	DROP COLUMN `spellcooldown_3`,

	DROP COLUMN `spellcategory_3`,

	DROP COLUMN `spellcategorycooldown_3`,

	DROP COLUMN `spellid_4`,

	DROP COLUMN `spelltrigger_4`,

	DROP COLUMN `spellcharges_4`,

	DROP COLUMN `spellppmRate_4`,

	DROP COLUMN `spellcooldown_4`,

	DROP COLUMN `spellcategory_4`,
	
	DROP COLUMN `spellcategorycooldown_4`,

	DROP COLUMN `spellid_5`,

	DROP COLUMN `spelltrigger_5`,

	DROP COLUMN `spellcharges_5`,

	DROP COLUMN `spellppmRate_5`,

	DROP COLUMN `spellcooldown_5`,

	DROP COLUMN `spellcategory_5`,

	DROP COLUMN `spellcategorycooldown_5`,

	DROP COLUMN `bonding`,

	DROP COLUMN `description`,

	DROP COLUMN `PageText`,

	DROP COLUMN `LanguageID`,

	DROP COLUMN `PageMaterial`,

	DROP COLUMN `startquest`,

	DROP COLUMN `lockid`,

	DROP COLUMN `Material`,

	DROP COLUMN `sheath`,

	DROP COLUMN `RandomProperty`,

	DROP COLUMN `RandomSuffix`,

	DROP COLUMN `block`,

	DROP COLUMN `itemset`,

	DROP COLUMN `MaxDurability`,
	
	DROP COLUMN `area`,

	DROP COLUMN `Map`,

	DROP COLUMN `BagFamily`,

	DROP COLUMN `TotemCategory`,

	DROP COLUMN `socketColor_1`,

	DROP COLUMN `socketContent_1`,

	DROP COLUMN `socketColor_2`,

	DROP COLUMN `socketContent_2`,

	DROP COLUMN `socketColor_3`,

	DROP COLUMN `socketContent_3`,

	DROP COLUMN `socketBonus`,

	DROP COLUMN `GemProperties`,

	DROP COLUMN `RequiredDisenchantSkill`,

	DROP COLUMN `ArmorDamageModifier`,

	DROP COLUMN `duration`,

	DROP COLUMN `ItemLimitCategory`,

	DROP COLUMN `HolidayId`,

	DROP COLUMN `ScriptName`,

	DROP COLUMN `DisenchantID`,

	DROP COLUMN `minMoneyLoot`,

	DROP COLUMN `maxMoneyLoot`,

	DROP COLUMN `flagsCustom`,

	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

/* Lets delete all except pet food. */
DELETE FROM `item_template` WHERE `FoodType` = '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `item_template` TO `itempetfood`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `item_template2` TO `item_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `item_template` 

	ADD PRIMARY KEY (`entry`),
	
	ADD KEY `idx_name` (`name`),
	
	ADD KEY `items_index` (`class`);