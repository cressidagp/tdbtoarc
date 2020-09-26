/*
==============================================
	Title: gossip_menu to npc_gossip_textid
	
	From TDB: 335.20092
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/
DROP TABLE IF EXISTS `npc_gossip_textid`;

--
-- Prepare structure
--

ALTER TABLE `gossip_menu` DROP PRIMARY KEY;

ALTER TABLE `gossip_menu` ADD COLUMN `id` int(30) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY;

ALTER TABLE `gossip_menu` CHANGE COLUMN `MenuID` `creatureid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `id`;

ALTER TABLE `gossip_menu` CHANGE COLUMN `TextID` `textid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `creatureid`;

ALTER TABLE `gossip_menu` CHANGE COLUMN `VerifiedBuild` `VerifiedBuild` int(5) NOT NULL DEFAULT '0' AFTER `textid`;

ALTER TABLE `gossip_menu` ADD COLUMN `temp_entry` int(8) unsigned NOT NULL DEFAULT '0' AFTER `VerifiedBuild`;

--
-- Remove when more than one...
--

CREATE TABLE `gossip_menu2` LIKE `gossip_menu`;
ALTER TABLE `gossip_menu2` DISABLE KEYS;
INSERT INTO `gossip_menu2` SELECT * FROM `gossip_menu`;
ALTER TABLE `gossip_menu2` ENABLE KEYS;
	
DELETE FROM `gossip_menu` WHERE `id` NOT IN (
SELECT MAX(id)
FROM `gossip_menu2`
GROUP BY creatureid);	

--
-- Fill `temp_entry` with precious data then set creatureid
--

UPDATE gossip_menu, creature_template
SET gossip_menu.temp_entry = creature_template.entry
WHERE (gossip_menu.creatureid = creature_template.gossip_menu_id);

UPDATE `gossip_menu` SET `creatureid` = `temp_entry`;

--
-- Remove temporary crap
--

ALTER TABLE `gossip_menu` DROP COLUMN `id`;
ALTER TABLE `gossip_menu` DROP COLUMN `temp_entry`;

DROP TABLE IF EXISTS `gossip_menu2`;

--
-- Alter table to math arcemu ways
--
DELETE FROM `gossip_menu` WHERE `creatureid` = 0;
ALTER TABLE `gossip_menu` ADD PRIMARY KEY (`creatureid`);

--
-- The End: rename to kickass emu way :P
--

RENAME TABLE `gossip_menu` TO `npc_gossip_textid`;