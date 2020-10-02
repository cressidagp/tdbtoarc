/*
==============================================
	Title: page_text_locale to itempages_localized
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	WARNING: dont use for now since TDB has html code here
	
==============================================
*/

DROP TABLE IF EXISTS `itempages_localized`;

--
-- Create a backup of original table...
--

CREATE TABLE `page_text_locale2` SELECT * FROM `page_text_locale`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `page_text_locale` WHERE `locale` = 'koKR';

DELETE FROM `page_text_locale` WHERE `locale` = 'zhCN';

DELETE FROM `page_text_locale` WHERE `locale` = 'zhTW';

DELETE FROM `page_text_locale` WHERE `locale` = 'ruRU';

-- UPDATE `item_template_locale` SET `Description` = '' WHERE `Description` IS NULL;

-- VerifiedBuild: leave it be for now, lets see if this break something

--
-- Here we go...
--

ALTER TABLE `page_text_locale` CHANGE COLUMN `ID` `entry` int(30) NOT NULL;

ALTER TABLE `page_text_locale` CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `page_text_locale` CHANGE COLUMN `Text` `text` text CHARACTER SET latin1 NOT NULL;

--
-- The End: rename to kickass way
--

RENAME TABLE `page_text_locale` TO `itempages_localized`;

--
-- Rename our backup table
--

RENAME TABLE `page_text_locale2` TO `page_text_locale`;