/*
=================================================

	TDBtoARC
	
	Title: transports to transport_data
	
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

DROP TABLE IF EXISTS `transport_data`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `transports2` SELECT * FROM `transports`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `transports`

	DROP PRIMARY KEY,
	
	DROP KEY `idx_entry`,

	/* #1 */
	DROP COLUMN `guid`,
	
	/* #4 */
	DROP COLUMN `ScriptName`;
	
--
--
-- Here we go...
--
--

ALTER TABLE `transports`

	CHANGE COLUMN `entry` `entry` mediumint(8) unsigned NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `name` `name` text,
	
	ADD COLUMN `period` mediumint(8) unsigned NOT NULL DEFAULT '0' AFTER `name`;
	
/* period: */

UPDATE `transports` SET `period` = 231236 WHERE `entry` = 20808;

UPDATE `transports` SET `period` = 239334 WHERE `entry` = 164871;

UPDATE `transports` SET `period` = 248990 WHERE `entry` = 175080;

UPDATE `transports` SET `period` = 230162 WHERE `entry` = 176231;

UPDATE `transports` SET `period` = 312734 WHERE `entry` = 176244;

UPDATE `transports` SET `period` = 234510 WHERE `entry` = 176310;

UPDATE `transports` SET `period` = 315032 WHERE `entry` = 176495;

UPDATE `transports` SET `period` = 259751 WHERE `entry` = 177233;

UPDATE `transports` SET `period` = 238707 WHERE `entry` = 181646;

UPDATE `transports` SET `period` = 445534 WHERE `entry` = 181688;

UPDATE `transports` SET `period` = 214579 WHERE `entry` = 181689;

UPDATE `transports` SET `period` = 302705 WHERE `entry` = 186238;

UPDATE `transports` SET `period` = 484211 WHERE `entry` = 186371;

UPDATE `transports` SET `period` = 307953 WHERE `entry` = 187038;

UPDATE `transports` SET `period` = 445220 WHERE `entry` = 187568;

UPDATE `transports` SET `period` = 502354 WHERE `entry` = 188511;

UPDATE `transports` SET `period` = 271979 WHERE `entry` = 190536;

UPDATE `transports` SET `period` = 533835 WHERE `entry` = 190549;

UPDATE `transports` SET `period` = 1424158 WHERE `entry` = 192241;

UPDATE `transports` SET `period` = 1051387 WHERE `entry` = 192242;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `transports` TO `transport_data`;

ALTER TABLE `transport_data` ADD PRIMARY KEY (`entry`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `transports2` TO `transports`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `transports` 

	ADD PRIMARY KEY (`guid`),
	
	ADD UNIQUE KEY `idx_entry` (`entry`);