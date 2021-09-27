/*
=================================================

	TDBtoARC

	Title: quest_template to quests (THE PAIN)
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	WARNING: this one its extremly slow... go take a nap or something
	
	Note: completeemote is not working i should report to arcemu
		  money not displayed on quest gossip when ready to complete
	
	TODO:
	
	*) ReqCastSpellId1-4
	*) ReqEmoteId1-4
	*) RewRepFaction6
	*) RewRepLimit
	*) RewXP
	*) MailSendItem
	*) RequiredOneOfQuest
	*) RequiredQuest1-4
	*) ReceiveItemId1-4
	*) ReceiveItemCount1-4
	*) IsRepeatable
	*) iscompletedbyspelleffect
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `quests`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `quest_template2` SELECT * FROM `quest_template`;

CREATE TABLE `quest_offer_reward2` SELECT * FROM `quest_offer_reward`;

CREATE TABLE `quest_request_items2` SELECT * FROM `quest_request_items`;

CREATE TABLE `areatrigger_involvedrelation2` SELECT * FROM `areatrigger_involvedrelation`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `quest_template` 

	/* #2: not needed arcemu always set 2 in the packet */
	DROP COLUMN `QuestType`,

	/* #9 */
	DROP COLUMN `RequiredFactionId2`,

	/* #11 */
	DROP COLUMN `RequiredFactionValue2`,

	/* #12 */
	DROP COLUMN `RewardNextQuest`,

	/* #79 */
	DROP COLUMN `QuestCompletionLog`,

	/* #100 */
	DROP COLUMN `Unknown0`,

	/* #105 */
	DROP COLUMN `VerifiedBuild`;
	
--
--
-- Remove Data truncated
--
--

UPDATE `quest_offer_reward` SET `RewardText` = '' WHERE `RewardText` IS NULL;

UPDATE `quest_request_items` SET `CompletionText` = '' WHERE `CompletionText` IS NULL;

UPDATE `quest_template` SET `AreaDescription` = '' WHERE `AreaDescription` IS NULL;

UPDATE `quest_template` SET `ObjectiveText1` = '' WHERE `ObjectiveText1` IS NULL;

UPDATE `quest_template` SET `ObjectiveText2` = '' WHERE `ObjectiveText2` IS NULL;

UPDATE `quest_template` SET `ObjectiveText3` = '' WHERE `ObjectiveText3` IS NULL;

UPDATE `quest_template` SET `ObjectiveText4` = '' WHERE `ObjectiveText4` IS NULL;

--
--
-- Here we go...
--
--

ALTER TABLE `quest_template` 

	CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	ADD COLUMN `ZoneId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `entry`,
	
	ADD COLUMN `sort` int(10) NOT NULL DEFAULT '0' AFTER `ZoneId`,
	
	/* This will be filled later: */
	ADD COLUMN `new_flags` int(10) unsigned NOT NULL DEFAULT '0' AFTER `sort`,
	
	CHANGE COLUMN `MinLevel` `MinLevel` int(10) unsigned NOT NULL DEFAULT '0' AFTER `new_flags`,
	
	CHANGE COLUMN `QuestLevel` `questlevel` int(10) NOT NULL DEFAULT '0' AFTER `MinLevel`,
	
	CHANGE COLUMN `QuestInfoID` `Type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `questlevel`,
	
	CHANGE COLUMN `AllowableRaces` `RequiredRaces` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Type`,
	
	ADD COLUMN `RequiredClass` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRaces`,
	
	ADD COLUMN `RequiredTradeskill` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredClass`,
	
	ADD COLUMN `RequiredTradeskillValue` int(5) unsigned NOT NULL DEFAULT '0' AFTER `RequiredTradeskill`,
	
	CHANGE COLUMN `RequiredFactionId1` `RequiredRepFaction` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredTradeskillValue`,
	
	CHANGE COLUMN `RequiredFactionValue1` `RequiredRepValue` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRepFaction`,
	
	ADD COLUMN `LimitTime` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredRepValue`,
	
	ADD COLUMN `SpecialFlags` int(10) unsigned NOT NULL DEFAULT '0' AFTER `LimitTime`,
	
	-- should be unsigned
	ADD COLUMN `PrevQuestId` int(10) NOT NULL DEFAULT '0' AFTER `SpecialFlags`,
	
	-- should be unsigned
	ADD COLUMN `NextQuestId` int(10) NOT NULL DEFAULT '0' AFTER `PrevQuestId`,
	
	CHANGE COLUMN `StartItem` `srcItem` int(10) unsigned NOT NULL DEFAULT '0' AFTER `NextQuestId`,
	
	ADD COLUMN `SrcItemCount` int(10) unsigned NOT NULL DEFAULT '0' AFTER `srcItem`,
	
	CHANGE COLUMN `LogTitle` `Title` char(255) NOT NULL AFTER `SrcItemCount`,
	
	CHANGE COLUMN `LogDescription` `Details` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Title`,
	
	CHANGE COLUMN `QuestDescription` `Objectives` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Details`,
	
	ADD COLUMN `CompletionText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `Objectives`,
	
	ADD COLUMN `IncompleteText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `CompletionText`,
	
	CHANGE COLUMN `AreaDescription` `EndText` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL  AFTER `IncompleteText`,
	
	CHANGE COLUMN `ObjectiveText1` `ObjectiveText1` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `EndText`,
	
	CHANGE COLUMN `ObjectiveText2` `ObjectiveText2` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText1`,
	
	CHANGE COLUMN `ObjectiveText3` `ObjectiveText3` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText2`,
	
	CHANGE COLUMN `ObjectiveText4` `ObjectiveText4` text CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `ObjectiveText3`,
	
	CHANGE COLUMN `RequiredItemId1` `ReqItemId1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ObjectiveText4`,
	
	CHANGE COLUMN `RequiredItemId2` `ReqItemId2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId1`,
	
	CHANGE COLUMN `RequiredItemId3` `ReqItemId3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId2`,
	
	CHANGE COLUMN `RequiredItemId4` `ReqItemId4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId3`,
	
	CHANGE COLUMN `RequiredItemId5` `ReqItemId5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId4`,
	
	CHANGE COLUMN `RequiredItemId6` `ReqItemId6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId5`,
	
	CHANGE COLUMN `RequiredItemCount1` `ReqItemCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemId6`,
	
	CHANGE COLUMN `RequiredItemCount2` `ReqItemCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount1`,
	
	CHANGE COLUMN `RequiredItemCount3` `ReqItemCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount2`,
	
	CHANGE COLUMN `RequiredItemCount4` `ReqItemCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount3`,
	
	CHANGE COLUMN `RequiredItemCount5` `ReqItemCount5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount4`,
	
	CHANGE COLUMN `RequiredItemCount6` `ReqItemCount6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqItemCount5`,
	
	CHANGE COLUMN `RequiredNpcOrGo1` `ReqKillMobOrGOId1` int(10) NOT NULL DEFAULT '0' AFTER `ReqItemCount6`,
	
	CHANGE COLUMN `RequiredNpcOrGo2` `ReqKillMobOrGOId2` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId1`,
	
	CHANGE COLUMN `RequiredNpcOrGo3` `ReqKillMobOrGOId3` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId2`,
	
	CHANGE COLUMN `RequiredNpcOrGo4` `ReqKillMobOrGOId4` int(10) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId3`,
	
	CHANGE COLUMN `RequiredNpcOrGoCount1` `ReqKillMobOrGOCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOId4`,
	
	CHANGE COLUMN `RequiredNpcOrGoCount2` `ReqKillMobOrGOCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount1`,
	
	CHANGE COLUMN `RequiredNpcOrGoCount3` `ReqKillMobOrGOCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount2`,
	
	CHANGE COLUMN `RequiredNpcOrGoCount4` `ReqKillMobOrGOCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount3`,
	
	ADD COLUMN `ReqCastSpellId1` int(11) NOT NULL DEFAULT '0' AFTER `ReqKillMobOrGOCount4`,
	
	ADD COLUMN `ReqCastSpellId2` int(11) NOT NULL DEFAULT '0' AFTER `ReqCastSpellId1`,
	
	ADD COLUMN `ReqCastSpellId3` int(11) NOT NULL DEFAULT '0' AFTER `ReqCastSpellId2`,
	
	ADD COLUMN `ReqCastSpellId4` int(11) NOT NULL DEFAULT '0' AFTER `ReqCastSpellId3`,
	
	ADD COLUMN `ReqEmoteId1` int(10) unsigned DEFAULT '0' AFTER `ReqCastSpellId4`,
	
	ADD COLUMN `ReqEmoteId2` int(10) unsigned DEFAULT '0' AFTER `ReqEmoteId1`,
	
	ADD COLUMN `ReqEmoteId3` int(10) unsigned DEFAULT '0' AFTER `ReqEmoteId2`,
	
	ADD COLUMN `ReqEmoteId4` int(10) unsigned DEFAULT '0' AFTER `ReqEmoteId3`,
	
	CHANGE COLUMN `RewardChoiceItemID1` `RewChoiceItemId1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReqEmoteId4`,
	
	CHANGE COLUMN `RewardChoiceItemID2` `RewChoiceItemId2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId1`,
	
	CHANGE COLUMN `RewardChoiceItemID3` `RewChoiceItemId3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId2`,
	
	CHANGE COLUMN `RewardChoiceItemID4` `RewChoiceItemId4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId3`,
	
	CHANGE COLUMN `RewardChoiceItemID5` `RewChoiceItemId5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId4`,
	
	CHANGE COLUMN `RewardChoiceItemID6` `RewChoiceItemId6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId5`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity1` `RewChoiceItemCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemId6`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity2` `RewChoiceItemCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount1`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity3` `RewChoiceItemCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount2`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity4` `RewChoiceItemCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount3`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity5` `RewChoiceItemCount5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount4`,
	
	CHANGE COLUMN `RewardChoiceItemQuantity6` `RewChoiceItemCount6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount5`,
	
	CHANGE COLUMN `RewardItem1` `RewItemId1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewChoiceItemCount6`,
	
	CHANGE COLUMN `RewardItem2` `RewItemId2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemId1`,
	
	CHANGE COLUMN `RewardItem3` `RewItemId3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemId2`,
	
	CHANGE COLUMN `RewardItem4` `RewItemId4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemId3`,
	
	CHANGE COLUMN `RewardAmount1` `RewItemCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemId4`,
	
	CHANGE COLUMN `RewardAmount2` `RewItemCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemCount1`,
	
	CHANGE COLUMN `RewardAmount3` `RewItemCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemCount2`,
	
	CHANGE COLUMN `RewardAmount4` `RewItemCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemCount3`,
	
	CHANGE COLUMN `RewardFactionID1` `RewRepFaction1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewItemCount4`,
	
	CHANGE COLUMN `RewardFactionID2` `RewRepFaction2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepFaction1`,
	
	CHANGE COLUMN `RewardFactionID3` `RewRepFaction3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepFaction2`,
	
	CHANGE COLUMN `RewardFactionID4` `RewRepFaction4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepFaction3`,
	
	CHANGE COLUMN `RewardFactionID5` `RewRepFaction5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepFaction4`,
	
	ADD COLUMN `RewRepFaction6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepFaction5`,
	
	CHANGE COLUMN `RewardFactionValue1` `RewRepValue1` int(10) NOT NULL DEFAULT '0' AFTER `RewRepFaction6`,
	
	CHANGE COLUMN `RewardFactionValue2` `RewRepValue2` int(10) NOT NULL DEFAULT '0' AFTER `RewRepValue1`,
	
	CHANGE COLUMN `RewardFactionValue3` `RewRepValue3` int(10) NOT NULL DEFAULT '0' AFTER `RewRepValue2`,
	
	CHANGE COLUMN `RewardFactionValue4` `RewRepValue4` int(10) NOT NULL DEFAULT '0' AFTER `RewRepValue3`,
	
	CHANGE COLUMN `RewardFactionValue5` `RewRepValue5` int(10) NOT NULL DEFAULT '0' AFTER `RewRepValue4`,
	
	ADD COLUMN `RewRepValue6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepValue5`,
	
	ADD COLUMN `RewRepLimit` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewRepValue6`,
	
	CHANGE COLUMN `RewardMoney` `RewMoney` int(10) NOT NULL DEFAULT '0' AFTER `RewRepLimit`,
	
	-- remember use this for custom quests.
	ADD COLUMN `RewXP` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewMoney`,
	
	-- should be unsigned
	CHANGE COLUMN `RewardDisplaySpell` `RewSpell` int(10) NOT NULL DEFAULT '0' AFTER `RewXP`,
	
	 -- should be unsigned
	CHANGE COLUMN `RewardSpell` `CastSpell` int(10) NOT NULL DEFAULT '0' AFTER `RewSpell`,
	
	ADD COLUMN `MailTemplateId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `CastSpell`,
	
	ADD COLUMN `MailDelaySecs` int(10) unsigned NOT NULL DEFAULT '0' AFTER `MailTemplateId`,
	
	ADD COLUMN `MailSendItem` int(10) unsigned NOT NULL DEFAULT '0' AFTER `MailDelaySecs`,
	
	CHANGE COLUMN `POIContinent` `PointMapId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `MailSendItem`,
	
	CHANGE COLUMN `POIx` `PointX` float NOT NULL DEFAULT '0' AFTER `PointMapId`,
	
	CHANGE COLUMN `POIy` `PointY` float NOT NULL DEFAULT '0' AFTER `PointX`,
	
	CHANGE COLUMN `POIPriority` `PointOpt` int(10) unsigned NOT NULL DEFAULT '0' AFTER `PointY`,
	
	CHANGE COLUMN `RewardBonusMoney` `RewardMoneyAtMaxLevel` int(10) unsigned NOT NULL DEFAULT '0' AFTER `PointOpt`,
	
	ADD COLUMN `ExploreTrigger1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RewardMoneyAtMaxLevel`,
	
	ADD COLUMN `ExploreTrigger2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ExploreTrigger1`,
	
	ADD COLUMN `ExploreTrigger3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ExploreTrigger2`,
	
	ADD COLUMN `ExploreTrigger4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ExploreTrigger3`,
	
	ADD COLUMN `RequiredOneOfQuest` longtext NOT NULL AFTER `ExploreTrigger4`,
	
	ADD COLUMN `RequiredQuest1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredOneOfQuest`,
	
	ADD COLUMN `RequiredQuest2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredQuest1`,
	
	ADD COLUMN `RequiredQuest3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredQuest2`,
	
	ADD COLUMN `RequiredQuest4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RequiredQuest3`,
	
	ADD COLUMN `RemoveQuests` longtext NOT NULL AFTER `RequiredQuest4`,
	
	ADD COLUMN `ReceiveItemId1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `RemoveQuests`,
	
	ADD COLUMN `ReceiveItemId2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemId1`,
	
	ADD COLUMN `ReceiveItemId3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemId2`,
	
	ADD COLUMN `ReceiveItemId4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemId3`,
	
	ADD COLUMN `ReceiveItemCount1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemId4`,
	
	ADD COLUMN `ReceiveItemCount2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemCount1`,
	
	ADD COLUMN `ReceiveItemCount3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemCount2`,
	
	ADD COLUMN `ReceiveItemCount4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ReceiveItemCount3`,
	
	ADD COLUMN `IsRepeatable` int(11) NOT NULL DEFAULT '0' AFTER `ReceiveItemCount4`,
	
	CHANGE COLUMN `RewardHonor` `bonushonor` int(10) unsigned NOT NULL DEFAULT '0' AFTER `IsRepeatable`,
	
	CHANGE COLUMN `RewardArenaPoints` `bonusarenapoints` int(10) unsigned NOT NULL DEFAULT '0' AFTER `bonushonor`,
	
	CHANGE COLUMN `RewardTitle` `rewardtitleid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `bonusarenapoints`,
	
	CHANGE COLUMN `RewardTalents` `rewardtalents` int(10) unsigned NOT NULL DEFAULT '0' AFTER `rewardtitleid`,
	
	CHANGE COLUMN `SuggestedGroupNum` `suggestedplayers` int(10) unsigned NOT NULL DEFAULT '0' AFTER `rewardtalents`,
	
	ADD COLUMN `detailemotecount` int(10) unsigned NOT NULL DEFAULT '0' AFTER `suggestedplayers`;
	
/* ZoneId: */
UPDATE `quest_template` SET `ZoneId` = `QuestSortID` WHERE `QuestSortID` > 0;

/* sort: */
UPDATE `quest_template` SET `sort` = `QuestSortID` WHERE `QuestSortID` < 0;
UPDATE `quest_template` SET `sort` = `sort`* (-1);
ALTER TABLE `quest_template` CHANGE COLUMN `sort` `sort` int(10) unsigned NOT NULL DEFAULT '0';

/* questlevel: */
UPDATE `quest_template` SET `questlevel` = `questlevel`* (-1) WHERE `questlevel` < 0;
ALTER TABLE `quest_template` CHANGE COLUMN `questlevel` `questlevel` int(10) unsigned NOT NULL DEFAULT '0';

/* RequiredClass: */
UPDATE quest_template, quest_template_addon
SET quest_template.RequiredClass = quest_template_addon.AllowableClasses
WHERE quest_template.entry = quest_template_addon.ID;

/* RequiredTradeskill: */
UPDATE quest_template, quest_template_addon
SET quest_template.RequiredTradeskill = quest_template_addon.RequiredSkillID
WHERE quest_template.entry = quest_template_addon.ID;

/* RequiredTradeskillValue: */
UPDATE quest_template, quest_template_addon
SET quest_template.RequiredTradeskillValue = quest_template_addon.RequiredSkillPoints
WHERE quest_template.entry = quest_template_addon.ID;

/* LimitTime: */
UPDATE `quest_template` SET `LimitTime` = `TimeAllowed` * 1000 WHERE `TimeAllowed` != 0;

/* SpecialFlags: */
UPDATE quest_template, quest_template_addon
SET quest_template.SpecialFlags = quest_template_addon.SpecialFlags
WHERE quest_template.entry = quest_template_addon.ID;

/* PrevQuestID: if value > 0: Contains the previous quest id, that must be completed before this quest can be started.
PrevQuestID: If value < 0: Contains the parent quest id, that must be active before this quest can be started. */

UPDATE quest_template, quest_template_addon
SET quest_template.PrevQuestId = quest_template_addon.PrevQuestID
WHERE quest_template.entry = quest_template_addon.ID and quest_template_addon.PrevQuestID > 0;

/* TODO: PrevQuestID < 0 */

/* NextQuestID: Contains the next quest id, in case PrevQuestId of that other quest is not sufficient. */
UPDATE quest_template, quest_template_addon
SET quest_template.NextQuestId = quest_template_addon.NextQuestID
WHERE quest_template.entry = quest_template_addon.ID;

/* SrcItemCount: */
UPDATE quest_template, quest_template_addon
SET quest_template.SrcItemCount = quest_template_addon.ProvidedItemCount
WHERE quest_template.entry = quest_template_addon.ID;

/* CompletionText: */
UPDATE quest_template, quest_offer_reward
SET quest_template.CompletionText = quest_offer_reward.RewardText
WHERE quest_template.entry = quest_offer_reward.ID;

/* IncompleteText: */
UPDATE quest_template, quest_request_items
SET quest_template.IncompleteText = quest_request_items.CompletionText
WHERE quest_template.entry = quest_request_items.ID;

/* MailTemplateId: */
UPDATE quest_template, quest_template_addon
SET quest_template.MailTemplateId = quest_template_addon.RewardMailTemplateID
WHERE quest_template.entry = quest_template_addon.ID;

/* MailDelaySecs: */
UPDATE quest_template, quest_template_addon
SET quest_template.MailDelaySecs = quest_template_addon.RewardMailDelay
WHERE quest_template.entry = quest_template_addon.ID;

-- For NOW:

UPDATE `quest_template` SET `ExploreTrigger1` = 231, `ExploreTrigger2` = 232, `ExploreTrigger3` = 235 WHERE `entry` = 984;

UPDATE `quest_template` SET `ExploreTrigger1` = 5705, `ExploreTrigger2` = 5706  WHERE `entry` = 24541;

UPDATE `quest_template` SET `ExploreTrigger1` = 5703, `ExploreTrigger2` = 5704  WHERE `entry` = 24656;

DELETE FROM `areatrigger_involvedrelation` WHERE `quest` IN ( 984, 24541, 24656 );

UPDATE quest_template, areatrigger_involvedrelation
SET quest_template.ExploreTrigger1 = areatrigger_involvedrelation.id
WHERE quest_template.entry = areatrigger_involvedrelation.quest;

UPDATE `quest_template` SET `RequiredQuest1` = `PrevQuestId`;

UPDATE quest_template, quest_details
SET quest_template.detailemotecount = 1
WHERE quest_template.entry = quest_details.ID 
AND (quest_details.Emote1 != 0 and quest_details.Emote2 = 0 and quest_details.Emote3 = 0 and quest_details.Emote4 = 0);

UPDATE quest_template, quest_details
SET quest_template.detailemotecount = 2
WHERE quest_template.entry = quest_details.ID 
AND (quest_details.Emote1 != 0 and quest_details.Emote2 != 0 and quest_details.Emote3 = 0 and quest_details.Emote4 = 0);

UPDATE quest_template, quest_details
SET quest_template.detailemotecount = 3
WHERE quest_template.entry = quest_details.ID 
AND (quest_details.Emote1 != 0 and quest_details.Emote2 != 0 and quest_details.Emote3 != 0 and quest_details.Emote4 = 0);

UPDATE quest_template, quest_details
SET quest_template.detailemotecount = 4
WHERE quest_template.entry = quest_details.ID 
AND (quest_details.Emote1 != 0 and quest_details.Emote2 != 0 and quest_details.Emote3 != 0 and quest_details.Emote4 != 0);

ALTER TABLE `quest_template` ADD COLUMN `detailemote1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemotecount`;

UPDATE quest_template, quest_details
SET quest_template.detailemote1 = quest_details.Emote1
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemote2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemote1`;

UPDATE quest_template, quest_details
SET quest_template.detailemote2 = quest_details.Emote2
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemote3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemote2`;

UPDATE quest_template, quest_details
SET quest_template.detailemote3 = quest_details.Emote3
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemote4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemote3`;

UPDATE quest_template, quest_details
SET quest_template.detailemote4 = quest_details.Emote4
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemotedelay1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemote4`;

UPDATE quest_template, quest_details
SET quest_template.detailemotedelay1 = quest_details.EmoteDelay1
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemotedelay2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemotedelay1`;

UPDATE quest_template, quest_details
SET quest_template.detailemotedelay2 = quest_details.EmoteDelay2
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemotedelay3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemotedelay2`;

UPDATE quest_template, quest_details
SET quest_template.detailemotedelay3 = quest_details.EmoteDelay3
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `detailemotedelay4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemotedelay3`;

UPDATE quest_template, quest_details
SET quest_template.detailemotedelay4 = quest_details.EmoteDelay4
WHERE quest_template.entry = quest_details.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemotecnt` int(10) unsigned NOT NULL DEFAULT '0' AFTER `detailemotedelay4`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotecnt = 1
WHERE quest_template.entry = quest_offer_reward.ID
AND (quest_offer_reward.Emote1 != 0 and quest_offer_reward.Emote2 = 0 and quest_offer_reward.Emote3 = 0 and quest_offer_reward.Emote4 = 0);

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotecnt = 2
WHERE quest_template.entry = quest_offer_reward.ID
AND (quest_offer_reward.Emote1 != 0 and quest_offer_reward.Emote2 != 0 and quest_offer_reward.Emote3 = 0 and quest_offer_reward.Emote4 = 0);

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotecnt = 3
WHERE quest_template.entry = quest_offer_reward.ID
AND (quest_offer_reward.Emote1 != 0 and quest_offer_reward.Emote2 != 0 and quest_offer_reward.Emote3 != 0 and quest_offer_reward.Emote4 = 0);

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotecnt = 4
WHERE quest_template.entry = quest_offer_reward.ID
AND (quest_offer_reward.Emote1 != 0 and quest_offer_reward.Emote2 != 0 and quest_offer_reward.Emote3 != 0 and quest_offer_reward.Emote4 != 0);

ALTER TABLE `quest_template` ADD COLUMN `completionemote1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemotecnt`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemote1 = quest_offer_reward.Emote1
WHERE quest_template.entry = quest_offer_reward.ID; 

ALTER TABLE `quest_template` ADD COLUMN `completionemote2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemote1`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemote2 = quest_offer_reward.Emote2
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemote3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemote2`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemote3 = quest_offer_reward.Emote3
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemote4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemote3`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemote4 = quest_offer_reward.Emote4
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemotedelay1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemote4`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotedelay1 = quest_offer_reward.EmoteDelay1
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemotedelay2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemotedelay1`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotedelay2 = quest_offer_reward.EmoteDelay2
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemotedelay3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemotedelay2`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotedelay3 = quest_offer_reward.EmoteDelay3
WHERE quest_template.entry = quest_offer_reward.ID;

ALTER TABLE `quest_template` ADD COLUMN `completionemotedelay4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemotedelay3`;

UPDATE quest_template, quest_offer_reward
SET quest_template.completionemotedelay4 = quest_offer_reward.EmoteDelay4
WHERE quest_template.entry = quest_offer_reward.ID;

-- research tdb vermien quest has EmoteOnComplete = 1(talk), EmoteOnIncomplete = 6(question)

-- in game with arcdb on click (quest marked complete false) he question, 

ALTER TABLE `quest_template` ADD COLUMN `completeemote` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completionemotedelay4`;

UPDATE quest_template, quest_request_items
SET quest_template.completeemote = quest_request_items.EmoteOnComplete
WHERE quest_template.entry = quest_request_items.ID;

ALTER TABLE `quest_template` ADD COLUMN `incompleteemote` int(10) unsigned NOT NULL DEFAULT '0' AFTER `completeemote`;

UPDATE quest_template, quest_request_items
SET quest_template.incompleteemote = quest_request_items.EmoteOnIncomplete
WHERE quest_template.entry = quest_request_items.ID;

ALTER TABLE `quest_template` ADD COLUMN `iscompletedbyspelleffect` int(10) unsigned NOT NULL DEFAULT '0' AFTER `incompleteemote`;

ALTER TABLE `quest_template` CHANGE COLUMN `RewardXPDifficulty` `RewXPId` int(10) unsigned NOT NULL DEFAULT '0' AFTER `iscompletedbyspelleffect`;

/* falgs: */
UPDATE `quest_template` SET `new_flags` = `Flags`;

ALTER TABLE `quest_template`

	DROP COLUMN `Flags`,

	CHANGE COLUMN `new_flags` `flags` int(10) unsigned NOT NULL DEFAULT '0';

--
--
-- Remove column(s) no more needed
--
--

ALTER TABLE `quest_template` 

	DROP COLUMN `QuestSortID`,

	DROP COLUMN `TimeAllowed`,

	DROP COLUMN `RewardFactionOverride1`,

	DROP COLUMN `RewardFactionOverride2`,

	DROP COLUMN `RewardFactionOverride3`,

	DROP COLUMN `RewardFactionOverride4`,

	DROP COLUMN `RewardFactionOverride5`,

	DROP COLUMN `RewardKillHonor`,

	DROP COLUMN `RequiredPlayerKills`,

	DROP COLUMN `ItemDrop1`,

	DROP COLUMN `ItemDropQuantity1`,

	DROP COLUMN `ItemDrop2`,

	DROP COLUMN `ItemDropQuantity2`,

	DROP COLUMN `ItemDrop3`,

	DROP COLUMN `ItemDropQuantity3`,

	DROP COLUMN `ItemDrop4`,

	DROP COLUMN `ItemDropQuantity4`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `quest_template` TO `quests`;

--
--
-- Remove pillaged table(s)
--
--

DROP TABLE IF EXISTS 

	`quest_offer_reward`,

	`quest_request_items`,

	`areatrigger_involvedrelation`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `quest_template2` TO `quest_template`;

RENAME TABLE `quest_offer_reward2` TO `quest_offer_reward`;

RENAME TABLE `quest_request_items2` TO `quest_request_items`;

RENAME TABLE `areatrigger_involvedrelation2` TO `areatrigger_involvedrelation`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `quest_template` ADD PRIMARY KEY (`ID`);

ALTER TABLE `quest_offer_reward` ADD PRIMARY KEY (`ID`);

ALTER TABLE `quest_request_items` ADD PRIMARY KEY (`ID`);

ALTER TABLE `areatrigger_involvedrelation` ADD PRIMARY KEY (`ID`);