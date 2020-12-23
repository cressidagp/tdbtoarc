/*
==============================================
	Title: gameobject to gameobject_spawns
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) scale
	*) stateNpcLink (deprecated stuff?)
	*) overrides
		
==============================================
*/

DROP TABLE IF EXISTS `gameobject_spawns`;

--
-- Create a backup of original table...
--

CREATE TABLE `gameobject2` SELECT * FROM `gameobject`;

--
-- Drop not supported columns
--

ALTER TABLE `gameobject` DROP COLUMN `zoneId`;

ALTER TABLE `gameobject` DROP COLUMN `areaId`;

ALTER TABLE `gameobject` DROP COLUMN `spawnMask`;

ALTER TABLE `gameobject` DROP COLUMN `spawntimesecs`;

ALTER TABLE `gameobject` DROP COLUMN `animprogress`;

ALTER TABLE `gameobject` DROP COLUMN `ScriptName`;

ALTER TABLE `gameobject` DROP COLUMN `VerifiedBuild`;

--
-- Here we go...
--

--id: do nothing for now (*)

ALTER TABLE `gameobject` CHANGE COLUMN `id` `Entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `map` `map` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `map` `map` int(10) unsigned NOT NULL DEFAULT '0';

-- phaseMask: do nothing for now (**)

ALTER TABLE `gameobject` CHANGE COLUMN `position_x` `position_x` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `position_y` `position_y` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `position_z` `position_z` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `orientation` `Facing` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `rotation0` `orientation1` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `rotation1` `orientation2` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `rotation2` `orientation3` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `rotation3` `orientation4` float NOT NULL DEFAULT '0';

ALTER TABLE `gameobject` CHANGE COLUMN `state` `State` int(10) unsigned NOT NULL DEFAULT '0';

-- Lets take care of (*):

ALTER TABLE `gameobject` CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT;

-- Lets take care of (**):

ALTER TABLE `gameobject` CHANGE COLUMN `phaseMask` `phase` int(10) unsigned NOT NULL DEFAULT '1' AFTER `State`;

--
-- Add some kickass emu wonderfull columns:
--

ALTER TABLE `gameobject` ADD COLUMN `Flags` int(11) unsigned NOT NULL DEFAULT '0' AFTER `State`;

UPDATE gameobject, gameobject_template_addon
SET gameobject.Flags = gameobject_template_addon.flags
WHERE gameobject.Entry = gameobject_template_addon.entry;

UPDATE gameobject, gameobject_overrides
SET gameobject.Flags = gameobject_overrides.flags
WHERE gameobject.id = gameobject_overrides.spawnId;

ALTER TABLE `gameobject` ADD COLUMN `Faction` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Flags`;

UPDATE gameobject, gameobject_template_addon
SET gameobject.Faction = gameobject_template_addon.faction
WHERE gameobject.Entry = gameobject_template_addon.entry;

-- there arent any faction overrides in tdb at the momment

ALTER TABLE `gameobject` ADD COLUMN `Scale` float NOT NULL DEFAULT '0' AFTER `Faction`;

ALTER TABLE `gameobject` ADD COLUMN `stateNpcLink` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Scale`;

ALTER TABLE `gameobject` ADD COLUMN `overrides` int(10) unsigned NOT NULL DEFAULT '0' AFTER `phase`;

--
-- The End: rename to kickass way and set/remove keys if needed
--

RENAME TABLE `gameobject` TO `gameobject_spawns`;

--
-- Rename our backup table
--

RENAME TABLE `gameobject2` TO `gameobject`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `gameobject` ADD PRIMARY KEY (`guid`);