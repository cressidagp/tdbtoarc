/*
=================================================

	TDBtoARC
	
	Title: skill_discovery_template to professiondiscoveries
	
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

DROP TABLE IF EXISTS `professiondiscoveries`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `skill_discovery_template2` SELECT * FROM `skill_discovery_template`;

--
--
-- Here we go...
--
--

ALTER TABLE `skill_discovery_template` 

	CHANGE COLUMN `spellId` `SpellId` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `reqSpell` `SpellToDiscover` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `reqSkillValue` `SkillValue` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `chance` `Chance` float NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `skill_discovery_template` TO `professiondiscoveries`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `skill_discovery_template2` TO `skill_discovery_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `skill_discovery_template` ADD PRIMARY KEY (`spellId`,`reqSpell`);