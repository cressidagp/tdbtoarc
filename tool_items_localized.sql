/*
==============================================
	Title: item_template_locale to items_localized
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/

DROP TABLE IF EXISTS `items_localized`;

--
-- Create a backup of original table...
--

CREATE TABLE `item_template_locale2` SELECT * FROM `item_template_locale`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `item_template_locale` WHERE `locale` = 'koKR';

DELETE FROM `item_template_locale` WHERE `locale` = 'zhCN';

DELETE FROM `item_template_locale` WHERE `locale` = 'zhTW';

DELETE FROM `item_template_locale` WHERE `locale` = 'ruRU';

UPDATE `item_template_locale` SET `Description` = '' WHERE `Description` IS NULL;

-- VerifiedBuild: leave it be for now, lets see if this break something

--
-- Here we go...
--

ALTER TABLE `item_template_locale` CHANGE COLUMN `ID` `entry` int(30) NOT NULL;

ALTER TABLE `item_template_locale` CHANGE COLUMN `locale` `language_code` varchar(5) NOT NULL;

ALTER TABLE `item_template_locale` CHANGE COLUMN `Name` `name` varchar(255) NOT NULL;

ALTER TABLE `item_template_locale` CHANGE COLUMN `Description` `description` varchar(255) NOT NULL;

--
-- The End: rename to kickass way
--

RENAME TABLE `item_template_locale` TO `items_localized`;

--
-- Rename our backup table
--

RENAME TABLE `item_template_locale2` TO `item_template_locale`;