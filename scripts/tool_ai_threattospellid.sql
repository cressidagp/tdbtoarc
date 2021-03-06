/*
==============================================
	TDBtoARC
	
	Title: spell_threat to ai_threattospellid
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql

==============================================
*/

DROP TABLE IF EXISTS `ai_threattospellid`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `spell_threat2` SELECT * FROM `spell_threat`;

--
-- Drop not supported columns
--

ALTER TABLE `spell_threat` DROP COLUMN `apPctMod`;

--
-- Here we go...
--

ALTER TABLE `spell_threat` CHANGE COLUMN `entry` `spell` int(11) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `spell_threat` CHANGE COLUMN `flatMod` `mod` int(11) NOT NULL DEFAULT '0';

ALTER TABLE `spell_threat` CHANGE COLUMN `pctMod` `modcoef` float NOT NULL DEFAULT '1';

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `spell_threat` TO `ai_threattospellid`;

--
-- Rename our backup table(s)
--

RENAME TABLE `spell_threat2` TO `spell_threat`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `spell_threat` ADD PRIMARY KEY (`entry`);
