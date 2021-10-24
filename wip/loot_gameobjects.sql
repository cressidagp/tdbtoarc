/*
=================================================

	TDBtoARC
	
	Title: gameobject_loot_template(+reference_loots) to loot_gameobjects
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	gameobject_names.sound1 = gameobject_template.Data1
	
	It is often the same ID as the loot source (gameobject data1)

	But several sources could have the same loot template
	example: Large Solid Chest (74448) and Large Iron Bound Chest (74447) have the same loot (4075)

	also there are artificial loots wich id are linked to the source, they are referenced from the normal template
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `loot_gameobjects`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gameobject_loot_template2` SELECT * FROM `gameobject_loot_template`;

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

ALTER TABLE `gameobject_loot_template` ADD COLUMN `data1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

ALTER TABLE `reference_loot_template` ADD COLUMN `data1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE reference_loot_template, gameobject_loot_template
SET reference_loot_template.data1 = gameobject_loot_template.Entry
WHERE reference_loot_template.Entry = gameobject_loot_template.Reference;

INSERT INTO `gameobject_loot_template` 
SELECT `Entry`, `Item`, Reference, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `data1`
FROM `reference_loot_template` 
WHERE `data1` != 0;

DELETE FROM `gameobject_loot_template` WHERE `data1` = 24228 AND `Item` = 36908;

DELETE FROM `gameobject_loot_template` WHERE `data1` = 25193 AND `Item` = 40344;

UPDATE `gameobject_loot_template` SET `Entry` = `data1` WHERE `data1` != 0;

ALTER TABLE `gameobject_loot_template` DROP COLUMN `data1`;

ALTER TABLE `reference_loot_template` DROP COLUMN `data1`;

DELETE FROM `gameobject_loot_template` WHERE `Item` < 6 and `reference` != 0;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `gameobject_loot_template`

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

ALTER TABLE `gameobject_loot_template`

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

RENAME TABLE `gameobject_loot_template` TO `loot_gameobjects`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject_loot_template2` TO `gameobject_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gameobject_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);