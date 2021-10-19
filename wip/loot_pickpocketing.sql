/*
=================================================

	TDBtoARC
	
	Title: pickpocketing_loot_template to loot_pickpocketing
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	TODO: item = 1 and item = 2 WTF is this?
	
=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `loot_pickpocketing`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `pickpocketing_loot_template2` SELECT * FROM `pickpocketing_loot_template`;

--
--
-- Ugly hack for shared pickpocketloot
--
--

/* 1200, 2588, 20474 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (24782, 24477, 23008 );

/* 25351 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (24540, 25224, 25351, 25383, 26343, 26492, 26891, 26946, 27224, 27226, 27283, 27360, 27552, 27799, 27823, 27826, 28564, 28750 );

/* 25430 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (23656, 23663, 23665, 25430, 25434, 26728, 26827, 26926, 27554, 32572);

/* 26481 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (23940, 24016, 24161, 26481, 26493, 26655, 27007, 27009);

/* 27533 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (26669, 26670, 26694, 26830, 27533, 27871, 28022, 28108, 28242, 28268, 28419, 29123, 29133, 29722, 29738, 30701, 30894, 30922, 30949, 
31139, 31150, 31779, 31847, 32278, 32505);

/* 30319 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (30179, 30319);

/* 16507, 16523, 16593, 16594, 16699, 16700, 16704, 17370, 17371, 17395, 17397, 17398, 17414, 17420, 17427, 17461, 17462, 17464, 17465, 17491, 17626, 17670, 17671, 17694, 17695, 17993, 17994, 18155, 18404, 18419
18420, 18421, 18422, 19486, 19505, 19508, 19509, 19511, 19512, 19633, 19843 */
UPDATE `creature_template` SET `pickpocketloot` = 0 WHERE `entry` IN (20593, 20591, 20582, 20576, 20590, 20589, 20594, 18053, 18619, 18617, 18615, 18612, 18618, 20587, 20579, 20581, 20595, 20586, 20583, 
18610, 18609, 20588, 20584, 20577, 20580, 21548, 21545, 21544, 21549, 21546, 21574, 21577, 21570, 21572, 21571, 21576, 21575, 21563, 21564, 21547, 21565);

--
--
-- I don't wanna talk, about things we've gone through... (melancolic mode on)
--
--

ALTER TABLE `pickpocketing_loot_template` ADD COLUMN `creatureid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE pickpocketing_loot_template, creature_template
SET pickpocketing_loot_template.creatureid = creature_template.Entry
WHERE pickpocketing_loot_template.Entry = creature_template.pickpocketloot;

ALTER TABLE `reference_loot_template` ADD COLUMN `creatureid` int(10) unsigned NOT NULL DEFAULT '0' AFTER `Comment`;

UPDATE reference_loot_template, pickpocketing_loot_template
SET reference_loot_template.creatureid = pickpocketing_loot_template.creatureid
WHERE reference_loot_template.Entry = pickpocketing_loot_template.Reference;

INSERT INTO `pickpocketing_loot_template` 
SELECT `Entry`, `Item`, Reference, `Chance`, `QuestRequired`, `LootMode`, `GroupId`, `MinCount`, `MaxCount`, `Comment`, `creatureid`
FROM `reference_loot_template` 
WHERE `creatureid` != 0;

UPDATE `pickpocketing_loot_template` SET `Entry` = `creatureid` WHERE `creatureid` != 0;

ALTER TABLE `pickpocketing_loot_template` DROP COLUMN `creatureid`;

ALTER TABLE `reference_loot_template` DROP COLUMN `creatureid`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `pickpocketing_loot_template` 

	/* #3  */
	DROP COLUMN `Reference`,

	/* #5  */
	DROP COLUMN `QuestRequired`,

	/* #6  */
	DROP COLUMN `LootMode`,

	/* #7  */
	DROP COLUMN `GroupId`;

--
--
-- Here we go...
--
--

ALTER TABLE `pickpocketing_loot_template` 

	CHANGE COLUMN `Entry` `entryid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Item` `itemid` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Chance` `normal10percentchance` float NOT NULL DEFAULT '0',

	ADD COLUMN `normal25percentchance` float NOT NULL DEFAULT '0' AFTER `normal10percentchance`,

	ADD COLUMN `heroic10percentchance` float NOT NULL DEFAULT '0' AFTER `normal25percentchance`,

	ADD COLUMN `heroic25percentchance` float NOT NULL DEFAULT '0' AFTER `heroic10percentchance`,

	CHANGE COLUMN `MinCount` `mincount` int(30) unsigned NOT NULL DEFAULT '1',

	CHANGE COLUMN `MaxCount` `maxcount` int(30) unsigned NOT NULL DEFAULT '1';


--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `pickpocketing_loot_template` TO `loot_pickpocketing`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `pickpocketing_loot_template2` TO `pickpocketing_loot_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `pickpocketing_loot_template` ADD PRIMARY KEY (`Entry`,`Item`);