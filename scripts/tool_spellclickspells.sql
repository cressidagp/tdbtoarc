/*
==============================================
	Title: npc_spellclick_spells to spellclickspells
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
==============================================
*/

DROP TABLE IF EXISTS `spellclickspells`;

--
-- Create a backup of original table...
--

CREATE TABLE `npc_spellclick_spells2` SELECT * FROM `npc_spellclick_spells`;

--
-- Drop not supported columns
--

ALTER TABLE `npc_spellclick_spells` DROP COLUMN `cast_flags`;

ALTER TABLE `npc_spellclick_spells` DROP COLUMN `user_type`;

--
-- Here we go...
--

ALTER TABLE `npc_spellclick_spells` CHANGE COLUMN `npc_entry` `CreatureID` int(10) unsigned NOT NULL;

ALTER TABLE `npc_spellclick_spells` CHANGE COLUMN `spell_id` `SpellID` int(10) unsigned NOT NULL;

--
-- The End: rename to kickass way
--

RENAME TABLE `npc_spellclick_spells` TO `spellclickspells`;

--
-- Rename our backup table
--

RENAME TABLE `npc_spellclick_spells2` TO `npc_spellclick_spells`;