/*
=================================================

	TDBtoARC
	
	Title: item_template to items
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo: fill column Unique
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `items`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_template2` SELECT * FROM `item_template`;

--
--
-- Drop not supported columns
--
--

ALTER TABLE `item_template` 

	/* #10 */
	DROP COLUMN `BuyCount`,
	
	/* #70 */
	DROP COLUMN `stackable`,

	/* #X */
	DROP COLUMN `spellppmRate_1`,

	/* #77 */
	DROP COLUMN `spellppmRate_2`,

	/* #84 */
	DROP COLUMN `spellppmRate_3`,

	/* #91 */
	DROP COLUMN `spellppmRate_4`,

	/* #98 */
	DROP COLUMN `spellppmRate_5`,

	/* #133 */
	DROP COLUMN `ScriptName`,

	/* #134 */
	DROP COLUMN `DisenchantID`,

	/* #135 */
	DROP COLUMN `FoodType`,

	/* #136 */
	DROP COLUMN `minMoneyLoot`,

	/* #137 */
	DROP COLUMN `maxMoneyLoot`,

	/* #138 */
	DROP COLUMN `flagsCustom`,

	/* #139 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `item_template` 

	CHANGE COLUMN `entry` `entry` int(255) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `class` `class` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `subclass` `subclass` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `SoundOverrideSubclass` `field4` int(10) NOT NULL DEFAULT '-1',

	CHANGE COLUMN `name` `name1` varchar(255) NOT NULL,

	CHANGE COLUMN `displayid` `displayid` int(70) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Quality` `quality` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `Flags` `flags` int(30) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `FlagsExtra` `flags2` int(11) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `BuyPrice` `buyprice` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `SellPrice` `sellprice` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `InventoryType` `inventorytype` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `AllowableClass` `allowableclass` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `AllowableRace` `allowablerace` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `ItemLevel` `itemlevel` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredLevel` `requiredlevel` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredSkill` `RequiredSkill` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredSkillRank` `RequiredSkillRank` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `requiredspell` `RequiredSpell` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `requiredhonorrank` `RequiredPlayerRank1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredCityRank` `RequiredPlayerRank2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredReputationFaction` `RequiredFaction` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RequiredReputationRank` `RequiredFactionStanding` int(30) NOT NULL DEFAULT '0',

	/* Will return to this later (A) */
	ADD COLUMN `Unique` int(30) NOT NULL DEFAULT '0' AFTER `RequiredFactionStanding`,

	ALTER TABLE `item_template` CHANGE COLUMN `maxcount` `maxcount` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `ContainerSlots` `ContainerSlots` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `StatsCount` `itemstatscount` int(10) unsigned NOT NULL DEFAULT '10',

	CHANGE COLUMN `stat_type1` `stat_type1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value1` `stat_value1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type2` `stat_type2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value2` `stat_value2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type3` `stat_type3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value3` `stat_value3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type4` `stat_type4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value4` `stat_value4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type5` `stat_type5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value5` `stat_value5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type6` `stat_type6` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value6` `stat_value6` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type7` `stat_type7` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value7` `stat_value7` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type8` `stat_type8` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value8` `stat_value8` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type9` `stat_type9` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value9` `stat_value9` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_type10` `stat_type10` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `stat_value10` `stat_value10` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `ScalingStatDistribution` `ScaledStatsDistributionId` int(32) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `ScalingStatValue` `ScaledStatsDistributionFlags` int(32) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_min1` `dmg_min1` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_max1` `dmg_max1` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_type1` `dmg_type1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_min2` `dmg_min2` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_max2` `dmg_max2` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `dmg_type2` `dmg_type2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `armor` `armor` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `holy_res` `holy_res` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `fire_res` `fire_res` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `nature_res` `nature_res` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `frost_res` `frost_res` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `arcane_res` `arcane_res` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `delay` `delay` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `ammo_type` `ammo_type` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `RangedModRange` `range` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellid_1` `spellid_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spelltrigger_1` `spelltrigger_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcharges_1` `spellcharges_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcooldown_1` `spellcooldown_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategory_1` `spellcategory_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategorycooldown_1` `spellcategorycooldown_1` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellid_2` `spellid_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spelltrigger_2` `spelltrigger_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcharges_2` `spellcharges_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcooldown_2` `spellcooldown_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategory_2` `spellcategory_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategorycooldown_2` `spellcategorycooldown_2` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellid_3` `spellid_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spelltrigger_3` `spelltrigger_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcharges_3` `spellcharges_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcooldown_3` `spellcooldown_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategory_3` `spellcategory_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategorycooldown_3` `spellcategorycooldown_3` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellid_4` `spellid_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spelltrigger_4` `spelltrigger_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcharges_4` `spellcharges_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcooldown_4` `spellcooldown_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategory_4` `spellcategory_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategorycooldown_4` `spellcategorycooldown_4` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellid_5` `spellid_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spelltrigger_5` `spelltrigger_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcharges_5` `spellcharges_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcooldown_5` `spellcooldown_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategory_5` `spellcategory_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `spellcategorycooldown_5` `spellcategorycooldown_5` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `bonding` `bonding` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `description` `description` varchar(255) NOT NULL DEFAULT '',

	CHANGE COLUMN `PageText` `page_id` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `LanguageID` `page_language` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `PageMaterial` `page_material` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `startquest` `quest_id` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `lockid` `lock_id` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `Material` `lock_material` int(30) NOT NULL DEFAULT '0',

	CHANGE COLUMN `sheath` `sheathID` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `RandomProperty` `randomprop` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `RandomSuffix` `randomsuffix` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `block` `block` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `itemset` `itemset` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `MaxDurability` `MaxDurability` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `area` `ZoneNameID` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `Map` `mapid` int(30) DEFAULT NULL;

	CHANGE COLUMN `BagFamily` `bagfamily` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `TotemCategory` `TotemCategory` int(30) DEFAULT NULL;

	CHANGE COLUMN `socketColor_1` `socket_color_1` int(30) DEFAULT NULL;

	CHANGE COLUMN `socketContent_1` `unk201_3` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `socketColor_2` `socket_color_2` int(30) DEFAULT NULL;

	CHANGE COLUMN `socketContent_2` `unk201_5` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `socketColor_3` `socket_color_3` int(30) DEFAULT NULL;

	CHANGE COLUMN `socketContent_3` `unk201_7` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `socketBonus` `socket_bonus` int(30) DEFAULT NULL;

	CHANGE COLUMN `GemProperties` `GemProperties` int(30) DEFAULT NULL;

	CHANGE COLUMN `RequiredDisenchantSkill` `ReqDisenchantSkill` int(30) NOT NULL DEFAULT '-1';

	CHANGE COLUMN `ArmorDamageModifier` `ArmorDamageModifier` int(30) NOT NULL DEFAULT '0';

	CHANGE COLUMN `duration` `existingduration` int(10) unsigned NOT NULL DEFAULT '0';

	CHANGE COLUMN `ItemLimitCategory` `ItemLimitCategoryId` int(32) unsigned NOT NULL DEFAULT '0';

	CHANGE COLUMN `HolidayId` `HolidayId` int(32) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `item_template` TO `items`;

ALTER TABLE `items`

	DROP KEY `idx_name`,
	
	DROP KEY `items_index`;

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