/*
==============================================
	Title: item_template to itempetfood
	
	From TDB: 335.20111
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `itempetfood`;

--
-- Create a backup of original table...
--

CREATE TABLE `item_template2` SELECT * FROM `item_template`;

--
-- Here we go...
--

DELETE FROM `item_template` WHERE `FoodType` = '0'; -- lets remove not needed items

ALTER TABLE `item_template` DROP COLUMN `class`;
ALTER TABLE `item_template` DROP COLUMN `subclass`;
ALTER TABLE `item_template` DROP COLUMN `SoundOverrideSubclass`;
ALTER TABLE `item_template` DROP COLUMN `name`;
ALTER TABLE `item_template` DROP COLUMN `displayid`;
ALTER TABLE `item_template` DROP COLUMN `Quality`;
ALTER TABLE `item_template` DROP COLUMN `Flags`;
ALTER TABLE `item_template` DROP COLUMN `FlagsExtra`;
ALTER TABLE `item_template` DROP COLUMN `BuyCount`;
ALTER TABLE `item_template` DROP COLUMN `BuyPrice`;
ALTER TABLE `item_template` DROP COLUMN `SellPrice`;
ALTER TABLE `item_template` DROP COLUMN `InventoryType`;
ALTER TABLE `item_template` DROP COLUMN `AllowableClass`;
ALTER TABLE `item_template` DROP COLUMN `AllowableRace`;
ALTER TABLE `item_template` DROP COLUMN `ItemLevel`;
ALTER TABLE `item_template` DROP COLUMN `RequiredLevel`;
ALTER TABLE `item_template` DROP COLUMN `RequiredSkill`;
ALTER TABLE `item_template` DROP COLUMN `RequiredSkillRank`;
ALTER TABLE `item_template` DROP COLUMN `requiredspell`;
ALTER TABLE `item_template` DROP COLUMN `requiredhonorrank`;
ALTER TABLE `item_template` DROP COLUMN `RequiredCityRank`;
ALTER TABLE `item_template` DROP COLUMN `RequiredReputationFaction`;
ALTER TABLE `item_template` DROP COLUMN `RequiredReputationRank`;
ALTER TABLE `item_template` DROP COLUMN `maxcount`;
ALTER TABLE `item_template` DROP COLUMN `stackable`;
ALTER TABLE `item_template` DROP COLUMN `ContainerSlots`;
ALTER TABLE `item_template` DROP COLUMN `StatsCount`;
ALTER TABLE `item_template` DROP COLUMN `stat_type1`;
ALTER TABLE `item_template` DROP COLUMN `stat_value1`;
ALTER TABLE `item_template` DROP COLUMN `stat_type2`;
ALTER TABLE `item_template` DROP COLUMN `stat_value2`;
ALTER TABLE `item_template` DROP COLUMN `stat_type3`;
ALTER TABLE `item_template` DROP COLUMN `stat_value3`;
ALTER TABLE `item_template` DROP COLUMN `stat_type4`;
ALTER TABLE `item_template` DROP COLUMN `stat_value4`;
ALTER TABLE `item_template` DROP COLUMN `stat_type5`;
ALTER TABLE `item_template` DROP COLUMN `stat_value5`;
ALTER TABLE `item_template` DROP COLUMN `stat_type6`;
ALTER TABLE `item_template` DROP COLUMN `stat_value6`;
ALTER TABLE `item_template` DROP COLUMN `stat_type7`;
ALTER TABLE `item_template` DROP COLUMN `stat_value7`;
ALTER TABLE `item_template` DROP COLUMN `stat_type8`;
ALTER TABLE `item_template` DROP COLUMN `stat_value8`;
ALTER TABLE `item_template` DROP COLUMN `stat_type9`;
ALTER TABLE `item_template` DROP COLUMN `stat_value9`;
ALTER TABLE `item_template` DROP COLUMN `stat_type10`;
ALTER TABLE `item_template` DROP COLUMN `stat_value10`;
ALTER TABLE `item_template` DROP COLUMN `ScalingStatDistribution`;
ALTER TABLE `item_template` DROP COLUMN `ScalingStatValue`;
ALTER TABLE `item_template` DROP COLUMN `dmg_min1`;
ALTER TABLE `item_template` DROP COLUMN `dmg_max1`;
ALTER TABLE `item_template` DROP COLUMN `dmg_type1`;
ALTER TABLE `item_template` DROP COLUMN `dmg_min2`;
ALTER TABLE `item_template` DROP COLUMN `dmg_max2`;
ALTER TABLE `item_template` DROP COLUMN `dmg_type2`;
ALTER TABLE `item_template` DROP COLUMN `armor`;
ALTER TABLE `item_template` DROP COLUMN `holy_res`;
ALTER TABLE `item_template` DROP COLUMN `fire_res`;
ALTER TABLE `item_template` DROP COLUMN `nature_res`;
ALTER TABLE `item_template` DROP COLUMN `frost_res`;
ALTER TABLE `item_template` DROP COLUMN `shadow_res`;
ALTER TABLE `item_template` DROP COLUMN `arcane_res`;
ALTER TABLE `item_template` DROP COLUMN `delay`;
ALTER TABLE `item_template` DROP COLUMN `ammo_type`;
ALTER TABLE `item_template` DROP COLUMN `RangedModRange`;
ALTER TABLE `item_template` DROP COLUMN `spellid_1`;
ALTER TABLE `item_template` DROP COLUMN `spelltrigger_1`;
ALTER TABLE `item_template` DROP COLUMN `spellcharges_1`;
ALTER TABLE `item_template` DROP COLUMN `spellppmRate_1`;
ALTER TABLE `item_template` DROP COLUMN `spellcooldown_1`;
ALTER TABLE `item_template` DROP COLUMN `spellcategory_1`;
ALTER TABLE `item_template` DROP COLUMN `spellcategorycooldown_1`;
ALTER TABLE `item_template` DROP COLUMN `spellid_2`;
ALTER TABLE `item_template` DROP COLUMN `spelltrigger_2`;
ALTER TABLE `item_template` DROP COLUMN `spellcharges_2`;
ALTER TABLE `item_template` DROP COLUMN `spellppmRate_2`;
ALTER TABLE `item_template` DROP COLUMN `spellcooldown_2`;
ALTER TABLE `item_template` DROP COLUMN `spellcategory_2`;
ALTER TABLE `item_template` DROP COLUMN `spellcategorycooldown_2`;
ALTER TABLE `item_template` DROP COLUMN `spellid_3`;
ALTER TABLE `item_template` DROP COLUMN `spelltrigger_3`;
ALTER TABLE `item_template` DROP COLUMN `spellcharges_3`;
ALTER TABLE `item_template` DROP COLUMN `spellppmRate_3`;
ALTER TABLE `item_template` DROP COLUMN `spellcooldown_3`;
ALTER TABLE `item_template` DROP COLUMN `spellcategory_3`;
ALTER TABLE `item_template` DROP COLUMN `spellcategorycooldown_3`;
ALTER TABLE `item_template` DROP COLUMN `spellid_4`;
ALTER TABLE `item_template` DROP COLUMN `spelltrigger_4`;
ALTER TABLE `item_template` DROP COLUMN `spellcharges_4`;
ALTER TABLE `item_template` DROP COLUMN `spellppmRate_4`;
ALTER TABLE `item_template` DROP COLUMN `spellcooldown_4`;
ALTER TABLE `item_template` DROP COLUMN `spellcategory_4`;
ALTER TABLE `item_template` DROP COLUMN `spellcategorycooldown_4`;
ALTER TABLE `item_template` DROP COLUMN `spellid_5`;
ALTER TABLE `item_template` DROP COLUMN `spelltrigger_5`;
ALTER TABLE `item_template` DROP COLUMN `spellcharges_5`;
ALTER TABLE `item_template` DROP COLUMN `spellppmRate_5`;
ALTER TABLE `item_template` DROP COLUMN `spellcooldown_5`;
ALTER TABLE `item_template` DROP COLUMN `spellcategory_5`;
ALTER TABLE `item_template` DROP COLUMN `spellcategorycooldown_5`;
ALTER TABLE `item_template` DROP COLUMN `bonding`;
ALTER TABLE `item_template` DROP COLUMN `description`;
ALTER TABLE `item_template` DROP COLUMN `PageText`;
ALTER TABLE `item_template` DROP COLUMN `LanguageID`;
ALTER TABLE `item_template` DROP COLUMN `PageMaterial`;
ALTER TABLE `item_template` DROP COLUMN `startquest`;
ALTER TABLE `item_template` DROP COLUMN `lockid`;
ALTER TABLE `item_template` DROP COLUMN `Material`;
ALTER TABLE `item_template` DROP COLUMN `sheath`;
ALTER TABLE `item_template` DROP COLUMN `RandomProperty`;
ALTER TABLE `item_template` DROP COLUMN `RandomSuffix`;
ALTER TABLE `item_template` DROP COLUMN `block`;
ALTER TABLE `item_template` DROP COLUMN `itemset`;
ALTER TABLE `item_template` DROP COLUMN `MaxDurability`;
ALTER TABLE `item_template` DROP COLUMN `area`;
ALTER TABLE `item_template` DROP COLUMN `Map`;
ALTER TABLE `item_template` DROP COLUMN `BagFamily`;
ALTER TABLE `item_template` DROP COLUMN `TotemCategory`;
ALTER TABLE `item_template` DROP COLUMN `socketColor_1`;
ALTER TABLE `item_template` DROP COLUMN `socketContent_1`;
ALTER TABLE `item_template` DROP COLUMN `socketColor_2`;
ALTER TABLE `item_template` DROP COLUMN `socketContent_2`;
ALTER TABLE `item_template` DROP COLUMN `socketColor_3`;
ALTER TABLE `item_template` DROP COLUMN `socketContent_3`;
ALTER TABLE `item_template` DROP COLUMN `socketBonus`;
ALTER TABLE `item_template` DROP COLUMN `GemProperties`;
ALTER TABLE `item_template` DROP COLUMN `RequiredDisenchantSkill`;
ALTER TABLE `item_template` DROP COLUMN `ArmorDamageModifier`;
ALTER TABLE `item_template` DROP COLUMN `duration`;
ALTER TABLE `item_template` DROP COLUMN `ItemLimitCategory`;
ALTER TABLE `item_template` DROP COLUMN `HolidayId`;
ALTER TABLE `item_template` DROP COLUMN `ScriptName`;
ALTER TABLE `item_template` DROP COLUMN `DisenchantID`;
ALTER TABLE `item_template` DROP COLUMN `minMoneyLoot`;
ALTER TABLE `item_template` DROP COLUMN `maxMoneyLoot`;
ALTER TABLE `item_template` DROP COLUMN `flagsCustom`;

-- `VerifiedBuild`: leave it be, it worn harm.

--
-- The End: rename to kickass way
--

RENAME TABLE `item_template` TO `itempetfood`;

--
-- Rename our backup table
--

RENAME TABLE `item_template2` TO `item_template`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `item_template` ADD PRIMARY KEY (`entry`);
ALTER TABLE `item_template` ADD KEY `idx_name` (`name`);
ALTER TABLE `item_template` ADD KEY `items_index` (`class`);

