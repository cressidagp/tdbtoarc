/*
=================================================

	TDBtoARC
	
	Title: page_text_locale to itempages_localized
	
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

DROP TABLE IF EXISTS `itempages_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `page_text_locale2` SELECT * FROM `page_text_locale`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `page_text_locale` DROP COLUMN `VerifiedBuild`;

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

ALTER TABLE `page_text_locale` 

	CHANGE COLUMN `ID` `entry` int(30) NOT NULL,

	CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text` `text` text CHARACTER SET utf8 NOT NULL;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `page_text_locale` TO `itempages_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `page_text_locale2` TO `page_text_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `page_text_locale` ADD PRIMARY KEY (`ID`,`locale`);