/*
=================================================
	
	TDBtoARC

	From TDB: 335.21081_2021_08_15

	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql

=================================================
*/

--
-- male1 > 0, fem1 > 0, male2 = 0, fem2 = 0 (case stormwind soldier)
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 = 0);

--
-- male > 0, fem = 0, male2 > 0, fem2 = 0 (case boys only)
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid = 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid = 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid = 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid = 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

--
-- male = 0, fem > 0, male2 > 0, fem2 = 0 (case Sanctum Sentry)
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid = 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid = 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid = 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid = 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

/*
second row male=0, fem>0, male2=0, fem2>0 (girls only, not present at 335.21081_2021_08_15)
second row male=0, fem=0, male2>0, fem2>0 (not present at 335.21081_2021_08_15)
second row male >0, fem =0, male2=0, fem2>0 (not present at 335.21081_2021_08_15)
second row male =0, fem >0, male2>0, fem2>0 (not present at 335.21081_2021_08_15)
*/

--
-- male > 0, fem > 0, male2 = 0, fem2 > 0 (case Troll Berserker)
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 = 0 and creature_names.female_displayid2 != 0);

--
-- male > 0, fem > 0, male2 > 0, fem2 = 0 (case rats)
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 = 0);

--
-- male > 0, fem > 0, male2 > 0, fem2 > 0
--

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -1)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.male_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -3)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -2)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 != 0);

UPDATE creature_spawns, creature_names
SET creature_spawns.displayid = creature_names.female_displayid2
WHERE (creature_spawns.entry = creature_names.entry and creature_spawns.displayid = -4)
AND (creature_names.male_displayid != 0 and creature_names.female_displayid != 0 and creature_names.male_displayid2 != 0 and creature_names.female_displayid2 != 0);

--
--
-- Set displayid to unsigned
--
--

ALTER TABLE `creature_spawns` CHANGE COLUMN `displayid` `displayid` int(30) unsigned NOT NULL DEFAULT '0';