/*
==============================================
	TDBtoARC
	
	Title: instance_encounters to instance_bosses
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) 3 bosses bosses not prespawned in maps
	*) trash (empty in all arcemu database projects

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

--UPDATE `instance_encounters` SET `mapid` = 36 WHERE `creatureid` = 643;

UPDATE `instance_encounters` SET `mapid` = 36 WHERE `creatureid` = 643;

UPDATE `instance_encounters` SET `mapid` = 43 WHERE `creatureid` = 3654;

UPDATE `instance_encounters` SET `mapid` = 90 WHERE `creatureid` = 7361;

UPDATE `instance_encounters` SET `mapid` = 109 WHERE `creatureid` IN ( 5720, 5721, 8443, 8580 );

UPDATE `instance_encounters` SET `mapid` = 129 WHERE `creatureid` = 7355;

UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` IN ( 7273, 7275, 7796 );

UPDATE `instance_encounters` SET `mapid` = 229 WHERE `creatureid` IN ( 11583, 10264, 10268, 10584 );

UPDATE `instance_encounters` SET `mapid` = 230 WHERE `creatureid` = 10096;

UPDATE `instance_encounters` SET `mapid` = 269 WHERE `creatureid` IN ( 17879, 17880, 17881 );

UPDATE `instance_encounters` SET `mapid` = 289 WHERE `creatureid` IN ( 1853, 10506 );

UPDATE `instance_encounters` SET `mapid` = 309 WHERE `creatureid` IN ( 15083, 15114, 14515 );

UPDATE `instance_encounters` SET `mapid` = 329 WHERE `creatureid` IN ( 10516, 10808, 10813, 10439 );

UPDATE `instance_encounters` SET `mapid` = 409 WHERE `creatureid` IN ( 12018, 11502 );

UPDATE `instance_encounters` SET `mapid` = 531 WHERE `creatureid` = 15517;

UPDATE `instance_encounters` SET `mapid` = 532 WHERE `creatureid` = 15550;

UPDATE `instance_encounters` SET `mapid` = 534 WHERE `creatureid` IN ( 17767, 17808, 17888, 17842 );

UPDATE `instance_encounters` SET `mapid` = 543 WHERE `creatureid` = 17537;

UPDATE `instance_encounters` SET `mapid` = 552 WHERE `creatureid` = 20912;

UPDATE `instance_encounters` SET `mapid` = 556 WHERE `creatureid` = 23035;

UPDATE `instance_encounters` SET `mapid` = 557 WHERE `creatureid` = 22930;

UPDATE `instance_encounters` SET `mapid` = 560 WHERE `creatureid` IN ( 17848, 17862, 18096 );

UPDATE `instance_encounters` SET `mapid` = 564 WHERE `creatureid` = 23420;

UPDATE `instance_encounters` SET `mapid` = 574 WHERE `creatureid` = 23980;

UPDATE `instance_encounters` SET `mapid` = 575 WHERE `creatureid` = 26668;

UPDATE `instance_encounters` SET `mapid` = 580 WHERE `creatureid` IN ( 25038, 25315, 25840 );

UPDATE `instance_encounters` SET `mapid` = 595 WHERE `creatureid` IN ( 26529, 26530, 26532 );

UPDATE `instance_encounters` SET `mapid` = 603 WHERE `creatureid` = 33288;

UPDATE `instance_encounters` SET `mapid` = 604 WHERE `creatureid` IN ( 29573, 29932 );

UPDATE `instance_encounters` SET `mapid` = 608 WHERE `creatureid` = 31134;

UPDATE `instance_encounters` SET `mapid` = 631 WHERE `creatureid` IN ( 37970, 36853 );

UPDATE `instance_encounters` SET `mapid` = 658 WHERE `creatureid` = 36658;

UPDATE `instance_encounters` SET `mapid` = 724 WHERE `creatureid` = 39863;

--UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34797;
--UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34780;
--UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34496;

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