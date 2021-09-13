/*
=================================================

	TDBtoARC
	
	Title: item_template_locale to items_localized
	
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

DROP TABLE IF EXISTS `items_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `item_template_locale2` SELECT * FROM `item_template_locale`;

--
--
-- Drop not supported column(s)
--
--

/* #5 */
ALTER TABLE `item_template_locale` DROP COLUMN `VerifiedBuild`;

--
--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `item_template_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Here we go...
--
--

UPDATE `item_template_locale` SET `Description` = '' WHERE `Description` IS NULL;

ALTER TABLE `item_template_locale` 

	CHANGE COLUMN `ID` `entry` int(30) NOT NULL,
	
	CHANGE COLUMN `locale` `language_code` varchar(5) NOT NULL,

	CHANGE COLUMN `Name` `name` varchar(255) NOT NULL,

	CHANGE COLUMN `Description` `description` varchar(255) NOT NULL;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `item_template_locale` TO `items_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `item_template_locale2` TO `item_template_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `item_template_locale` ADD PRIMARY KEY (`ID`, `locale`);