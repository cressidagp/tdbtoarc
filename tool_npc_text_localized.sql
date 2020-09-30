/*
==============================================
	Title: npc_text_locale to npc_text_localized
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `npc_text_localized`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `npc_text_locale` WHERE `Locale` = 'koKR';

DELETE FROM `npc_text_locale` WHERE `Locale` = 'zhCN';

DELETE FROM `npc_text_locale` WHERE `Locale` = 'zhTW';

DELETE FROM `npc_text_locale` WHERE `Locale` = 'ruRU';


--
-- Remove Data truncated for column...
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
-- Start! :)
--

ALTER TABLE `npc_text_locale` CHANGE COLUMN `ID` `entry` int(30) NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text0_0` `text0` varchar(600) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text0_1` `text0_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text1_0` `text1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text1_1` `text1_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text2_0` `text2` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text2_1` `text2_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text3_0` `text3` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text3_1` `text3_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text4_0` `text4` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text4_1` `text4_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text5_0` `text5` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text5_1` `text5_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text6_0` `text6` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text6_1` `text6_1` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text7_0` `text7` varchar(500) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `npc_text_locale` CHANGE COLUMN `Text7_1` `text7_1` varchar(500) CHARACTER SET latin1 NOT NULL;

--
-- The End: rename to kickass emu way
--

RENAME TABLE `npc_text_locale` TO `npc_text_localized`;