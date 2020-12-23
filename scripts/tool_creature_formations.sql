/*
==============================================
	Title: creature_formations to creature_formations
	
	From TDB: 335.20111
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

DROP TABLE IF EXISTS `creature_formations2`;

--
-- Create a backup of original table...
--

CREATE TABLE `creature_formations2` SELECT * FROM `creature_formations`;

--
-- Drop not supported columns
--

ALTER TABLE `creature_formations` DROP COLUMN `groupAI`;

ALTER TABLE `creature_formations` DROP COLUMN `point_1`;

ALTER TABLE `creature_formations` DROP COLUMN `point_2`;

--
-- Here we go...
--

ALTER TABLE `creature_formations` CHANGE COLUMN `memberGUID` `spawn_id` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_formations` CHANGE COLUMN `leaderGUID` `target_spawn_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spawn_id`;

ALTER TABLE `creature_formations` CHANGE COLUMN `dist` `follow_dist` float NOT NULL DEFAULT '0';

ALTER TABLE `creature_formations` CHANGE COLUMN `angle` `follow_angle` float NOT NULL DEFAULT '0' AFTER `target_spawn_id`;

UPDATE `creature_formations` SET `follow_angle` = (`follow_angle` * PI()) / 180; -- from degress to radians

DELETE FROM `creature_formations` WHERE `spawn_id` = `target_spawn_id`; -- remove this or they wont move...

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `creature_formations2` ADD PRIMARY KEY (`memberGUID`);
