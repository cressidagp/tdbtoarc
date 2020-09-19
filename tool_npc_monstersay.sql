/*
==============================================
	Title: creature_text to npc_monstersay
	
	From TDB: 335.20092
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/
DROP TABLE IF EXISTS `npc_monstersay`;

ALTER TABLE `creature_text` CHANGE COLUMN `CreatureID` `entry` int(10) unsigned NOT NULL DEFAULT '0';

-- ALTER TABLE `creature_text` DROP COLUMN `GroupID`;

-- ALTER TABLE `creature_text` DROP COLUMN `ID`;

ALTER TABLE `creature_text` ADD COLUMN `event` int(10) unsigned NOT NULL DEFAULT '0' AFTER `ID`;

ALTER TABLE `creature_text` CHANGE COLUMN `Text` `text0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci;

ALTER TABLE `creature_text` ADD COLUMN `text1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text0`;
ALTER TABLE `creature_text` ADD COLUMN `text2` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text1`;
ALTER TABLE `creature_text` ADD COLUMN `text3` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text2`;
ALTER TABLE `creature_text` ADD COLUMN `text4` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text3`;

ALTER TABLE `creature_text` CHANGE COLUMN `Type` `type` int(10) unsigned NOT NULL DEFAULT '0';

-- Language: leave it for now, will return to this in (A)

-- Probability: leave it for now, will return to this in (B)

ALTER TABLE `creature_text` DROP COLUMN `Emote`;

ALTER TABLE `creature_text` DROP COLUMN `Duration`;

ALTER TABLE `creature_text` DROP COLUMN `Sound`;

ALTER TABLE `creature_text` DROP COLUMN `BroadCastTextId`;

ALTER TABLE `creature_text` DROP COLUMN `TextRange`;

ALTER TABLE `creature_text` DROP COLUMN `comment`;

-- Lets take care of (B):

ALTER TABLE `creature_text` CHANGE COLUMN `Probability` `chance` int(10) unsigned NOT NULL DEFAULT '0' AFTER `event`;

-- Lets take care of (A):

ALTER TABLE `creature_text` CHANGE COLUMN `Language` `language` int(10) unsigned NOT NULL DEFAULT '0' AFTER `chance`;


-- TODO...


-- The End: rename to kickass emu way

RENAME TABLE `creature_template` TO `npc_monstersay`;