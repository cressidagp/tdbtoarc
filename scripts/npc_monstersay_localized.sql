/*
=================================================

	TDBtoARC
	
	Title: creature_text_locale to npc_monstersay_localized
	
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

DROP TABLE IF EXISTS `npc_monstersay_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_text_locale2` SELECT * FROM `creature_text_locale`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `creature_text_locale` 

	/* #2 */
	DROP COLUMN `GroupID`,
	
	/* #3 */
	DROP COLUMN `ID`;

--
--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `creature_text_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Here we go...
--
--

ALTER TABLE `creature_text_locale` 

	CHANGE COLUMN `CreatureID` `entry` int(10) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `event` int(10) unsigned NOT NULL DEFAULT '0' AFTER `entry`,

	CHANGE COLUMN `Locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text` `text0` longtext CHARACTER SET utf8 NOT NULL,
	
	ADD COLUMN `text1` longtext CHARACTER SET utf8 NOT NULL AFTER `text0`,
	
	ADD COLUMN `text2` longtext CHARACTER SET utf8 NOT NULL AFTER `text1`,
	
	ADD COLUMN `text3` longtext CHARACTER SET utf8 NOT NULL AFTER `text2`,
	
	ADD COLUMN `text4` longtext CHARACTER SET utf8 NOT NULL AFTER `text3`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_text_locale` TO `npc_monstersay_localized`;

ALTER TABLE `npc_monstersay_localized` 

	DROP PRIMARY KEY,

	ADD PRIMARY KEY (`entry`,`event`,`language_code`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature_text_locale2` TO `creature_text_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature_text_locale` ADD PRIMARY KEY (`CreatureID`,`GroupID`,`ID`,`Locale`);