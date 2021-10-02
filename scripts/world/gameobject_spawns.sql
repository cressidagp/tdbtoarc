/*
=================================================

	TDBtoARC
	
	Title: gameobject to gameobject_spawns
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	ToDo:
	
	*) scale
	*) stateNpcLink (deprecated stuff?)
	*) overrides
		
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `gameobject_spawns`;

--
-- Create a backup of original table(s)
--

CREATE TABLE `gameobject2` SELECT * FROM `gameobject`;

CREATE TABLE `game_event_gameobject2` SELECT * FROM `game_event_gameobject`;

--
--
-- Goodbay events
--
--

/* Add a temp column to mark all event gameobject */
ALTER TABLE `gameobject` ADD COLUMN `eventEntry` int(4) NOT NULL DEFAULT '0' AFTER `map`;

/* Fill our new column */
UPDATE gameobject, game_event_gameobject
SET gameobject.eventEntry = game_event_gameobject.eventEntry 
WHERE gameobject.guid = game_event_gameobject.guid;

/* Remove all marked gameobjects */
DELETE FROM `gameobject` WHERE `eventEntry` != 0;

/* Not needed anymore */
ALTER TABLE `gameobject` DROP COLUMN `eventEntry`;

/* Not needed anymore */
DROP TABLE IF EXISTS `game_event_gameobject`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `gameobject` 

	/* #4 */
	DROP COLUMN `zoneId`,

	/* #5 */
	DROP COLUMN `areaId`,

	/* #6 */
	DROP COLUMN `spawnMask`,

	/* #16 */
	DROP COLUMN `spawntimesecs`,

	/* #17 */
	DROP COLUMN `animprogress`,

	/* #19 */
	DROP COLUMN `ScriptName`,

	/* #20 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `gameobject`

	/* guid: do nothing for now (A) */

	CHANGE COLUMN `id` `Entry` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `map` `map` int(10) unsigned NOT NULL DEFAULT '0',

	/* phaseMask: do nothing for now (B) */

	CHANGE COLUMN `position_x` `position_x` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `position_y` `position_y` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `position_z` `position_z` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `orientation` `Facing` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `rotation0` `orientation1` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `rotation1` `orientation2` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `rotation2` `orientation3` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `rotation3` `orientation4` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `state` `State` int(10) unsigned NOT NULL DEFAULT '0',

	/* Lets take care of (A): */

	CHANGE COLUMN `guid` `id` int(11) unsigned NOT NULL AUTO_INCREMENT,

	/* Lets take care of (B): */

	CHANGE COLUMN `phaseMask` `phase` int(10) unsigned NOT NULL DEFAULT '1' AFTER `State`,

	ADD COLUMN `Flags` int(11) unsigned NOT NULL DEFAULT '0' AFTER `State`,
	
	ADD COLUMN `Faction` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Flags`,
	
	ADD COLUMN `Scale` float NOT NULL DEFAULT '0' AFTER `Faction`,
	
	ADD COLUMN `stateNpcLink` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Scale`,
	
	ADD COLUMN `overrides` int(10) unsigned NOT NULL DEFAULT '0' AFTER `phase`;

/* Flags: */

UPDATE gameobject, gameobject_template_addon
SET gameobject.Flags = gameobject_template_addon.flags
WHERE gameobject.Entry = gameobject_template_addon.entry;

UPDATE gameobject, gameobject_overrides
SET gameobject.Flags = gameobject_overrides.flags
WHERE gameobject.id = gameobject_overrides.spawnId;

/* Faction: */

UPDATE gameobject, gameobject_template_addon
SET gameobject.Faction = gameobject_template_addon.faction
WHERE gameobject.Entry = gameobject_template_addon.entry;

/* there arent any faction overrides in tdb at the momment */

/* gameobjects with scale = 0 wont be displayed in arcemu */
UPDATE `gameobject` SET `Scale` = 1 WHERE `Scale` = 0;

--
--
-- Rename to kickass way and set/remove key(s) if needed
--
--

RENAME TABLE `gameobject` TO `gameobject_spawns`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject2` TO `gameobject`;

RENAME TABLE `game_event_gameobject2` TO `game_event_gameobject`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gameobject` ADD PRIMARY KEY (`guid`);

ALTER TABLE `game_event_gameobject` ADD PRIMARY KEY (`guid`,`eventEntry`);