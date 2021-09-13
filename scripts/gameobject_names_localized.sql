/*
=================================================

	TDBtoARC
	
	Title: gameobject_template_locale to gameobject_names_localized
	
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

DROP TABLE IF EXISTS `gameobject_names_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gameobject_template_locale2` SELECT * FROM `gameobject_template_locale`;

--
--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `gameobject_template_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `gameobject_template_locale`

	/* #4 */
	DROP COLUMN `castBarCaption`,

	/* #5 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `gameobject_template_locale` 

	CHANGE COLUMN `entry` `entry` int(30) NOT NULL,

	CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `name` `name` varchar(100) CHARACTER SET latin1 NOT NULL;

--
--
-- Rename to kickass way and set/remove key(s) if needed
--
--

RENAME TABLE `gameobject_template_locale` TO `gameobject_names_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject_template_locale2` TO `gameobject_template_locale`;

--
--
-- Since our backup table(s) will lost his keys we should add them again
--
--

ALTER TABLE `gameobject_template_locale` ADD PRIMARY KEY (`entry`, `locale`);