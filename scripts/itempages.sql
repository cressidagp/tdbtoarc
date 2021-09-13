/*
=================================================

	TDBtoARC
	
	Title: page_text to itempages
	
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

DROP TABLE IF EXISTS `itempages`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `page_text2` SELECT * FROM `page_text`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `page_text` DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `page_text` 

	CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Text` `text` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,

	CHANGE COLUMN `NextPageID` `next_page` int(10) unsigned NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `page_text` TO `itempages`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `page_text2` TO `page_text`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `page_text` ADD PRIMARY KEY (`ID`);