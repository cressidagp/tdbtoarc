--
-- Hotfixes
--

1: Step1.lua

There are 3 ways of applying this.

	A) Copy the file to arcemu scripts folder before running world (it may crash world).
	
	B) Run world, the copy file and use reloadscripts command from console (less chances of crash).
	
	C) Copy file and comment out this line: -- local displayid = WorldDBQuery( "SELECT `displayid` FROM `creature_spawns` WHERE `id` = '14'" ):GetColumn( 0 ):GetUShort();

		then run world and log in client. Use this commands in order: #arc1, #arc2 and shutdown arcemu (safe way).



2: Step2.sql apply with SQLyog, HeidiSQL or Navicat.