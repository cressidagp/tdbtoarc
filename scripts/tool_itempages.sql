/*
==============================================
	TDBtoARC
	
	Title: page_text to itempages
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/

DROP TABLE IF EXISTS `itempages`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `page_text2` SELECT * FROM `page_text`;

--
-- Here we go...
--

ALTER TABLE `page_text` CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `page_text` CHANGE COLUMN `Text` `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE `page_text` CHANGE COLUMN `NextPageID` `next_page` int(10) unsigned NOT NULL DEFAULT '0';

-- VerifiedBuild: leave it be for now, lets see if this break something

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `page_text` TO `itempages`;

--
-- Rename our backup table(s)
--

RENAME TABLE `page_text2` TO `page_text`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `page_text` ADD PRIMARY KEY (`ID`);