/*
==============================================
	TDBtoARC
	
	Title: instance_encounters to instance_bosses
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) bosses not prespawned in maps
	*) trash

==============================================
*/

DROP TABLE IF EXISTS `instance_bosses`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `instance_encounters2` SELECT * FROM `instance_encounters`;

--
-- Here we go...
--

-- entry: leave it be for now

DELETE FROM `instance_encounters` WHERE `creditType` != 0; -- remove all cast spell credit

ALTER TABLE `instance_encounters` DROP COLUMN `creditType`;

ALTER TABLE `instance_encounters` CHANGE COLUMN `creditEntry` `creatureid` int(11) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `instance_encounters` DROP COLUMN `lastEncounterDungeon`;

-- comment: leave it be for now

--
-- Remove when more than one
--

CREATE TABLE `instance_encounters_temp` LIKE `instance_encounters`;

ALTER TABLE `instance_encounters_temp` DISABLE KEYS;

INSERT INTO `instance_encounters_temp` SELECT * FROM `instance_encounters`;

ALTER TABLE `instance_encounters_temp` ENABLE KEYS;
	
DELETE FROM `instance_encounters` WHERE `entry` NOT IN ( SELECT MAX(`entry`) FROM `instance_encounters_temp` GROUP BY `creatureid` );	

DROP TABLE IF EXISTS `instance_encounters_temp`;

--
-- Add some kickass emu wonderfull columns:
--

ALTER TABLE `instance_encounters` ADD COLUMN `mapid` int(11) unsigned NOT NULL DEFAULT '0' AFTER `entry`;

UPDATE instance_encounters, creature
SET instance_encounters.mapid = creature.map
WHERE instance_encounters.creatureid = creature.id;

ALTER TABLE `instance_encounters` ADD COLUMN `trash` text NOT NULL AFTER `creatureid`;

ALTER TABLE `instance_encounters` ADD COLUMN `trash_respawn_override` int(11) unsigned NOT NULL DEFAULT '0' AFTER `trash`;

ALTER TABLE `instance_encounters` DROP PRIMARY KEY;

ALTER TABLE `instance_encounters` DROP COLUMN `entry`;

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `instance_encounters` TO `instance_bosses`;

ALTER TABLE `instance_bosses` ADD PRIMARY KEY (`mapid`,`creatureid`);

--
-- Rename our backup table(s)
--

RENAME TABLE `instance_encounters2` TO `instance_encounters`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `instance_encounters` ADD PRIMARY KEY (`entry`);