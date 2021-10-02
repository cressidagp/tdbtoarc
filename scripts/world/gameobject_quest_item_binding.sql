/*
=================================================

	TDBtoARC
	
	Title: gameobject_questitem to gameobject_quest_item_binding
	
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

DROP TABLE IF EXISTS `gameobject_quest_item_binding`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `gameobject_questitem2` SELECT * FROM `gameobject_questitem`;

--
--
-- Drop not supported column(s)
--
--

/* #4 */
ALTER TABLE `gameobject_questitem` DROP COLUMN `VerifiedBuild`;

--
--
-- Here we go...
--
--

ALTER TABLE `gameobject_questitem` 

	CHANGE COLUMN `GameObjectEntry` `entry` int(11) NOT NULL DEFAULT '0',

	/* Idx: leave it be for now. */

	ADD COLUMN `quest` int(11) NOT NULL DEFAULT '0' AFTER `Idx`,

	CHANGE COLUMN `ItemId` `item` int(11) NOT NULL DEFAULT '0',

	ADD COLUMN `item_count` int(11) NOT NULL DEFAULT '0' AFTER `item`,

	DROP PRIMARY KEY;

/* quest: */

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount1
WHERE (gameobject_questitem.item = quest_template.RequiredItemId1);

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount2
WHERE (gameobject_questitem.item = quest_template.RequiredItemId2);

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount3
WHERE (gameobject_questitem.item = quest_template.RequiredItemId3);

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount4
WHERE (gameobject_questitem.item = quest_template.RequiredItemId4);

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount5
WHERE (gameobject_questitem.item = quest_template.RequiredItemId5);

UPDATE gameobject_questitem, quest_template
SET gameobject_questitem.quest = quest_template.ID, gameobject_questitem.item_count = quest_template.RequiredItemCount6
WHERE (gameobject_questitem.item = quest_template.RequiredItemId6);

/* Delete repeated */

DELETE FROM `gameobject_questitem` WHERE ( `entry` = 126049 and `Idx` != 0 and `item` = 8047 );

DELETE FROM `gameobject_questitem` WHERE ( `entry` = 128293 and `Idx` != 0 and `item` = 8047 );

--
--
-- Rename to kickass way and set/remove key(s) if needed
--
--

RENAME TABLE `gameobject_questitem` TO `gameobject_quest_item_binding`;

ALTER TABLE `gameobject_quest_item_binding`

	DROP COLUMN `Idx`,

	ADD PRIMARY KEY (`entry`, `item`, `quest`);

--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `gameobject_questitem2` TO `gameobject_questitem`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `gameobject_questitem` ADD PRIMARY KEY (`GameObjectEntry`, `Idx`);