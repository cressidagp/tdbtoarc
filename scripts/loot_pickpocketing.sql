/*
=================================================

	TDBtoARC
	
	Title: pickpocketing_loot_template to loot_pickpocketing
	
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

DROP TABLE IF EXISTS `loot_pickpocketing`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `pickpocketing_loot_template2` SELECT * FROM `pickpocketing_loot_template`;

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

ALTER TABLE `pickpocketing_loot_template` ADD COLUMN `pickpocketloot` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

ALTER TABLE `reference_loot_template` ADD COLUMN `pickpocketloot` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE reference_loot_template, pickpocketing_loot_template
SET reference_loot_template.pickpocketloot = pickpocketing_loot_template.Entry
WHERE reference_loot_template.Entry = pickpocketing_loot_template.Reference;

UPDATE `pickpocketing_loot_template` SET `Entry` = `pickpocketloot` WHERE `pickpocketloot` != 0;

ALTER TABLE `pickpocketing_loot_template` DROP COLUMN `pickpocketloot`;

ALTER TABLE `reference_loot_template` DROP COLUMN `pickpocketloot`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `pickpocketing_loot_template` 

	/* #3  */
	DROP COLUMN `Reference`,

	/* #5  */
	DROP COLUMN `QuestRequired`,

	/* #6  */
	DROP COLUMN `LootMode`,

	/* #7  */
	DROP COLUMN `GroupId`;

--
--
-- Here we go...
--
--

ALTER TABLE `pickpocketing_loot_template` 

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

RENAME TABLE `pickpocketing_loot_template` TO `loot_pickpocketing`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `pickpocketing_loot_template2` TO `pickpocketing_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `pickpocketing_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);