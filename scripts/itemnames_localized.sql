/*
=================================================

	TDBtoARC
	
	Title: item_set_names_locale to itemnames_localized
	
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

DROP TABLE IF EXISTS `itemnames_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_set_names_locale2` SELECT * FROM `item_set_names_locale`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `item_set_names_locale` DROP COLUMN `VerifiedBuild`;

--
--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `page_text_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Here we go...
--
--

ALTER TABLE `item_set_names_locale` 

	CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Name` `text` text CHARACTER SET utf8 NOT NULL;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `item_set_names_locale` TO `itemnames_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `item_set_names_locale2` TO `item_set_names_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `item_set_names_locale` ADD PRIMARY KEY (`ID`,`locale`);