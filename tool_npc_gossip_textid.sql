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

-- TODO: DELETE FROM `gossip_menu` WHERE rowcount > 1;

ALTER TABLE `gossip_menu` CHANGE COLUMN `MenuID` `creatureid` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gossip_menu` CHANGE COLUMN `TextID` `textid` int(10) unsigned NOT NULL DEFAULT '0';

-- VerifiedBuild: leave it be, it wont harm

--
-- Fill me with precious data
--

UPDATE gossip_menu, creature_template
SET gossip_menu.creatureid = creature_template.entry
WHERE (creature_template.gossip_menu_id != 0);

--
-- The End: rename to kickass emu way
--

RENAME TABLE `gossip_menu` TO `npc_gossip_textid`;