/*
=================================================

	TDBtoARC
	
	Title: npc_text to npc_text
	
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

DROP TABLE IF EXISTS `npc_text2`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `npc_text2` SELECT * FROM `npc_text`;

--
--
-- Drop not supported column(s)
--
--

/* #90 */
ALTER TABLE `npc_text` DROP COLUMN `VerifiedBuild`;

--
--
-- Remove Data truncated
--
--

UPDATE `npc_text` SET `text0_0` = '' WHERE `text0_0` IS NULL;

UPDATE `npc_text` SET `text0_1` = '' WHERE `text0_1` IS NULL;

UPDATE `npc_text` SET `text1_0` = '' WHERE `text1_0` IS NULL;

UPDATE `npc_text` SET `text1_1` = '' WHERE `text1_1` IS NULL;

UPDATE `npc_text` SET `text2_0` = '' WHERE `text2_0` IS NULL;

UPDATE `npc_text` SET `text2_1` = '' WHERE `text2_1` IS NULL;

UPDATE `npc_text` SET `text3_0` = '' WHERE `text3_0` IS NULL;

UPDATE `npc_text` SET `text3_1` = '' WHERE `text3_1` IS NULL;

UPDATE `npc_text` SET `text4_0` = '' WHERE `text4_0` IS NULL;

UPDATE `npc_text` SET `text4_1` = '' WHERE `text4_1` IS NULL;

UPDATE `npc_text` SET `text5_0` = '' WHERE `text5_0` IS NULL;

UPDATE `npc_text` SET `text5_1` = '' WHERE `text5_1` IS NULL;

UPDATE `npc_text` SET `text6_0` = '' WHERE `text6_0` IS NULL;

UPDATE `npc_text` SET `text6_1` = '' WHERE `text6_1` IS NULL;

UPDATE `npc_text` SET `text7_0` = '' WHERE `text7_0` IS NULL;

UPDATE `npc_text` SET `text7_1` = '' WHERE `text7_1` IS NULL;

--
--
-- Here we go...
--
--

ALTER TABLE `npc_text` CHANGE COLUMN `ID` `entry` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `Probability0` `prob0` float NOT NULL DEFAULT '0' AFTER `entry`;

ALTER TABLE `npc_text` CHANGE COLUMN `text0_0` `text0_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob0`;

ALTER TABLE `npc_text` CHANGE COLUMN `text0_1` `text0_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text0_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID0`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang0` `lang0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text0_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_0` `EmoteDelay0_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang0`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_0` `temp_Emote0_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay0_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_1` `temp_EmoteDelay0_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote0_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_1` `temp_Emote0_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay0_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay0_2` `temp_EmoteDelay0_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote0_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote0_2` `temp_Emote0_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay0_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability1` `prob1` float NOT NULL DEFAULT '0' AFTER `temp_Emote0_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text1_0` `text1_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob1`;

ALTER TABLE `npc_text` CHANGE COLUMN `text1_1` `text1_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text1_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID1`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang1` `lang1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text1_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay1_0` `EmoteDelay1_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote1_0` `temp_Emote1_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay1_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay1_1` `temp_EmoteDelay1_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote1_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote1_1` `temp_Emote1_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay1_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay1_2` `temp_EmoteDelay1_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote1_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote1_2` `temp_Emote1_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay1_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability2` `prob2` float NOT NULL DEFAULT '0' AFTER `temp_Emote1_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text2_0` `text2_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob2`;

ALTER TABLE `npc_text` CHANGE COLUMN `text2_1` `text2_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text2_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID2`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang2` `lang2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text2_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay2_0` `EmoteDelay2_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang2`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote2_0` `temp_Emote2_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay2_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay2_1` `temp_EmoteDelay2_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote2_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote2_1` `temp_Emote2_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay2_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay2_2` `temp_EmoteDelay2_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote2_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote2_2` `temp_Emote2_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay2_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability3` `prob3` float NOT NULL DEFAULT '0' AFTER `temp_Emote2_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text3_0` `text3_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob3`;

ALTER TABLE `npc_text` CHANGE COLUMN `text3_1` `text3_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text3_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID3`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang3` `lang3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text3_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay3_0` `EmoteDelay3_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote3_0` `temp_Emote3_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay3_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay3_1` `temp_EmoteDelay3_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote3_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote3_1` `temp_Emote3_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay3_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay3_2` `temp_EmoteDelay3_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote3_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote3_2` `temp_Emote3_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay3_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability4` `prob4` float NOT NULL DEFAULT '0' AFTER `temp_Emote3_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text4_0` `text4_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob4`;

ALTER TABLE `npc_text` CHANGE COLUMN `text4_1` `text4_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text4_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID4`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang4` `lang4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text4_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay4_0` `EmoteDelay4_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang4`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote4_0` `temp_Emote4_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay4_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay4_1` `temp_EmoteDelay4_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote4_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote4_1` `temp_Emote4_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay4_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay4_2` `temp_EmoteDelay4_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote4_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote4_2` `temp_Emote4_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay4_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability5` `prob5` float NOT NULL DEFAULT '0' AFTER `temp_Emote4_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text5_0` `text5_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text5_1` `text5_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text5_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID5`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang5` `lang5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text5_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay5_0` `EmoteDelay5_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang5`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote5_0` `temp_Emote5_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay5_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay5_1` `temp_EmoteDelay5_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote5_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote5_1` `temp_Emote5_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay5_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay5_2` `temp_EmoteDelay5_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote5_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote5_2` `temp_Emote5_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay5_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability6` `prob6` float NOT NULL DEFAULT '0' AFTER `temp_Emote5_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text6_0` `text6_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob6`;

ALTER TABLE `npc_text` CHANGE COLUMN `text6_1` `text6_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text6_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID6`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang6` `lang6` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text6_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay6_0` `EmoteDelay6_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang6`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote6_0` `temp_Emote6_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay6_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay6_1` `temp_EmoteDelay6_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote6_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote6_1` `temp_Emote6_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay6_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay6_2` `temp_EmoteDelay6_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote6_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote6_2` `temp_Emote6_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay6_4`;


ALTER TABLE `npc_text` CHANGE COLUMN `Probability7` `prob7` float NOT NULL DEFAULT '0' AFTER `temp_Emote6_5`;

ALTER TABLE `npc_text` CHANGE COLUMN `text7_0` `text7_0` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `prob7`;

ALTER TABLE `npc_text` CHANGE COLUMN `text7_1` `text7_1` longtext CHARACTER SET utf8 COLLATE utf8_unicode_ci NOT NULL AFTER `text7_0`;

ALTER TABLE `npc_text` DROP COLUMN `BroadcastTextID7`;

ALTER TABLE `npc_text` CHANGE COLUMN `lang7` `lang7` int(10) unsigned NOT NULL DEFAULT '0' AFTER `text7_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay7_0` `EmoteDelay7_0` int(10) unsigned NOT NULL DEFAULT '0' AFTER `lang7`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote7_0` `temp_Emote7_1` int(10) unsigned NOT NULL DEFAULT '0' AFTER `EmoteDelay7_0`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay7_1` `temp_EmoteDelay7_2` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote7_1`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote7_1` `temp_Emote7_3` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay7_2`;

ALTER TABLE `npc_text` CHANGE COLUMN `EmoteDelay7_2` `temp_EmoteDelay7_4` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_Emote7_3`;

ALTER TABLE `npc_text` CHANGE COLUMN `Emote7_2` `temp_Emote7_5` int(10) unsigned NOT NULL DEFAULT '0' AFTER `temp_EmoteDelay7_4`;

--
-- Rename all temporary column(s)
--

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_1` `Emote0_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay0_2` `EmoteDelay0_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_3` `Emote0_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay0_4` `EmoteDelay0_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote0_5` `Emote0_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote1_1` `Emote1_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay1_2` `EmoteDelay1_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote1_3` `Emote1_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay1_4` `EmoteDelay1_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote1_5` `Emote1_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote2_1` `Emote2_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay2_2` `EmoteDelay2_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote2_3` `Emote2_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay2_4` `EmoteDelay2_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote2_5` `Emote2_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote3_1` `Emote3_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay3_2` `EmoteDelay3_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote3_3` `Emote3_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay3_4` `EmoteDelay3_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote3_5` `Emote3_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote4_1` `Emote4_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay4_2` `EmoteDelay4_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote4_3` `Emote4_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay4_4` `EmoteDelay4_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote4_5` `Emote4_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote5_1` `Emote5_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay5_2` `EmoteDelay5_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote5_3` `Emote5_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay5_4` `EmoteDelay5_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote5_5` `Emote5_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote6_1` `Emote6_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay6_2` `EmoteDelay6_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote6_3` `Emote6_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay6_4` `EmoteDelay6_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote6_5` `Emote6_5` int(10) unsigned NOT NULL DEFAULT '0';


ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote7_1` `Emote7_1` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay7_2` `EmoteDelay7_2` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote7_3` `Emote7_3` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_EmoteDelay7_4` `EmoteDelay7_4` int(10) unsigned NOT NULL DEFAULT '0';

ALTER TABLE `npc_text` CHANGE COLUMN `temp_Emote7_5` `Emote7_5` int(10) unsigned NOT NULL DEFAULT '0';

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `npc_text2` ADD PRIMARY KEY (`ID`);