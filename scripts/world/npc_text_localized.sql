/*
=================================================

	TDBtoARC
	
	Title: npc_text_locale to npc_text_localized
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO: found this one missing 13441
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `npc_text_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `npc_text_locale2` SELECT * FROM `npc_text_locale`;

--
--
-- Remove incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `npc_text_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Remove data truncated
--
--

UPDATE `npc_text_locale` SET `text0_0` = '' WHERE `text0_0` IS NULL;

UPDATE `npc_text_locale` SET `text0_1` = '' WHERE `text0_1` IS NULL;

UPDATE `npc_text_locale` SET `text1_0` = '' WHERE `text1_0` IS NULL;

UPDATE `npc_text_locale` SET `text1_1` = '' WHERE `text1_1` IS NULL;

UPDATE `npc_text_locale` SET `text2_0` = '' WHERE `text2_0` IS NULL;

UPDATE `npc_text_locale` SET `text2_1` = '' WHERE `text2_1` IS NULL;

UPDATE `npc_text_locale` SET `text3_0` = '' WHERE `text3_0` IS NULL;

UPDATE `npc_text_locale` SET `text3_1` = '' WHERE `text3_1` IS NULL;

UPDATE `npc_text_locale` SET `text4_0` = '' WHERE `text4_0` IS NULL;

UPDATE `npc_text_locale` SET `text4_1` = '' WHERE `text4_1` IS NULL;

UPDATE `npc_text_locale` SET `text5_0` = '' WHERE `text5_0` IS NULL;

UPDATE `npc_text_locale` SET `text5_1` = '' WHERE `text5_1` IS NULL;

UPDATE `npc_text_locale` SET `text6_0` = '' WHERE `text6_0` IS NULL;

UPDATE `npc_text_locale` SET `text6_1` = '' WHERE `text6_1` IS NULL;

UPDATE `npc_text_locale` SET `text7_0` = '' WHERE `text7_0` IS NULL;

UPDATE `npc_text_locale` SET `text7_1` = '' WHERE `text7_1` IS NULL;

--
--
-- Here we go...
--
--

ALTER TABLE `npc_text_locale` 

	CHANGE COLUMN `ID` `entry` int(30) NOT NULL,

	CHANGE COLUMN `Locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text0_0` `text0` varchar(600) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text0_1` `text0_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text1_0` `text1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text1_1` `text1_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text2_0` `text2` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text2_1` `text2_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text3_0` `text3` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text3_1` `text3_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text4_0` `text4` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text4_1` `text4_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text5_0` `text5` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text5_1` `text5_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text6_0` `text6` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text6_1` `text6_1` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text7_0` `text7` varchar(500) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Text7_1` `text7_1` varchar(500) CHARACTER SET latin1 NOT NULL;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `npc_text_locale` TO `npc_text_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `npc_text_locale2` TO `npc_text_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `npc_text_locale` ADD PRIMARY KEY (`ID`, `Locale`);