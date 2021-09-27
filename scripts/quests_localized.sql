/*
=================================================

	TDBtoARC
	
	Title: quest_template_locale to quests_localized
	
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

DROP TABLE IF EXISTS `quests_localized`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `quest_template_locale2` SELECT * FROM `quest_template_locale`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `quest_template_locale` 

	/* #7 */
	DROP COLUMN `CompletedText`,

	/* #12 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--
--

DELETE FROM `quest_template_locale` WHERE (`locale` = 'koKR' or `locale` = 'zhCN' or `locale` = 'zhTW' or `locale` = 'ruRU');

--
--
-- Remove Data truncated
--
--

UPDATE `quest_template_locale` SET `Title` = '' WHERE `Title` IS NULL;

UPDATE `quest_template_locale` SET `Objectives` = '' WHERE `Objectives` IS NULL;

UPDATE `quest_template_locale` SET `EndText` = '' WHERE `EndText` IS NULL;

UPDATE `quest_template_locale` SET `ObjectiveText1` = '' WHERE `ObjectiveText1` IS NULL;

UPDATE `quest_template_locale` SET `ObjectiveText2` = '' WHERE `ObjectiveText2` IS NULL;

UPDATE `quest_template_locale` SET `ObjectiveText3` = '' WHERE `ObjectiveText3` IS NULL;

UPDATE `quest_template_locale` SET `ObjectiveText4` = '' WHERE `ObjectiveText4` IS NULL;

--
--
-- Here we go...
--
--

ALTER TABLE `quest_template_locale` 

	CHANGE COLUMN `ID` `entry` int(30) NOT NULL,

	CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Title` `Title` text CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Details` `Details` text CHARACTER SET latin1 NOT NULL,

	CHANGE COLUMN `Objectives` `Objectives` text CHARACTER SET latin1 NOT NULL,

	ADD COLUMN `CompletionText` text CHARACTER SET latin1 NOT NULL AFTER `Objectives`,

	ADD COLUMN `IncompleteText` text CHARACTER SET latin1 NOT NULL AFTER `CompletionText`,

	CHANGE COLUMN `EndText` `EndText` text CHARACTER SET latin1 NOT NULL AFTER `IncompleteText`,

	CHANGE COLUMN `ObjectiveText1` `ObjectiveText1` text CHARACTER SET latin1 NOT NULL AFTER `EndText`,

	CHANGE COLUMN `ObjectiveText2` `ObjectiveText2` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText1`,

	CHANGE COLUMN `ObjectiveText3` `ObjectiveText3` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText2`,

	CHANGE COLUMN `ObjectiveText4` `ObjectiveText4` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText3`;


/* CompletionText: */
UPDATE quest_template_locale, quest_offer_reward_locale
SET quest_template_locale.CompletionText = quest_offer_reward_locale.RewardText
WHERE quest_template_locale.entry = quest_offer_reward_locale.ID AND quest_template_locale.language_code = quest_offer_reward_locale.locale;

/* IncompleteText: */
UPDATE quest_template_locale, quest_request_items_locale
SET quest_template_locale.IncompleteText = quest_request_items_locale.CompletionText
WHERE quest_template_locale.entry = quest_request_items_locale.ID AND quest_template_locale.language_code = quest_request_items_locale.locale;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `quest_template_locale` TO `quests_localized`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `quest_template_locale2` TO `quest_template_locale`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `quest_template_locale` ADD PRIMARY KEY (`ID`,`locale`);