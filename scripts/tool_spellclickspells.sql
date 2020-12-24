/*
==============================================
	TDBtoARC
	
	Title: npc_spellclick_spells to spellclickspells
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) there are creature with two spells so primary key need to be modified.

==============================================
*/

DROP TABLE IF EXISTS `spellclickspells`;

--
-- Create a backup of original table(s)
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
-- The End: rename to ArcEmu way and set/remove keys if needed
--

RENAME TABLE `npc_spellclick_spells` TO `spellclickspells`;

--
-- Rename our backup table
--

RENAME TABLE `npc_spellclick_spells2` TO `npc_spellclick_spells`;

--
-- Since our backup table(s) will lost his keys we should add them again
--

ALTER TABLE `npc_spellclick_spells` ADD PRIMARY KEY (`npc_entry`,`spell_id`);