/*
=================================================

	TDBtoARC
	
	Title: skinning_loot_template to loot_skinning
	
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

DROP TABLE IF EXISTS `loot_skinning`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `skinning_loot_template2` SELECT * FROM `skinning_loot_template`;

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

/* Patterns should not be gained on skining, likely a TDB bug. */
DELETE FROM `skinning_loot_template` WHERE `Item` = 1;

/* Gems should not be gained on skining, likely a TDB bug. */
DELETE FROM `skinning_loot_template` WHERE `Reference` = 11800;

ALTER TABLE `skinning_loot_template` ADD COLUMN `creatureid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE skinning_loot_template, creature_template
SET skinning_loot_template.creatureid = creature_template.Entry
WHERE skinning_loot_template.Entry = creature_template.skinloot;

ALTER TABLE `skinning_loot_template` DROP COLUMN `creatureid`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `skinning_loot_template` 

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

ALTER TABLE `skinning_loot_template` 

	CHANGE COLUMN `Entry` `entryid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Item` `itemid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Chance` `normal10percentchance` float NOT NULL DEFAULT '0',

	ADD COLUMN `normal25percentchance` float NOT NULL DEFAULT '0' AFTER `normal10percentchance`,

	ADD COLUMN `heroic10percentchance` float NOT NULL DEFAULT '0' AFTER `normal25percentchance`,

	ADD COLUMN `heroic25percentchance` float NOT NULL DEFAULT '0' AFTER `heroic10percentchance`,

	CHANGE COLUMN `MinCount` `mincount` int(30) unsigned NOT NULL DEFAULT '1',

	CHANGE COLUMN `MaxCount` `maxcount` int(30) unsigned NOT NULL DEFAULT '1';

/* GroupId = 43 */

/* GroupId = 56 */

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `skinning_loot_template` TO `loot_skinning`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `skinning_loot_template2` TO `skinning_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `skinning_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);