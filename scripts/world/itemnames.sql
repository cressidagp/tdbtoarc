/*
=================================================

	TDBtoARC
	
	Title: item_set_names to itemnames
	
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

DROP TABLE IF EXISTS `itemnames`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_set_names2` SELECT * FROM `item_set_names`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `item_set_names` DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `item_set_names` 

	CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `name` `name` varchar(100) NOT NULL DEFAULT '',

	CHANGE COLUMN `InventoryType` `slotid` int(10) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `item_set_names` TO `itemnames`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `item_set_names2` TO `item_set_names`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `item_set_names` ADD PRIMARY KEY (`entry`);