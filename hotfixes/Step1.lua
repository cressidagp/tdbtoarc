--[[

	TDBtoARC
	
	From TDB: 335.21081_2021_08_15

	to
	
	Arc: 2012-08-04_21-25_worldmap_info.sql

--]]

local displayid = WorldDBQuery( "SELECT `displayid` FROM `creature_spawns` WHERE `id` = '14'" ):GetColumn( 0 ):GetUShort();

TDBTOARC = {};

math.randomseed(os.time()); math.random(); math.random(); math.random();

if( displayid == 0 ) 
then
	print("=====================================");
	print("= TDBtoARC: appliyng hot fix step 1 =");
	print("=====================================");
	
	WorldDBQuery( "ALTER TABLE `creature_spawns` CHANGE COLUMN `displayid` `displayid` int(30) NOT NULL DEFAULT '0' " );
	
	local result = WorldDBQuery( "SELECT `id`, `displayid` FROM `creature_spawns`" );
	
	if( result ~= nil )
	then
		repeat
			local spid = result:GetColumn( 0 ):GetULong();
			local disp = result:GetColumn( 1 ):GetUShort();
			
			if( disp == 0 )
			then
				local ran = math.random( -4, -1 );
				WorldDBQuery( "UPDATE `creature_spawns` SET `displayid` = '"..ran.."' WHERE `id` = '"..spid.."' " );
			end
			
		until result:NextRow() ~= true;
		
		print("===========================================");
		print("= TDBtoARC: now shutdown and apply step 2 =");
		print("===========================================");
	end	
end

-- 1: chat #arc1 to unlock 
-- 2: chat #arc2 to add values
-- 3: then shutdown arcemu

--[[
function TDBTOARC.OnChatCommand( event, plr, message )

	if( plr:IsGm() and message == "#arc1" )
	then
		WorldDBQuery( "ALTER TABLE `creature_spawns` CHANGE COLUMN `displayid` `displayid` int(30) NOT NULL DEFAULT '0' " );
		plr:SendBroadcastMessage( "Column unlocked!" );

	elseif( plr:IsGm() and message == "#arc2" )
	then
		plr:SendBroadcastMessage( "Lets start!" );
		
		local result = WorldDBQuery( "SELECT `id`, `displayid` FROM `creature_spawns`" );
		if( result ~= nil )
		then
			repeat
			
				local spid = result:GetColumn( 0 ):GetULong();
				local disp = result:GetColumn( 1 ):GetUShort();
				
				if( disp == 0 )
				then
					local ran = math.random( -4, -1 );
					
					WorldDBQuery( "UPDATE `creature_spawns` SET `displayid` = '"..ran.."' WHERE `id` = '"..spid.."' " );
					
					plr:SendBroadcastMessage(""..spid.."");
				end

			until result:NextRow() ~= true;
			
			plr:SendBroadcastMessage( "Done!" );
		end
	end
end

RegisterServerHook( 16, TDBTOARC.OnChatCommand );

--]]