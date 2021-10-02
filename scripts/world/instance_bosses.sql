/*
=================================================

	TDBtoARC
	
	Title: instance_encounters to instance_bosses
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) 3 bosses (need to get map id)
	*) trash (empty in all arcemu database projects)

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `instance_bosses`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `instance_encounters2` SELECT * FROM `instance_encounters`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `instance_encounters` DROP COLUMN `lastEncounterDungeon`;

--
--
-- Here we go...
--
--

/* remove all cast spell credit */
DELETE FROM `instance_encounters` WHERE `creditType` != 0;

ALTER TABLE `instance_encounters`

	/* entry: leave it be for now */
	
	ADD COLUMN `mapid` int(11) unsigned NOT NULL DEFAULT '0' AFTER `entry`,

	DROP COLUMN `creditType`,

	CHANGE COLUMN `creditEntry` `creatureid` int(11) unsigned NOT NULL DEFAULT '0',

	/* comment: leave it be, it wont harm. */
	
	ADD COLUMN `trash` text NOT NULL AFTER `creatureid`,
	
	ADD COLUMN `trash_respawn_override` int(11) unsigned NOT NULL DEFAULT '0' AFTER `trash`;

--
--
-- Remove when more than one
--
--

CREATE TABLE `instance_encounters_temp` LIKE `instance_encounters`;

ALTER TABLE `instance_encounters_temp` DISABLE KEYS;

INSERT INTO `instance_encounters_temp` SELECT * FROM `instance_encounters`;

ALTER TABLE `instance_encounters_temp` ENABLE KEYS;
	
DELETE FROM `instance_encounters` WHERE `entry` NOT IN ( SELECT MAX(`entry`) FROM `instance_encounters_temp` GROUP BY `creatureid` );	

DROP TABLE IF EXISTS `instance_encounters_temp`;

UPDATE instance_encounters, creature
SET instance_encounters.mapid = creature.map
WHERE instance_encounters.creatureid = creature.id;

ALTER TABLE `instance_encounters` DROP PRIMARY KEY;

ALTER TABLE `instance_encounters` DROP COLUMN `entry`;

--
--
-- Lets add missing data (bosses not pre-spawned)
--
--

UPDATE `instance_encounters` SET `mapid` = 36 WHERE `creatureid` = 643;

UPDATE `instance_encounters` SET `mapid` = 43 WHERE `creatureid` = 3654;

UPDATE `instance_encounters` SET `mapid` = 90 WHERE `creatureid` = 7361;

UPDATE `instance_encounters` SET `mapid` = 129 WHERE `creatureid` = 7355;

UPDATE `instance_encounters` SET `mapid` = 230 WHERE `creatureid` = 10096;

UPDATE `instance_encounters` SET `mapid` = 531 WHERE `creatureid` = 15517;

UPDATE `instance_encounters` SET `mapid` = 532 WHERE `creatureid` = 15550;

UPDATE `instance_encounters` SET `mapid` = 543 WHERE `creatureid` = 17537;

UPDATE `instance_encounters` SET `mapid` = 552 WHERE `creatureid` = 20912;

UPDATE `instance_encounters` SET `mapid` = 556 WHERE `creatureid` = 23035;

UPDATE `instance_encounters` SET `mapid` = 557 WHERE `creatureid` = 22930;

UPDATE `instance_encounters` SET `mapid` = 564 WHERE `creatureid` = 23420;

UPDATE `instance_encounters` SET `mapid` = 574 WHERE `creatureid` = 23980;

UPDATE `instance_encounters` SET `mapid` = 575 WHERE `creatureid` = 26668;

UPDATE `instance_encounters` SET `mapid` = 603 WHERE `creatureid` = 33288;

UPDATE `instance_encounters` SET `mapid` = 608 WHERE `creatureid` = 31134;

UPDATE `instance_encounters` SET `mapid` = 658 WHERE `creatureid` = 36658;

UPDATE `instance_encounters` SET `mapid` = 724 WHERE `creatureid` = 39863;

-- ToDo: UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34797;
-- ToDo: UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34780;
-- ToDo: UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` = 34496;

UPDATE `instance_encounters` SET `mapid` = 109 WHERE `creatureid` IN ( 5720, 5721, 8443, 8580 );

UPDATE `instance_encounters` SET `mapid` = 209 WHERE `creatureid` IN ( 7273, 7275, 7796 );

UPDATE `instance_encounters` SET `mapid` = 229 WHERE `creatureid` IN ( 11583, 10264, 10268, 10584 );

UPDATE `instance_encounters` SET `mapid` = 269 WHERE `creatureid` IN ( 17879, 17880, 17881 );

UPDATE `instance_encounters` SET `mapid` = 289 WHERE `creatureid` IN ( 1853, 10506 );

UPDATE `instance_encounters` SET `mapid` = 309 WHERE `creatureid` IN ( 15083, 15114, 14515 );

UPDATE `instance_encounters` SET `mapid` = 329 WHERE `creatureid` IN ( 10516, 10808, 10813, 10439 );

UPDATE `instance_encounters` SET `mapid` = 409 WHERE `creatureid` IN ( 12018, 11502 );

UPDATE `instance_encounters` SET `mapid` = 534 WHERE `creatureid` IN ( 17767, 17808, 17888, 17842 );

UPDATE `instance_encounters` SET `mapid` = 560 WHERE `creatureid` IN ( 17848, 17862, 18096 );

UPDATE `instance_encounters` SET `mapid` = 580 WHERE `creatureid` IN ( 25038, 25315, 25840 );

UPDATE `instance_encounters` SET `mapid` = 595 WHERE `creatureid` IN ( 26529, 26530, 26532 );

UPDATE `instance_encounters` SET `mapid` = 604 WHERE `creatureid` IN ( 29573, 29932 );

UPDATE `instance_encounters` SET `mapid` = 631 WHERE `creatureid` IN ( 37970, 36853 );

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `instance_encounters` TO `instance_bosses`;

ALTER TABLE `instance_bosses` ADD PRIMARY KEY (`mapid`,`creatureid`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `instance_encounters2` TO `instance_encounters`;

--
--
-- Since our backup table(s) will lost his keys we should add them again
--
--

ALTER TABLE `instance_encounters` ADD PRIMARY KEY (`entry`);