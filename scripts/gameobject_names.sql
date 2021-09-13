/*
=================================================

	TDBtoARC
	
	Title: gameobject_template to gameobject_names
	
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

DROP TABLE IF EXISTS `gameobject_names`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gameobject_template2` SELECT * FROM `gameobject_template`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `gameobject_template`

	/* #33 */
	DROP COLUMN `AIName`,

	/* #34 */
	DROP COLUMN `ScriptName`,

	/* #35 */
	DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

-- UPDATE `gameobject_template` SET `Data1` = 0 WHERE `Data1` = -1;
-- ALTER TABLE `gameobject_template` CHANGE COLUMN `Data1` `sound1` int(10) unsigned NOT NULL DEFAULT '0';
-- UPDATE `gameobject_template` SET `Data6` = 0 WHERE `Data6` = -1;
-- UPDATE `gameobject_template` SET `Data6` = 0 WHERE `Data6` = -1000;
-- ALTER TABLE `gameobject_template` CHANGE COLUMN `Data6` `sound6` int(10) unsigned NOT NULL DEFAULT '0';
-- ALTER TABLE `gameobject_template` CHANGE COLUMN `Data7` `sound7` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `gameobject_template` 
	
	CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `type` `Type` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `displayId` `DisplayID` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `name` `Name` varchar(100) CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL,

	CHANGE COLUMN `IconName` `Category` varchar(100) NOT NULL,

	CHANGE COLUMN `castBarCaption` `CastBarText` varchar(100) NOT NULL,

	CHANGE COLUMN `unk1` `UnkStr` varchar(100) NOT NULL,

	/* size: will return to this later (A) */

	CHANGE COLUMN `Data0` `spellfocus` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data1` `sound1` int(10) NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data2` `sound2` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data3` `sound3` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data4` `sound4` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data5` `sound5` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data6` `sound6` int(10) NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data7` `sound7` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data8` `sound8` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data9` `sound9` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data10` `unknown1` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data11` `unknown2` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data12` `unknown3` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data13` `unknown4` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data14` `unknown5` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data15` `unknown6` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data16` `unknown7` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data17` `unknown8` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data18` `unknown9` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data19` `unknown10` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data20` `unknown11` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data21` `unknown12` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data22` `unknown13` int(10) unsigned NOT NULL DEFAULT '0',

	CHANGE COLUMN `Data23` `unknown14` int(10) unsigned NOT NULL DEFAULT '0',

	/* (A): Size */

	CHANGE COLUMN `size` `Size` float NOT NULL DEFAULT '1' AFTER `unknown14`,

	ADD COLUMN `QuestItem1` int(11) unsigned NOT NULL DEFAULT '0' AFTER `Size`,

	ADD COLUMN `QuestItem2` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem1`,

	ADD COLUMN `QuestItem3` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem2`,

	ADD COLUMN `QuestItem4` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem3`,

	ADD COLUMN `QuestItem5` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem4`,

	ADD COLUMN `QuestItem6` int(11) unsigned NOT NULL DEFAULT '0' AFTER `QuestItem5`;
	
/* QuestItem1-6 */

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem1 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 0);

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem2 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 1);

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem3 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 2);

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem4 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 3);

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem5 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 4);

UPDATE `gameobject_template`, `gameobject_questitem`
SET gameobject_template.QuestItem6 = gameobject_questitem.ItemId
WHERE (gameobject_template.entry = gameobject_questitem.GameObjectEntry and Idx = 5);

--
--
-- Rename to kickass way and set/remove key(s) if needed
--
--

RENAME TABLE `gameobject_template` TO `gameobject_names`;

ALTER TABLE `gameobject_names` DROP KEY `idx_name`;

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject_template2` TO `gameobject_template`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gameobject_template` 

	ADD PRIMARY KEY (`entry`),

	ADD KEY `idx_name` (`name`);