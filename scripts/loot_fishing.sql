/*
=================================================

	TDBtoARC
	
	Title: fishing_loot_template to loot_fishing
	
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

DROP TABLE IF EXISTS `loot_fishing`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `fishing_loot_template2` SELECT * FROM `fishing_loot_template`;

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

ALTER TABLE `fishing_loot_template` ADD COLUMN `areaorzone` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

ALTER TABLE `reference_loot_template` ADD COLUMN `areaorzone` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE reference_loot_template, fishing_loot_template
SET reference_loot_template.areaorzone = fishing_loot_template.Entry
WHERE reference_loot_template.Entry = fishing_loot_template.Reference;

INSERT INTO `fishing_loot_template` 
SELECT `Entry`, `Item`, Reference, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `areaorzone`
FROM `reference_loot_template` 
WHERE `areaorzone` != 0;

DELETE FROM `fishing_loot_template` WHERE `areaorzone` = 4197 AND `Item` = 45904;

UPDATE `fishing_loot_template` SET `Entry` = `areaorzone` WHERE `areaorzone` != 0;

ALTER TABLE `fishing_loot_template` DROP COLUMN `areaorzone`;

ALTER TABLE `reference_loot_template` DROP COLUMN `areaorzone`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `fishing_loot_template` 

	/* #3 */
	-- DROP COLUMN `Reference`,

	/* #5 */
	DROP COLUMN `QuestRequired`,

	/* #6 */
	DROP COLUMN `LootMode`,

	/* #7 */
	DROP COLUMN `GroupId`;

--
--
-- Here we go...
--
--

ALTER TABLE `fishing_loot_template` 

	CHANGE COLUMN `Entry` `entryid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Item` `itemid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Chance` `normal10percentchance` float NOT NULL DEFAULT '0',

	ADD COLUMN `normal25percentchance` float NOT NULL DEFAULT '0' AFTER `normal10percentchance`,

	ADD COLUMN `heroic10percentchance` float NOT NULL DEFAULT '0' AFTER `normal25percentchance`,

	ADD COLUMN `heroic25percentchance` float NOT NULL DEFAULT '0' AFTER `heroic10percentchance`,

	CHANGE COLUMN `MinCount` `mincount` int(30) unsigned NOT NULL DEFAULT '1',

	CHANGE COLUMN `MaxCount` `maxcount` int(30) unsigned NOT NULL DEFAULT '1';
	
--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `fishing_loot_template` TO `loot_fishing`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `fishing_loot_template2` TO `fishing_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `fishing_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);
