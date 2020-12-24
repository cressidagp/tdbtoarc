/*
==============================================
	TDBtoARC
	
	Title: quest_template_locale to quests_localized
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
		
==============================================
*/

DROP TABLE IF EXISTS `quests_localized`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `quest_template_locale2` SELECT * FROM `quest_template_locale`;

--
-- Remove Incorrect string value (im sorry China, Korea, Taiwan and Rusia)
--

DELETE FROM `quest_template_locale` WHERE `locale` = 'koKR';

DELETE FROM `quest_template_locale` WHERE `locale` = 'zhCN';

DELETE FROM `quest_template_locale` WHERE `locale` = 'zhTW';

DELETE FROM `quest_template_locale` WHERE `locale` = 'ruRU';

--
-- Here we go...
--

ALTER TABLE `quest_template_locale` CHANGE COLUMN `ID` `entry` int(30) NOT NULL;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `locale` `language_code` varchar(5) CHARACTER SET latin1 NOT NULL;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `Title` `Title` text CHARACTER SET latin1 NOT NULL;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `Details` `Details` text CHARACTER SET latin1 NOT NULL;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `Objectives` `Objectives` text CHARACTER SET latin1 NOT NULL;

ALTER TABLE `quest_template_locale` ADD COLUMN `CompletionText` text CHARACTER SET latin1 NOT NULL AFTER `Objectives`;

UPDATE quest_template_locale, quest_offer_reward_locale
SET quest_template_locale.CompletionText = quest_offer_reward_locale.RewardText
WHERE quest_template_locale.entry = quest_offer_reward_locale.ID AND quest_template_locale.language_code = quest_offer_reward_locale.locale;

ALTER TABLE `quest_template_locale` ADD COLUMN `IncompleteText` text CHARACTER SET latin1 NOT NULL AFTER `CompletionText`;

UPDATE quest_template_locale, quest_request_items_locale
SET quest_template_locale.IncompleteText = quest_request_items_locale.CompletionText
WHERE quest_template_locale.entry = quest_request_items_locale.ID AND quest_template_locale.language_code = quest_request_items_locale.locale;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `EndText` `EndText` text CHARACTER SET latin1 NOT NULL AFTER `IncompleteText`;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `ObjectiveText1` `ObjectiveText1` text CHARACTER SET latin1 NOT NULL AFTER `EndText`;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `ObjectiveText2` `ObjectiveText2` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText1`;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `ObjectiveText3` `ObjectiveText3` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText2`;

ALTER TABLE `quest_template_locale` CHANGE COLUMN `ObjectiveText4` `ObjectiveText4` text CHARACTER SET latin1 NOT NULL AFTER `ObjectiveText3`;

-- VerifiedBuild: leave it be for now, it wont harm.

--
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `quest_template_locale` TO `quests_localized`;

--
-- Rename our backup table(s)
--

RENAME TABLE `quest_template_locale2` TO `quest_template_locale`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `quest_template_locale2` ADD PRIMARY KEY (`ID`,`locale`);