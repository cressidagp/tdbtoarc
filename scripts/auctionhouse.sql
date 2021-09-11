/*
=================================================

	TDBtoARC
	
	Title: creature to auctionhouse
	
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

DROP TABLE IF EXISTS `auctionhouse`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature2` SELECT * FROM `creature`;

--
--
-- Delete all creatures
--
--

DELETE FROM `creature` WHERE `id` NOT IN ( 8661, 8669, 8670, 8671, 8672, 8673, 8674, 8719, 8720, 8721, 8722, 8723, 8724, 9856, 9857, 9858, 9859, 15659, 15675, 15676, 15677, 15678, 15679, 15681, 15682, 15683, 15684, 15686, 16627, 16628, 16629, 16707, 17627, 17628, 17629, 18348, 18349, 18761, 31430, 35594, 35607 );

--
--
-- Drop not supported column(s)
--
--


ALTER TABLE `creature` 

	/* #1 */
	DROP COLUMN `guid`,

	/* #3 */
	DROP COLUMN `map`,

	/* #4 */
	DROP COLUMN `zoneId`,

	/* #5 */
	DROP COLUMN `areaId`,

	/* #6 */
	DROP COLUMN `spawnMask`,

	/* #7 */
	DROP COLUMN `phaseMask`,

	/* #8 */
	DROP COLUMN `modelid`,

	/* #9 */
	DROP COLUMN `equipment_id`,

	/* #10 */
	DROP COLUMN `position_x`,

	/* #11 */
	DROP COLUMN `position_y`,

	/* #12 */
	DROP COLUMN `position_z`,

	/* #13 */
	DROP COLUMN `orientation`,

	/* #14 */
	DROP COLUMN `spawntimesecs`,

	/* #15 */
	DROP COLUMN `wander_distance`,

	/* #16 */
	DROP COLUMN `currentwaypoint`,

	/* #17 */
	DROP COLUMN `curhealth`,

	/* #18 */
	DROP COLUMN `curmana`,

	/* #19 */
	DROP COLUMN `MovementType`,

	/* #20 */
	DROP COLUMN `npcflag`,

	/* #21 */
	DROP COLUMN `unit_flags`,

	/* #22 */
	DROP COLUMN `dynamicflags`,

	/* #23 */
	DROP COLUMN `ScriptName`,

	/* #24 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature` 

	CHANGE COLUMN `id` `creature_entry` int(30) unsigned NOT NULL DEFAULT '0',

	ADD COLUMN `ahgroup` int(32) NOT NULL DEFAULT '0' AFTER `creature_entry`;

/* ahgroup

	1: Stormwind
	2: Alliance
	3: Darnassus
	4: Undercity
	5: Thunderbluff
	6: Horde
	7: Neutral */

-- stormwind
UPDATE creature, creature_template
SET creature.ahgroup = 1
WHERE (creature.creature_entry = creature_template.entry AND creature_template.faction = 12);

-- alliance
UPDATE creature, creature_template
SET creature.ahgroup = 2
WHERE creature.creature_entry = creature_template.entry AND (creature_template.faction = 55 or creature_template.faction = 534 or creature_template.faction = 1638);

-- darnassus
UPDATE creature, creature_template
SET creature.ahgroup = 3
WHERE (creature.creature_entry = creature_template.entry AND creature_template.faction = 80);

-- undercity
UPDATE creature, creature_template
SET creature.ahgroup = 4
WHERE (creature.creature_entry = creature_template.entry AND creature_template.faction = 68);

-- thunderbluff
UPDATE creature, creature_template
SET creature.ahgroup = 5
WHERE (creature.creature_entry = creature_template.entry AND creature_template.faction = 104);

-- horde
UPDATE creature, creature_template
SET creature.ahgroup = 6
WHERE creature.creature_entry = creature_template.entry AND (creature_template.faction = 29 or creature_template.faction = 714 or creature_template.faction = 1604);

-- neutral
UPDATE creature, creature_template
SET creature.ahgroup = 7
WHERE creature.creature_entry = creature_template.entry AND (creature_template.faction = 120 or creature_template.faction = 474 or creature_template.faction = 855);

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `creature` TO `auctionhouse`;

ALTER TABLE `auctionhouse` ADD PRIMARY KEY (`creature_entry`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `creature2` TO `creature`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature` 

	ADD PRIMARY KEY (`guid`),

	ADD KEY `idx_map` (`map`),

	ADD KEY `idx_id` (`id`);