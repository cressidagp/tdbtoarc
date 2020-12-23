/*
==============================================
	Title: creature_template_addon to npc_monstersay
	(but we will take info from creature_text and smart_scripts)
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	 
==============================================
*/

DROP TABLE IF EXISTS `npc_monstersay`;

--
-- Create a backup of original table(s)...
--

CREATE TABLE `creature_template_addon2` SELECT * FROM `creature_template_addon`;

--
-- Here we go...
--

ALTER TABLE `creature_template_addon` CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_template_addon` ADD COLUMN `event` int(10) unsigned NOT NULL DEFAULT '0' AFTER `auras`;

ALTER TABLE `creature_template_addon` ADD COLUMN `chance` float NOT NULL DEFAULT '0' AFTER `event`;

/* MONSTER_SAY_EVENTS

    MONSTER_SAY_EVENT_ENTER_COMBAT		= 0,
    MONSTER_SAY_EVENT_RANDOM_WAYPOINT	= 1,
    MONSTER_SAY_EVENT_CALL_HELP			= 2,
    MONSTER_SAY_EVENT_ON_COMBAT_STOP	= 3,
    MONSTER_SAY_EVENT_ON_DAMAGE_TAKEN	= 4,
    MONSTER_SAY_EVENT_ON_DIED			= 5,

*/

UPDATE creature_template_addon, smart_scripts
SET creature_template_addon.chance = smart_scripts.event_chance
WHERE (creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 4 AND smart_scripts.action_type = 1); -- Enter_Combat

UPDATE creature_template_addon, smart_scripts 
SET creature_template_addon.chance = smart_scripts.event_chance
WHERE (creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 6 AND smart_scripts.action_type = 1); -- On_Died

UPDATE creature_template_addon, smart_scripts 
SET creature_template_addon.event = 5
WHERE(creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 6 AND smart_scripts.action_type = 1);

ALTER TABLE `creature_template_addon` ADD COLUMN `language` int(10) unsigned NOT NULL DEFAULT '0' AFTER `chance`;

UPDATE creature_template_addon, creature_text
SET creature_template_addon.language = creature_text.Language
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 0);

ALTER TABLE `creature_template_addon` ADD COLUMN `type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `language`;

UPDATE creature_template_addon, creature_text
SET creature_template_addon.type = creature_text.Type
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 0);

ALTER TABLE `creature_template_addon` ADD COLUMN  `monstername` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `type`;

UPDATE creature_template_addon, creature_template
SET creature_template_addon.monstername = creature_template.name
WHERE creature_template_addon.entry = creature_template.entry;

ALTER TABLE `creature_template_addon` ADD COLUMN `text0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `monstername`;
ALTER TABLE `creature_template_addon` ADD COLUMN `text1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text0`;
ALTER TABLE `creature_template_addon` ADD COLUMN `text2` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text1`;
ALTER TABLE `creature_template_addon` ADD COLUMN `text3` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text2`;
ALTER TABLE `creature_template_addon` ADD COLUMN `text4` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text3`;

UPDATE creature_template_addon, creature_text
SET creature_template_addon.text0 = creature_text.Text
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 0);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.text1 = creature_text.Text
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 1);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.text2 = creature_text.Text
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 2);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.text3 = creature_text.Text
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 3);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.text4 = creature_text.Text
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 4);

-- TODO: see if more events can be added: on leave combat, on die

--
-- Lets cleanup:
--

ALTER TABLE `creature_template_addon` DROP COLUMN `path_id`;
ALTER TABLE `creature_template_addon` DROP COLUMN `mount`;
ALTER TABLE `creature_template_addon` DROP COLUMN `bytes1`;
ALTER TABLE `creature_template_addon` DROP COLUMN `bytes2`;
ALTER TABLE `creature_template_addon` DROP COLUMN `emote`;
ALTER TABLE `creature_template_addon` DROP COLUMN `visibilityDistanceType`;
ALTER TABLE `creature_template_addon` DROP COLUMN `auras`;

DELETE FROM `creature_template_addon` WHERE `text0` IS NULL;

UPDATE `creature_template_addon` SET `text1` = '' WHERE `text1` IS NULL;
UPDATE `creature_template_addon` SET `text2` = '' WHERE `text2` IS NULL;
UPDATE `creature_template_addon` SET `text3` = '' WHERE `text3` IS NULL;
UPDATE `creature_template_addon` SET `text4` = '' WHERE `text4` IS NULL;

DELETE FROM `creature_template_addon` WHERE `chance` = 0;

--
-- The End: rename to kickass emu way
--

RENAME TABLE `creature_template_addon` TO `npc_monstersay`;

ALTER TABLE `npc_monstersay` ADD PRIMARY KEY (`entry`,`event`);

--
-- Rename our backup table(s)
--

RENAME TABLE `creature_template_addon2` TO `creature_template_addon`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `creature_template_addon` ADD PRIMARY KEY (`entry`);