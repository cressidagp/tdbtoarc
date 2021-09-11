/*
=================================================

	TDBtoARC
	
	Title: creature_formations
	
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

DROP TABLE IF EXISTS `creature_formations2`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `creature_formations2` SELECT * FROM `creature_formations`;

--
--
-- Drop not supported column(s)
--
--


ALTER TABLE `creature_formations` 

	/* #5 */
	DROP COLUMN `groupAI`,

	/* #6 */
	DROP COLUMN `point_1`,

	/* #7 */
	DROP COLUMN `point_2`;

--
--
-- Here we go...
--
--

ALTER TABLE `creature_formations` 

	CHANGE COLUMN `memberGUID` `spawn_id` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `leaderGUID` `target_spawn_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spawn_id`,

	CHANGE COLUMN `dist` `follow_dist` float NOT NULL DEFAULT '0',

	CHANGE COLUMN `angle` `follow_angle` float NOT NULL DEFAULT '0' AFTER `target_spawn_id`;

/* from degress to radians */
UPDATE `creature_formations` SET `follow_angle` = (`follow_angle` * PI()) / 180;

/* remove this or they wont move */
DELETE FROM `creature_formations` WHERE `spawn_id` = `target_spawn_id`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `creature_formations2` ADD PRIMARY KEY (`memberGUID`);