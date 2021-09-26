/*
=================================================

	TDBtoARC
	
	Title: creature_template_addon to npc_monstersay
	(but we will take info from creature_text and smart_scripts)
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDO: 
	
	*) see if more events can be added: on leave combat, on die
	*) plugin cleanup
	 
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `npc_monstersay`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_template_addon2` SELECT * FROM `creature_template_addon`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `creature_template_addon` 

	DROP COLUMN `path_id`,
	
	DROP COLUMN `mount`,
	
	DROP COLUMN `bytes1`,
	
	DROP COLUMN `bytes2`,
	
	DROP COLUMN `emote`,
	
	DROP COLUMN `visibilityDistanceType`,
	
	DROP COLUMN `auras`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature_template_addon` 

	CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	ADD COLUMN `event` int(10) unsigned NOT NULL DEFAULT '0' AFTER `entry`,

	ADD COLUMN `chance` float NOT NULL DEFAULT '0' AFTER `event`,
	
	ADD COLUMN `language` int(10) unsigned NOT NULL DEFAULT '0' AFTER `chance`,
	
	ADD COLUMN `type` int(10) unsigned NOT NULL DEFAULT '0' AFTER `language`,
	
	ADD COLUMN  `monstername` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `type`,
	
	ADD COLUMN `text0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `monstername`,
	
	ADD COLUMN `text1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text0`,
	
	ADD COLUMN `text2` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text1`,
	
	ADD COLUMN `text3` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text2`,
	
	ADD COLUMN `text4` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci AFTER `text3`;

/* Events

    0: OnEnterCombat
    1: OnRandomWaypoint
    2: OnCallForHelp
    3: OnCombatStop
    4: OnDamageTaken
    5: OnDied */

UPDATE creature_template_addon, smart_scripts
SET creature_template_addon.chance = smart_scripts.event_chance
WHERE (creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 4 AND smart_scripts.action_type = 1);

UPDATE creature_template_addon, smart_scripts 
SET creature_template_addon.chance = smart_scripts.event_chance
WHERE (creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 6 AND smart_scripts.action_type = 1);

UPDATE creature_template_addon, smart_scripts 
SET creature_template_addon.event = 5
WHERE(creature_template_addon.entry = smart_scripts.entryorguid AND smart_scripts.event_type = 6 AND smart_scripts.action_type = 1);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.language = creature_text.Language
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 0);

UPDATE creature_template_addon, creature_text
SET creature_template_addon.type = creature_text.Type
WHERE (creature_template_addon.entry = creature_text.CreatureID AND creature_text.GroupID = 0 AND creature_text.ID = 0);

UPDATE creature_template_addon, creature_template
SET creature_template_addon.monstername = creature_template.name
WHERE creature_template_addon.entry = creature_template.entry;

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

--
--
-- Cleanups
--
--

DELETE FROM `creature_template_addon` WHERE `text0` IS NULL;

UPDATE `creature_template_addon` SET `text1` = '' WHERE `text1` IS NULL;

UPDATE `creature_template_addon` SET `text2` = '' WHERE `text2` IS NULL;

UPDATE `creature_template_addon` SET `text3` = '' WHERE `text3` IS NULL;

UPDATE `creature_template_addon` SET `text4` = '' WHERE `text4` IS NULL;

DELETE FROM `creature_template_addon` WHERE `chance` = 0;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature_template_addon` TO `npc_monstersay`;

ALTER TABLE `npc_monstersay` 

	DROP PRIMARY KEY,

	ADD PRIMARY KEY (`entry`,`event`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature_template_addon2` TO `creature_template_addon`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature_template_addon` ADD PRIMARY KEY (`entry`);