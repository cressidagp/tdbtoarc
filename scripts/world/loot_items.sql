/*
=================================================

	TDBtoARC
	
	Title: item_loot_template to loot_items
	
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

DROP TABLE IF EXISTS `loot_items`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_loot_template2` SELECT * FROM `item_loot_template`;

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

ALTER TABLE `item_loot_template` ADD COLUMN `item_box` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

ALTER TABLE `reference_loot_template` ADD COLUMN `item_box` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE reference_loot_template, item_loot_template
SET reference_loot_template.item_box = item_loot_template.Entry
WHERE reference_loot_template.Entry = item_loot_template.Reference;

INSERT INTO `item_loot_template` 
SELECT `Entry`, `Item`, Reference, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `item_box`
FROM `reference_loot_template` 
WHERE `item_box` != 0;

--
--
-- Crack! (fucking duplicated entrys)
--
--

DELETE FROM `item_loot_template` WHERE `item_box` = 51999 AND `Item` = 51994;

DELETE FROM `item_loot_template` WHERE `item_box` = 52000 AND `Item` = 51996;

DELETE FROM `item_loot_template` WHERE `item_box` = 52001 AND `Item` = 51992;

DELETE FROM `item_loot_template` WHERE `item_box` = 52002 AND `Item` = 51993;

DELETE FROM `item_loot_template` WHERE `item_box` = 52003 AND `Item` = 51993;

DELETE FROM `item_loot_template` WHERE `item_box` = 52004 AND `Item` = 51995;

DELETE FROM `item_loot_template` WHERE `item_box` = 52005 AND `Item` = 51991;






UPDATE `item_loot_template` SET `Entry` = `item_box` WHERE `item_box` != 0;

ALTER TABLE `item_loot_template` DROP COLUMN `item_box`;

ALTER TABLE `reference_loot_template` DROP COLUMN `item_box`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `item_loot_template` 

	/* #3 */
	DROP COLUMN `Reference`,

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

ALTER TABLE `item_loot_template` 

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

RENAME TABLE `item_loot_template` TO `loot_items`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `item_loot_template2` TO `item_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `item_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);
