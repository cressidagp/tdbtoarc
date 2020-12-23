/*
==============================================
	Title: item_template to items
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/

DROP TABLE IF EXISTS `items`;

--
-- Create a backup of original table...
--

CREATE TABLE `item_template2` SELECT * FROM `item_template`;

--
-- Drop not supported columns
--

ALTER TABLE `item_template` DROP COLUMN `BuyCount`;

ALTER TABLE `item_template` DROP COLUMN `stackable`;

ALTER TABLE `item_template` DROP COLUMN `spellppmRate_1`; 

ALTER TABLE `item_template` DROP COLUMN `spellppmRate_2`;

ALTER TABLE `item_template` DROP COLUMN `spellppmRate_3`;

ALTER TABLE `item_template` DROP COLUMN `spellppmRate_4`;

ALTER TABLE `item_template` DROP COLUMN `spellppmRate_5`;

ALTER TABLE `item_template` DROP COLUMN `ScriptName`;

ALTER TABLE `item_template` DROP COLUMN `DisenchantID`;

ALTER TABLE `item_template` DROP COLUMN `FoodType`;

ALTER TABLE `item_template` DROP COLUMN `minMoneyLoot`;

ALTER TABLE `item_template` DROP COLUMN `maxMoneyLoot`;

ALTER TABLE `item_template` DROP COLUMN `flagsCustom`;

ALTER TABLE `item_template` DROP COLUMN `VerifiedBuild`;

--
-- Here we go...
--

ALTER TABLE `item_template` CHANGE COLUMN `entry` `entry` int(255) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `class` `class` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `subclass` `subclass` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `SoundOverrideSubclass` `field4` int(10) NOT NULL DEFAULT '-1';

ALTER TABLE `item_template` CHANGE COLUMN `name` `name1` varchar(255) NOT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `displayid` `displayid` int(70) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `Quality` `quality` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `Flags` `flags` int(30) unsigned NOT NULL DEFAULT '0'; -- TODO: unsigned

ALTER TABLE `item_template` CHANGE COLUMN `FlagsExtra` `flags2` int(11) unsigned NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `BuyPrice` `buyprice` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `SellPrice` `sellprice` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `InventoryType` `inventorytype` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `AllowableClass` `allowableclass` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `AllowableRace` `allowablerace` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `ItemLevel` `itemlevel` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredLevel` `requiredlevel` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredSkill` `RequiredSkill` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredSkillRank` `RequiredSkillRank` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `requiredspell` `RequiredSpell` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `requiredhonorrank` `RequiredPlayerRank1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredCityRank` `RequiredPlayerRank2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredReputationFaction` `RequiredFaction` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RequiredReputationRank` `RequiredFactionStanding` int(30) NOT NULL DEFAULT '0';

-- Will return to this later (A):

ALTER TABLE `item_template` ADD COLUMN `Unique` int(30) NOT NULL DEFAULT '0' AFTER `RequiredFactionStanding`;

ALTER TABLE `item_template` CHANGE COLUMN `maxcount` `maxcount` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `ContainerSlots` `ContainerSlots` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `StatsCount` `itemstatscount` int(10) unsigned NOT NULL DEFAULT '10';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type1` `stat_type1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value1` `stat_value1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type2` `stat_type2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value2` `stat_value2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type3` `stat_type3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value3` `stat_value3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type4` `stat_type4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value4` `stat_value4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type5` `stat_type5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value5` `stat_value5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type6` `stat_type6` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value6` `stat_value6` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type7` `stat_type7` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value7` `stat_value7` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type8` `stat_type8` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value8` `stat_value8` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type9` `stat_type9` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value9` `stat_value9` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_type10` `stat_type10` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `stat_value10` `stat_value10` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `ScalingStatDistribution` `ScaledStatsDistributionId` int(32) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `ScalingStatValue` `ScaledStatsDistributionFlags` int(32) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_min1` `dmg_min1` float NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_max1` `dmg_max1` float NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_type1` `dmg_type1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_min2` `dmg_min2` float NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_max2` `dmg_max2` float NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `dmg_type2` `dmg_type2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `armor` `armor` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `holy_res` `holy_res` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `fire_res` `fire_res` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `nature_res` `nature_res` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `frost_res` `frost_res` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `arcane_res` `arcane_res` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `delay` `delay` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `ammo_type` `ammo_type` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RangedModRange` `range` float NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellid_1` `spellid_1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spelltrigger_1` `spelltrigger_1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcharges_1` `spellcharges_1` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `spellcooldown_1` `spellcooldown_1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategory_1` `spellcategory_1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategorycooldown_1` `spellcategorycooldown_1` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellid_2` `spellid_2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spelltrigger_2` `spelltrigger_2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcharges_2` `spellcharges_2` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `spellcooldown_2` `spellcooldown_2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategory_2` `spellcategory_2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategorycooldown_2` `spellcategorycooldown_2` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellid_3` `spellid_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spelltrigger_3` `spelltrigger_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcharges_3` `spellcharges_3` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `spellcooldown_3` `spellcooldown_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategory_3` `spellcategory_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategorycooldown_3` `spellcategorycooldown_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellid_4` `spellid_4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spelltrigger_4` `spelltrigger_4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcharges_4` `spellcharges_4` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `spellcooldown_4` `spellcooldown_4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategory_4` `spellcategory_4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategorycooldown_4` `spellcategorycooldown_4` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellid_5` `spellid_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spelltrigger_5` `spelltrigger_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcharges_5` `spellcharges_5` int(30) NOT NULL DEFAULT '0';



ALTER TABLE `item_template` CHANGE COLUMN `spellcooldown_5` `spellcooldown_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategory_5` `spellcategory_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `spellcategorycooldown_5` `spellcategorycooldown_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `bonding` `bonding` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `description` `description` varchar(255) NOT NULL DEFAULT '';

ALTER TABLE `item_template` CHANGE COLUMN `PageText` `page_id` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `LanguageID` `page_language` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `PageMaterial` `page_material` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `startquest` `quest_id` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `lockid` `lock_id` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `Material` `lock_material` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `sheath` `sheathID` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RandomProperty` `randomprop` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `RandomSuffix` `randomsuffix` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `block` `block` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `itemset` `itemset` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `MaxDurability` `MaxDurability` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `area` `ZoneNameID` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `Map` `mapid` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `BagFamily` `bagfamily` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `TotemCategory` `TotemCategory` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `socketColor_1` `socket_color_1` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `socketContent_1` `unk201_3` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `socketColor_2` `socket_color_2` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `socketContent_2` `unk201_5` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `socketColor_3` `socket_color_3` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `socketContent_3` `unk201_7` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `socketBonus` `socket_bonus` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `GemProperties` `GemProperties` int(30) DEFAULT NULL;

ALTER TABLE `item_template` CHANGE COLUMN `RequiredDisenchantSkill` `ReqDisenchantSkill` int(30) NOT NULL DEFAULT '-1';

ALTER TABLE `item_template` CHANGE COLUMN `ArmorDamageModifier` `ArmorDamageModifier` int(30) NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `duration` `existingduration` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `ItemLimitCategory` `ItemLimitCategoryId` int(32) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `item_template` CHANGE COLUMN `HolidayId` `HolidayId` int(32) unsigned NOT NULL DEFAULT '0';

-- ALTER TABLE `item_template` DROP KEY;

--
-- The End: rename to kickass way
--

RENAME TABLE `item_template` TO `items`;

ALTER TABLE `items` DROP KEY `idx_name`;

ALTER TABLE `items` DROP KEY `items_index`;

--
-- Rename our backup table(s)
--

RENAME TABLE `item_template2` TO `item_template`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `item_template` ADD PRIMARY KEY (`entry`);

ALTER TABLE `item_template` ADD KEY `idx_name` (`name`);

ALTER TABLE `item_template` ADD KEY `items_index` (`class`);

