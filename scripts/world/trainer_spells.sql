/*
=================================================

	TDBtoARC

	Title: trainer_spell to trainer_spells
	
	From TDB: 335.21081
	
	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql
	
	learn_spell: its the spell listed
	cast_spell: extra spell learned when learn the spell listed

=================================================
*/

--
--
-- Cleanup database
--
--

DROP TABLE IF EXISTS `trainer_spells`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `trainer_spell2` SELECT * FROM `trainer_spell`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `trainer_spell`

	/* #6 */
	DROP COLUMN `ReqAbility2`,
	
	/* #7 */
	DROP COLUMN `ReqAbility3`,

	/* #10 */
	DROP COLUMN `VerifiedBuild`;
		
--
--
-- Here we go...
--
--

ALTER TABLE `trainer_spell`

	ADD COLUMN `entry` int(11) unsigned NOT NULL DEFAULT '0' AFTER `TrainerId`,
	
	ADD COLUMN `cast_spell` int(11) unsigned NOT NULL DEFAULT '0' AFTER `entry`,
	
	CHANGE COLUMN `SpellId` `learn_spell` int(11) unsigned NOT NULL AFTER `cast_spell`,
	
	CHANGE COLUMN `MoneyCost` `spellcost` int(11) unsigned NOT NULL DEFAULT '0' AFTER `learn_spell`,
	
	CHANGE COLUMN `ReqAbility1` `reqspell` int(11) unsigned NOT NULL DEFAULT '0' AFTER `spellcost`,
	
	CHANGE COLUMN `ReqSkillLine` `reqskill` int(11) unsigned NOT NULL DEFAULT '0' AFTER `reqspell`,
	
	CHANGE COLUMN `ReqSkillRank` `reqskillvalue` int(11) unsigned NOT NULL DEFAULT '0' AFTER `reqskill`,
	
	CHANGE COLUMN `ReqLevel` `reqlevel` int(11) unsigned NOT NULL DEFAULT '0' AFTER `reqskillvalue`,
	
	ADD COLUMN `deletespell` int(11) unsigned NOT NULL DEFAULT '0' AFTER `reqlevel`;
	
/* cast_spell: */
UPDATE trainer_spell, spell_learn_spell
SET trainer_spell.cast_spell = spell_learn_spell.SpellID
WHERE trainer_spell.learn_spell = spell_learn_spell.entry;

/* deletespell: */
UPDATE trainer_spell, spell_required
SET trainer_spell.deletespell = spell_required.req_spell
WHERE trainer_spell.learn_spell = spell_required.spell_id;


DROP TABLE IF EXISTS `trainer_spell_temp`;
CREATE TABLE `trainer_spell_temp` SELECT * FROM `trainer_spell`;

--
-- 1 full warrior
--

INSERT INTO `trainer_spell` 
SELECT 1, 913, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 914, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 985, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 1229, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 1403, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 1901, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 2131, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3041, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3042, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3043, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3063, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3169, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3353, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3354, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3408, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 3598, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4087, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4089, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4593, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4594, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4595, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 4992, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5113, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5114, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5479, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5480, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5959, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5966, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 5967, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 7315, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 8141, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 10291, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 16771, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 17120, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 17480, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

INSERT INTO `trainer_spell` 
SELECT 1, 17504, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 1;

--
-- 2 starting zone warrior
--

INSERT INTO `trainer_spell` 
SELECT 2, 911, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 912, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 2119, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 3059, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 3153, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 3593, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

INSERT INTO `trainer_spell` 
SELECT 2, 16503, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 2;

--
-- 3 full paladin
--

--
-- starting zone paladin
--

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

INSERT INTO `trainer_spell` 
SELECT 4, , `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 4;

--
-- 16 full mage
--

INSERT INTO `trainer_spell` 
SELECT 16, 328, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 1128, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 2128, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 3047, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 3048, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 3049, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 4566, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 4567, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 4568, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5144, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5145, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5146, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5497, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5498, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5882, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5883, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5884, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5885, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 7311, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 7312, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 16269, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 16651, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 16652, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 16653, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 16749, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 17105, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 17481, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 17513, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 17514, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 4987, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5961, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 5969, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 7488, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 23103, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 27704, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 28956, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

INSERT INTO `trainer_spell` 
SELECT 16, 28958, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 16;

--
-- starting zone mage
--

INSERT INTO `trainer_spell` 
SELECT 17, 198, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

INSERT INTO `trainer_spell` 
SELECT 17, 944, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

INSERT INTO `trainer_spell` 
SELECT 17, 2124, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

INSERT INTO `trainer_spell` 
SELECT 17, 5880, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

INSERT INTO `trainer_spell` 
SELECT 17, 15279, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

INSERT INTO `trainer_spell` 
SELECT 17, 16500, `cast_spell`, `learn_spell`, `spellcost`, `reqspell`, `reqskill`, `reqskillvalue`, `reqlevel`, `deletespell`
FROM `trainer_spell_temp` 
WHERE `TrainerId` = 17;

--
--
-- Remove pillaged table(s)
--
--

DROP TABLE IF EXISTS `trainer_spell_temp`;

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `trainer_spell` TO `trainer_spells`;

ALTER TABLE `trainer_spells` ADD PRIMARY KEY (`entry`,`cast_spell`);
