/*
==============================================
	Title: gameobject_template_locale to gameobject_names_localized
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
		
==============================================
*/

DROP TABLE IF EXISTS `gameobject_names_localized`;

--
-- Create a backup of original table...
--

CREATE TABLE `gameobject_template_locale2` SELECT * FROM `gameobject_template_locale`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `gameobject_template_locale` WHERE `locale` = 'koKR';

DELETE FROM `gameobject_template_locale` WHERE `locale` = 'zhCN';

DELETE FROM `gameobject_template_locale` WHERE `locale` = 'zhTW';

DELETE FROM `gameobject_template_locale` WHERE `locale` = 'ruRU';

--
-- Drop not supported columns
--

ALTER TABLE `gameobject_template_locale` DROP COLUMN `castBarCaption`;

ALTER TABLE `gameobject_template_locale` DROP COLUMN `VerifiedBuild`;

--
-- Here we go...
--

ALTER TABLE `gameobject_template_locale` CHANGE COLUMN `entry` `entry` int(30) NOT NULL;

ALTER TABLE `gameobject_template_locale` CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `gameobject_template_locale` CHANGE COLUMN `name` `name` varchar(100) CHARACTER SET latin1 NOT NULL;

--
-- The End: rename to kickass way and set/remove keys if needed
--

RENAME TABLE `gameobject_template_locale` TO `gameobject_names_localized`;

--
-- Rename our backup table
--

RENAME TABLE `gameobject_template_locale2` TO `gameobject_template_locale`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `gameobject_template_locale` ADD PRIMARY KEY (`entry`, `locale`);