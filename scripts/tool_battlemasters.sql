/*
==============================================
	Title: battlemaster_entry to battlemasters
	
	From TDB: 335.20111
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `battlemasters`;

--
-- Create a backup of original table...
--

CREATE TABLE `battlemaster_entry2` SELECT * FROM `battlemaster_entry`;

--
-- Here we go...
--

ALTER TABLE `battlemaster_entry` CHANGE COLUMN `entry` `creature_entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `battlemaster_entry` CHANGE COLUMN `bg_template` `battleground_id` int(10) unsigned NOT NULL DEFAULT '0';

--
-- The End: rename to kickass way
--

RENAME TABLE `battlemaster_entry` TO `battlemasters`;

--
-- Rename our backup table
--

RENAME TABLE `battlemaster_entry2` TO `battlemaster_entry`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `battlemaster_entry` ADD PRIMARY KEY (`entry`);
