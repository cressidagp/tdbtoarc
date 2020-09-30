/*
==============================================
	Title: creature_formations to creature_formations
	
	From TDB: 335.20091
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
==============================================
*/

ALTER TABLE `creature_formations` DROP COLUMN `groupAI`;

ALTER TABLE `creature_formations` DROP COLUMN `point_1`;

ALTER TABLE `creature_formations` DROP COLUMN `point_2`;

ALTER TABLE `creature_formations` CHANGE COLUMN `memberGUID` `spawn_id` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `creature_formations` CHANGE COLUMN `leaderGUID` `target_spawn_id` int(10) unsigned NOT NULL DEFAULT '0' AFTER `spawn_id`;

ALTER TABLE `creature_formations` CHANGE COLUMN `dist` `follow_dist` float NOT NULL DEFAULT '0';

ALTER TABLE `creature_formations` CHANGE COLUMN `angle` `follow_angle` float NOT NULL DEFAULT '0' AFTER `target_spawn_id`;

