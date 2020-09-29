/*
==============================================
	Title: npc_text to npc_text
	
	From TDB: 335.20092
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

ALTER TABLE `npc_text` CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `Probability0` `prob0` float NOT NULL DEFAULT '0' AFTER `entry`;

ALTER TABLE `npc_text` CHANGE COLUMN `text0_0` `text0_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob0`;

ALTER TABLE `npc_text` CHANGE COLUMN `text0_1` `text0_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text0_0`;

ALTER TABLE `gossip_menu` DROP COLUMN `BroadcastTextID0`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang0` `lang0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text0_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_0` `EmoteDelay0_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang0`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_0` `temp_Emote0_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay0_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_1` `temp_EmoteDelay0_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote0_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_1` `temp_Emote0_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay0_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_2` `temp_EmoteDelay0_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote0_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_2` `temp_Emote0_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay0_4`;

ALTER TABLE `npc_text` CHANGE COLUMN `Probability1` `prob1` float NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay0_4`;

ALTER TABLE `npc_text` CHANGE COLUMN `text1_0` `text1_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob1`;

ALTER TABLE `npc_text` CHANGE COLUMN `text1_1` `text1_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text1_0`;

ALTER TABLE `gossip_menu` DROP COLUMN `BroadcastTextID1`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang1` `lang1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text1_1`;

--
-- Rename all temporary columns
--

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_1` `Emote0_1`;
ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay0_2` `EmoteDelay0_2`;
ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_3` `Emote0_3`;
ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay0_4` EmoteDelay0_4`;
ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_5` `Emote0_5`;