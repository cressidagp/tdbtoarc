/*
=================================================

	TDBtoARC

	Title: creature_loot_template to loot_creatures
	
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

DROP TABLE IF EXISTS `loot_creatures`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_loot_template2` SELECT * FROM `creature_loot_template`;

--
--
-- Drop not supported column(s)
--
--

/* #5 */
ALTER TABLE `creature_loot_template` DROP COLUMN `QuestRequired`;

/* #10 */
ALTER TABLE `creature_loot_template` DROP COLUMN `Comment`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature_loot_template` CHANGE COLUMN `Entry` `entryid` int(11) NOT NULL DEFAULT '0';

ALTER TABLE `creature_loot_template` CHANGE COLUMN `Item` `itemid` int(11) NOT NULL DEFAULT '0';

/* Reference: do nothing for now */

/* Chance: do nothing for now */

ALTER TABLE `creature_loot_template` ADD COLUMN `normal10percentchance` float NOT NULL DEFAULT '0' AFTER `Chance`;

ALTER TABLE `creature_loot_template` ADD COLUMN `normal25percentchance` float NOT NULL DEFAULT '0' AFTER `normal10percentchance`;

ALTER TABLE `creature_loot_template` ADD COLUMN `heroic10percentchance` float NOT NULL DEFAULT '0' AFTER `normal25percentchance`;

ALTER TABLE `creature_loot_template` ADD COLUMN `heroic25percentchance` float NOT NULL DEFAULT '0' AFTER `heroic10percentchance`;

/* LootMode: do nothing for now */

/* GroupId: do nothing for now */

ALTER TABLE `creature_loot_template` CHANGE COLUMN `MinCount` int(30) unsigned NOT NULL DEFAULT '1';

ALTER TABLE `creature_loot_template` CHANGE COLUMN `MaxCount` int(30) unsigned NOT NULL DEFAULT '1';

/*

	TODO TODO TODO
	
	
caso 1: creature id = loot id

reference id != 0

caso 2: creature id != loot id

sub caso a: loot id = 0 (q: 21669)

sub caso b: looit id != 0 (q: 650)

*/

--
--
-- Cleanup table
--
--

ALTER TABLE `creature_loot_template` DROP COLUMN `Reference`;

ALTER TABLE `creature_loot_template` DROP COLUMN `Chance`;

ALTER TABLE `creature_loot_template` DROP COLUMN `LootMode`;

ALTER TABLE `creature_loot_template` DROP COLUMN `GroupId`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_loot_template` TO `loot_creatures`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature_loot_template2` TO `creature_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature_loot_template` ADD PRIMARY KEY ( `Entry`, `Item` );
