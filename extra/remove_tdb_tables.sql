/*
=================================================

	TDBtoARC

	Title: Table Remover
	
	TDB: 335.21081
	
	Use this after converting tables.

=================================================
*/

DROP TABLE IF EXISTS

`access_requirement`, `achievement_criteria_data`, `achievement_dbc`, `achievement_reward`, `achievement_reward_locale`, 

`areatrigger_teleport`, `battlefield_template`, `battlemaster_entry`, `broadcast_text`, `broadcast_text_locale`, `command`, `conditions`, `creature`, `creature_addon`, `creature_classlevelstats`,

`creature_default_trainer`, `creature_equip_template`, `creature_loot_template`, `creature_movement_override`, `creature_onkill_reputation`, `creature_questender`,

`creature_questitem`, `creature_queststarter`, `creature_summon_groups`, `creature_template`, `creature_template_addon`, `creature_template_locale`, `creature_template_movement`,

`creature_template_resistance`, `creature_template_spell`, `creature_text`, `creature_text_locale`, `creature_waypoints`, `disables`, `disenchant_loot_template`, `event_scripts`,

`exploration_basexp`, `fishing_loot_template`, `gameobject`, `gameobject_addon`, `gameobject_loot_template`, `gameobject_overrides`, `gameobject_questender`, `gameobject_questitem`,

`gameobject_queststarter`, `gameobject_template`, `gameobject_template_addon`, `gameobject_template_locale`, `game_event_arena_seasons`, `game_event_battleground_holiday`,

`game_event_condition`, `game_event_creature`, `game_event_creature_quest`, `game_event_gameobject`, `game_event_gameobject_quest`, `game_event_model_equip`, `game_event_npcflag`,

`game_event_npc_vendor`, `game_event_pool`, `game_event_prerequisite`, `game_event_quest_condition`, `game_event_seasonal_questrelation`, `game_tele`, `game_weather`, `gossip_menu`,

`gossip_menu_option`, `gossip_menu_option_locale`, `graveyard_zone`, `holiday_dates`, `instance_encounters`, `instance_spawn_groups`, `item_enchantment_template`, `item_loot_template`,

`item_set_names`, `item_set_names_locale`, `item_template`, `item_template_locale`, `lfg_dungeon_rewards`, `lfg_dungeon_template`, `linked_respawn`, `mail_level_reward`, `mail_loot_template`,

`milling_loot_template`, `npc_spellclick_spells`, `npc_text_locale`, `npc_vendor`, `outdoorpvp_template`, `page_text`, `page_text_locale`, `pet_levelstats`, `pet_name_generation`,

`pickpocketing_loot_template`, `playercreateinfo`, `playercreateinfo_action`, `playercreateinfo_cast_spell`, `playercreateinfo_item`, `playercreateinfo_skills`, `playercreateinfo_spell_custom`,

`player_classlevelstats`, `player_factionchange_achievement`, `player_factionchange_items`, `player_factionchange_quests`, `player_factionchange_reputations`, `player_factionchange_spells`,

`player_factionchange_titles`, `player_levelstats`, `player_totem_model`, `player_xp_for_level`, `points_of_interest`, `points_of_interest_locale`, `pool_members`, `pool_template`,

`prospecting_loot_template`, `quest_details`, `quest_greeting`, `quest_greeting_locale`, `quest_mail_sender`, `quest_offer_reward`, `quest_offer_reward_locale`, `quest_pool_members`,

`quest_pool_template`, `quest_request_items`, `quest_request_items_locale`, `quest_template`, `quest_template_addon`, `quest_template_locale`, `reference_loot_template`, `reputation_reward_rate`,

`reputation_spillover_template`, `script_spline_chain_meta`, `script_spline_chain_waypoints`, `script_waypoint`, `skill_discovery_template`, `skill_extra_item_template`, `skill_fishing_base_level`,

`skill_perfect_item_template`, `skinning_loot_template`, `smart_scripts`, `spawn_group`, `spawn_group_template`, `spelldifficulty_dbc`, `spell_area`, `spell_bonus_data`, `spell_custom_attr`,

`spell_dbc`, `spell_enchant_proc_data`, `spell_group`, `spell_group_stack_rules`, `spell_learn_spell`, `spell_linked_spell`, `spell_loot_template`, `spell_pet_auras`, `spell_proc`, `spell_ranks`,

`spell_scripts`, `spell_script_names`, `spell_target_position`, `spell_required`, `spell_threat`, `trainer`, `trainer_locale`, `trainer_spell`, `transports`, `trinity_string`, `updates`,

`updates_include`, `vehicle_accessory`, `vehicle_seat_addon`, `vehicle_template`, `vehicle_template_accessory`, `warden_checks`, `waypoints`, `waypoint_data`, `waypoint_scripts`;

/* Lets keep this as a source of information.

DROP TABLE IF EXISTS `areatrigger_involvedrelation`;
DROP TABLE IF EXISTS `areatrigger_tavern`;
DROP TABLE IF EXISTS `areatrigger_scripts`;
DROP TABLE IF EXISTS `battleground_template`;
DROP TABLE IF EXISTS `game_event`;
DROP TABLE IF EXISTS `instance_template`;

*/

/* Since arcemu and trinity share this table name, our backup table will keep tableName2 */
DROP TABLE IF EXISTS `creature_formations2`, `npc_text2`, `quest_poi2`, `quest_poi_points2`;

/* Dont drop it before hotfix.

DROP TABLE IF EXISTS `creature_model_info`

*/

/*	Keep this one as credits for TrinityCore developers.

	https://www.trinitycore.org/

	https://github.com/TrinityCore/TrinityCore

DROP TABLE IF EXISTS `version`; 

*/