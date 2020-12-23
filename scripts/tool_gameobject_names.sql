/*
==============================================
	Title: gameobject_template to gameobject_names
	
	From TDB: 335.20121
	to
	Arc: 2012-08-04_21-25_worldmap_info.sql
		
==============================================
*/

DROP TABLE IF EXISTS `gameobject_names`;

--
-- Create a backup of original table...
--

CREATE TABLE `gameobject_template2` SELECT * FROM `gameobject_template`;

--
-- Drop not supported columns
--

ALTER TABLE `gameobject_template` DROP COLUMN `AIName`;

ALTER TABLE `gameobject_template` DROP COLUMN `ScriptName`;

ALTER TABLE `gameobject_template` DROP COLUMN `VerifiedBuild`;

--
-- Here we go...
--

ALTER TABLE `gameobject_template` CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `type` `Type` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `displayId` `DisplayID` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `name` `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE `gameobject_template` CHANGE COLUMN `name` `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL;

ALTER TABLE `gameobject_template` CHANGE COLUMN `IconName` `Category` varchar(100) NOT NULL;

ALTER TABLE `gameobject_template` CHANGE COLUMN `castBarCaption` `CastBarText` varchar(100) NOT NULL;

ALTER TABLE `gameobject_template` CHANGE COLUMN `unk1` `UnkStr` varchar(100) NOT NULL;

-- size: will return to this later (*)

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data0` `spellfocus` int(10) unsigned NOT NULL DEFAULT '0';

UPDATE `gameobject_template` SET `Data1` = 0 WHERE `Data1` = -1;

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data1` `sound1` int(10) unsigned NOT NULL DEFAULT '0'; --

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data2` `sound2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data3` `sound3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data4` `sound4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data5` `sound5` int(10) unsigned NOT NULL DEFAULT '0';

UPDATE `gameobject_template` SET `Data6` = 0 WHERE `Data6` = -1;

UPDATE `gameobject_template` SET `Data6` = 0 WHERE `Data6` = -1000;

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data6` `sound6` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data7` `sound7` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data8` `sound8` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data9` `sound9` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data10` `unknown1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data11` `unknown2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data12` `unknown3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data13` `unknown4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data14` `unknown5` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data15` `unknown6` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data16` `unknown7` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data17` `unknown8` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data18` `unknown9` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data19` `unknown10` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data20` `unknown11` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data21` `unknown12` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data22` `unknown13` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` CHANGE COLUMN `Data23` `unknown14` int(10) unsigned NOT NULL DEFAULT '0';

-- Lets take care of (*):

ALTER TABLE `gameobject_template` CHANGE COLUMN `size` `Size` float NOT NULL DEFAULT '1' AFTER `unknown14`;

--
-- Add some kickass emu wonderfull columns:
--

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem1` int(11) unsigned NOT NULL DEFAULT '0' AFTER `Size`;

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem2` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem1`;

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem3` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem2`;

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem4` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem3`;

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem5` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem4`;

ALTER TABLE `gameobject_template` ADD COLUMN `QuestItem6` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem5`;

--
-- The End: rename to kickass way and set/remove keys if needed
--

RENAME TABLE `gameobject_template` TO `gameobject_names`;

ALTER TABLE `gameobject_names` DROP KEY `idx_name`;

--
-- Rename our backup table
--

RENAME TABLE `gameobject_template2` TO `gameobject_template`;

--
-- Since our backup table will lost his keys we should add them again
--

ALTER TABLE `gameobject_template` ADD PRIMARY KEY (`entry`);

ALTER TABLE `gameobject_template` ADD KEY `idx_name` (`name`);