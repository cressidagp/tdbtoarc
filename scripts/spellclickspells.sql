/*
=================================================

	TDBtoARC
	
	Title: npc_spellclick_spells to spellclickspells
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `spellclickspells`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `npc_spellclick_spells2` SELECT * FROM `npc_spellclick_spells`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `npc_spellclick_spells` 

	/* #3 */
	DROP COLUMN `cast_flags`,

	/* #4 */
	DROP COLUMN `user_type`;

--
--
-- Here we go...
--
--

ALTER TABLE `npc_spellclick_spells` 

	CHANGE COLUMN `npc_entry` `CreatureID` int(10) unsigned NOT NULL,

	CHANGE COLUMN `spell_id` `SpellID` int(10) unsigned NOT NULL;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `npc_spellclick_spells` TO `spellclickspells`;

--
--
-- Rename our backup table
--
--

RENAME TABLE `npc_spellclick_spells2` TO `npc_spellclick_spells`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `npc_spellclick_spells` ADD PRIMARY KEY (`npc_entry`,`spell_id`);