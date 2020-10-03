/*
==============================================
	Title: quest_template to quests (THE PAIN)
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/

DROP TABLE IF EXISTS `quests`;

--
-- Create a backup of original table...
--

CREATE TABLE `quest_template2` SELECT * FROM `quest_template`;

--
-- Drop not supported columns
--

ALTER TABLE `quest_template` DROP COLUMN `RequiredFactionId2`;

ALTER TABLE `quest_template` DROP COLUMN `RequiredFactionValue2`;

--
-- Here we go...
--

ALTER TABLE `quest_template` CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0';

-- Will be filled in (A)

ALTER TABLE `quest_template` ADD COLUMN `ZoneId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `entry`;

-- Will be filled in (B)

ALTER TABLE `quest_template` ADD COLUMN `sort` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ZoneId`;

-- Will be filled in (C)

ALTER TABLE `quest_template` ADD COLUMN `flags` int(10) unsigned NOT NULL DEFAULT '0' AFTER `sort`;

ALTER TABLE `quest_template` CHANGE COLUMN `MinLevel` `MinLevel` int(10) unsigned NOT NULL DEFAULT '0' AFTER `flags`;

ALTER TABLE `quest_template` CHANGE COLUMN `QuestLevel` `questlevel` int(10) unsigned NOT NULL DEFAULT '0' AFTER `MinLevel`;

ALTER TABLE `quest_template` CHANGE COLUMN `QuestInfoID` `Type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `questlevel`;

ALTER TABLE `quest_template` CHANGE COLUMN `AllowableRaces` `RequiredRaces` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Type`;

-- Will be filled in (D)

ALTER TABLE `quest_template` ADD COLUMN `RequiredClass` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRaces`;

ALTER TABLE `quest_template` ADD COLUMN `RequiredTradeskill` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredClass`;

UPDATE quest_template, quest_template_addon
SET quest_template.RequiredTradeskill = quest_template_addon.RequiredSkillID
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` ADD COLUMN `RequiredTradeskillValue` int(5) unsigned NOT NULL DEFAULT '0' AFTER `RequiredTradeskill`;

UPDATE quest_template, quest_template_addon
SET quest_template.RequiredTradeskillValue = quest_template_addon.RequiredSkillPoints
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredFactionId1` `RequiredRepFaction` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredTradeskillValue`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredFactionValue1` `RequiredRepValue` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRepFaction`;

-- Will be filled in (E)

ALTER TABLE `quest_template` ADD COLUMN `LimitTime` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRepValue`;


ALTER TABLE `quest_template` ADD COLUMN `SpecialFlags` int(10) unsigned NOT NULL DEFAULT '0' AFTER `LimitTime`;

UPDATE quest_template, quest_template_addon
SET quest_template.SpecialFlags = quest_template_addon.SpecialFlags
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` ADD COLUMN `PrevQuestId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `SpecialFlags`;

UPDATE quest_template, quest_template_addon
SET quest_template.PrevQuestId = quest_template_addon.PrevQuestID
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` ADD COLUMN `NextQuestId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `PrevQuestId`;

UPDATE quest_template, quest_template_addon
SET quest_template.NextQuestId = quest_template_addon.NextQuestID
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` CHANGE COLUMN `StartItem` `srcItem` int(10) unsigned NOT NULL DEFAULT '0' AFTER `NextQuestId`;

ALTER TABLE `quest_template` ADD COLUMN `SrcItemCount` int(10) unsigned NOT NULL DEFAULT '0' AFTER `srcItem`;

UPDATE quest_template, quest_template_addon
SET quest_template.SrcItemCount = quest_template_addon.ProvidedItemCount
WHERE quest_template.ID = quest_template_addon.ID;

ALTER TABLE `quest_template` CHANGE COLUMN `LogTitle` `Title` char(255) NOT NULL AFTER `SrcItemCount`;

ALTER TABLE `quest_template` CHANGE COLUMN `QuestDescription` `Details` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Title`;

ALTER TABLE `quest_template` CHANGE COLUMN `LogDescription` `Objectives` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Details`;

ALTER TABLE `quest_template` ADD COLUMN `CompletionText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Objectives`;

UPDATE quest_template, quest_offer_reward
SET quest_template.CompletionText = quest_offer_reward.RewardText
WHERE quest_template.ID = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `IncompleteText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `CompletionText`;

UPDATE quest_template, quest_request_items
SET quest_template.IncompleteText = quest_request_items.CompletionText
WHERE quest_template.ID = quest_request_items.ID;

-- Will be filled in (F)

ALTER TABLE `quest_template` ADD COLUMN `EndText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `IncompleteText`;

ALTER TABLE `quest_template` CHANGE COLUMN `ObjectiveText1` `ObjectiveText1` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `EndText`;

ALTER TABLE `quest_template` CHANGE COLUMN `ObjectiveText2` `ObjectiveText2` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText1`;

ALTER TABLE `quest_template` CHANGE COLUMN `ObjectiveText3` `ObjectiveText3` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText2`;

ALTER TABLE `quest_template` CHANGE COLUMN `ObjectiveText4` `ObjectiveText4` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText3`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId1` `ReqItemId1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ObjectiveText4`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId2` `ReqItemId2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId1`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId3` `ReqItemId3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId2`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId4` `ReqItemId4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId3`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId5` `ReqItemId5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId4`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemId6` `ReqItemId6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId5`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount1` `ReqItemCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId6`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount2` `ReqItemCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount1`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount3` `ReqItemCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount2`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount4` `ReqItemCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount3`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount5` `ReqItemCount5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount4`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredItemCount6` `ReqItemCount6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount5`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGo1` `ReqKillMobOrGOId1` int(10) NOT NULL DEFAULT '0' AFTER `ReqItemCount6`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGo2` `ReqKillMobOrGOId2` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId1`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGo3` `ReqKillMobOrGOId3` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId2`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGo4` `ReqKillMobOrGOId4` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId3`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGoCount1` `ReqKillMobOrGOCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId4`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGoCount2` `ReqKillMobOrGOCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount1`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGoCount3` `ReqKillMobOrGOCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount2`;

ALTER TABLE `quest_template` CHANGE COLUMN `RequiredNpcOrGoCount4` `ReqKillMobOrGOCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount3`;


-- TODO...............



-- Lets take care of (A):

UPDATE `quest_template` SET `ZoneId` = `QuestSortID` WHERE `QuestSortID` > 0;

-- Lets take care of (B):

UPDATE `quest_template` SET `sort` = `QuestSortID` WHERE `QuestSortID` < 0;

--
-- Remove columns no more needed
--

ALTER TABLE `quest_template` DROP COLUMN `QuestSortID`;

ALTER TABLE `quest_template` DROP COLUMN `Flags`;

ALTER TABLE `quest_template` DROP COLUMN `TimeAllowed`;

--
-- The End: rename to kickass way
--

RENAME TABLE `quest_template` TO `quests`;

--
-- Rename our backup table
--

RENAME TABLE `quest_template2` TO `quest_template`;