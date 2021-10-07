/*
=================================================

	TDBtoARC

	Title: npc_vendor to vendors
	
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

DROP TABLE IF EXISTS `vendors`;

--
--
-- Create a backup of original table(s)
--
--

CREATE TABLE `npc_vendor2` SELECT * FROM `npc_vendor`;

--
--
-- Drop not supported column(s)
--
--

ALTER TABLE `npc_vendor`

	/* #2 */
	DROP COLUMN `slot`,

	/* #7 */
	DROP COLUMN `VerifiedBuild`;
		
--
--
-- Here we go...
--
--

DELETE FROM `npc_vendor` WHERE `item` < 0;

ALTER TABLE `npc_vendor`

	CHANGE COLUMN `entry` `entry` int(10) unsigned NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `item` `item` int(10) unsigned NOT NULL DEFAULT '0',
	
	ADD COLUMN `amount` int(11) NOT NULL DEFAULT '0' AFTER `item`,
	
	CHANGE COLUMN `maxcount` `max_amount` int(11) NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `incrtime` `inctime` bigint(20) NOT NULL DEFAULT '0',
	
	CHANGE COLUMN `ExtendedCost` `extended_cost` int(11) NOT NULL DEFAULT '0';

--
--
-- Rename to ArcEmu way and set/remove key(s) if needed
--
--

RENAME TABLE `npc_vendor` TO `vendors`;

ALTER TABLE `vendors`

	DROP PRIMARY KEY,
	
	ADD PRIMARY KEY (`entry`,`item`,`extended_cost`);


--
--
-- Rename our backup table(s)
--
--

RENAME TABLE `npc_vendor2` TO `npc_vendor`;

--
--
-- Since our backup table(s) will lost his key(s) we should add them again
--
--

ALTER TABLE `npc_vendor`

	ADD PRIMARY KEY (`entry`,`item`,`ExtendedCost`),

	ADD KEY `slot` (`slot`);