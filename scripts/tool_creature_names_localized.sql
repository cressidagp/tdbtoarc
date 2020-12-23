/*
==============================================
	Title: creature_template_locale to creature_names_localized
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `creature_names_localized`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `creature_template_locale` WHERE `locale` = 'koKR';

DELETE FROM `creature_template_locale` WHERE `locale` = 'zhCN';

DELETE FROM `creature_template_locale` WHERE `locale` = 'zhTW';

DELETE FROM `creature_template_locale` WHERE `locale` = 'ruRU';

--
-- Lets start!
--

ALTER TABLE `creature_template_locale` CHANGE COLUMN `entry` `id` int(30) unsigned NOT NULL;

ALTER TABLE `creature_template_locale` CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `creature_template_locale` CHANGE COLUMN `Name` `name` varchar(100) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `creature_template_locale` CHANGE COLUMN `Title` `subname` varchar(100) CHARACTER SET latin1 NOT NULL;

-- VerifiedBuild: leave it be, it wont harm.

--
-- The End: rename to kickass emu way
--

RENAME TABLE `creature_template_locale` TO `creature_names_localized`;
