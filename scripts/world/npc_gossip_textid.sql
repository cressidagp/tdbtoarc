/*
=================================================

	TDBtoARC
	
	Title: gossip_menu to npc_gossip_textid
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo: arcemu cant handle options
	
	ToDo: plugin cleanup.
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `npc_gossip_textid`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gossip_menu2` SELECT * FROM `gossip_menu`;

--
--
-- Drop not supported column(s)
--
--

/* #3 */
ALTER TABLE `gossip_menu` DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `gossip_menu` 

	DROP PRIMARY KEY,

	ADD COLUMN `id` int(30) unsigned NOT NULL AUTO_INCREMENT PRIMARY KEY,

	CHANGE COLUMN `MenuID` `creatureid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `id`,

	CHANGE COLUMN `TextID` `textid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `creatureid`,

	ADD COLUMN `temp_entry` int(8) unsigned NOT NULL DEFAULT '0' AFTER `textid`;
	

/* Remove when more than one */

CREATE TABLE `gossip_menu_temp` LIKE `gossip_menu`;

ALTER TABLE `gossip_menu_temp` DISABLE KEYS;

INSERT INTO `gossip_menu_temp` SELECT * FROM `gossip_menu`;

ALTER TABLE `gossip_menu_temp` ENABLE KEYS;
	
DELETE FROM `gossip_menu` WHERE `id` NOT IN ( SELECT MAX(`id`) FROM `gossip_menu_temp` GROUP BY `creatureid` );	

/* Fill temp_entry with precious data then set creatureid */

UPDATE gossip_menu, creature_template
SET gossip_menu.temp_entry = creature_template.entry
WHERE (gossip_menu.creatureid = creature_template.gossip_menu_id);

UPDATE `gossip_menu` SET `creatureid` = `temp_entry`;

/* Remove temporary crap */

ALTER TABLE `gossip_menu` DROP COLUMN `id`;

ALTER TABLE `gossip_menu` DROP COLUMN `temp_entry`;

DROP TABLE IF EXISTS `gossip_menu_temp`;

DELETE FROM `gossip_menu` WHERE `creatureid` = 0;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `gossip_menu` TO `npc_gossip_textid`;

ALTER TABLE `npc_gossip_textid` ADD PRIMARY KEY (`creatureid`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gossip_menu2` TO `gossip_menu`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gossip_menu` ADD PRIMARY KEY (`MenuID`,`TextID`);