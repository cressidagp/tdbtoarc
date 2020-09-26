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

ALTER TABLE `npc_text` CHANGE COLUMN `lang0` `lang0`  int(10) unsigned NOT NULL DEFAULT '0' AFTER `text0_1`;

