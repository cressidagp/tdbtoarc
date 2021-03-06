/*
==============================================
	TDBtoARC

	Title: Table Remover
	
	TDB: 335.20121
	
	Use this after converting tables.

==============================================
*/
DROP TABLE IF EXISTS `access_requirement`;
DROP TABLE IF EXISTS `achievement_criteria_data`;
DROP TABLE IF EXISTS `achievement_dbc`;
DROP TABLE IF EXISTS `achievement_reward`;
DROP TABLE IF EXISTS `achievement_reward_locale`;
DROP TABLE IF EXISTS `areatrigger_involvedrelation`;
DROP TABLE IF EXISTS `areatrigger_scripts`;
DROP TABLE IF EXISTS `areatrigger_tavern`;
DROP TABLE IF EXISTS `areatrigger_teleport`;
DROP TABLE IF EXISTS `battlefield_template`;
DROP TABLE IF EXISTS `battleground_template`;
DROP TABLE IF EXISTS `battlemaster_entry`;
DROP TABLE IF EXISTS `broadcast_text`;
DROP TABLE IF EXISTS `broadcast_text_locale`;
DROP TABLE IF EXISTS `command`;
DROP TABLE IF EXISTS `conditions`;
DROP TABLE IF EXISTS `creature`;
DROP TABLE IF EXISTS `creature_addon`;
DROP TABLE IF EXISTS `creature_classlevelstats`;
DROP TABLE IF EXISTS `creature_default_trainer`;
DROP TABLE IF EXISTS `creature_equip_template`;

--DROP TABLE IF EXISTS `creature_formations`;
DROP TABLE IF EXISTS `creature_formations2`;

DROP TABLE IF EXISTS `creature_loot_template`;
DROP TABLE IF EXISTS `creature_model_info`;
DROP TABLE IF EXISTS `creature_movement_override`;
DROP TABLE IF EXISTS `creature_onkill_reputation`;
DROP TABLE IF EXISTS `creature_questender`;
DROP TABLE IF EXISTS `creature_questitem`;
DROP TABLE IF EXISTS `creature_queststarter`;
DROP TABLE IF EXISTS `creature_summon_groups`;
DROP TABLE IF EXISTS `creature_template`;
DROP TABLE IF EXISTS `creature_template_addon`;
DROP TABLE IF EXISTS `creature_template_locale`;
DROP TABLE IF EXISTS `creature_template_movement`;
DROP TABLE IF EXISTS `creature_template_resistance`;
DROP TABLE IF EXISTS `creature_template_spell`;
DROP TABLE IF EXISTS `creature_text`;
DROP TABLE IF EXISTS `creature_text_locale`;
DROP TABLE IF EXISTS `creature_waypoints`;
DROP TABLE IF EXISTS `disables`;
DROP TABLE IF EXISTS `disenchant_loot_template`;
DROP TABLE IF EXISTS `event_scripts`;
DROP TABLE IF EXISTS `exploration_basexp`;
DROP TABLE IF EXISTS `fishing_loot_template`;
DROP TABLE IF EXISTS `gameobject`;
DROP TABLE IF EXISTS `gameobject_addon`;
DROP TABLE IF EXISTS `gameobject_loot_template`;
DROP TABLE IF EXISTS `gameobject_overrides`;
DROP TABLE IF EXISTS `gameobject_questender`;
DROP TABLE IF EXISTS `gameobject_questitem`;
DROP TABLE IF EXISTS `gameobject_queststarter`;
DROP TABLE IF EXISTS `gameobject_template`;
DROP TABLE IF EXISTS `gameobject_template_addon`;
DROP TABLE IF EXISTS `gameobject_template_locale`;
DROP TABLE IF EXISTS `game_event`;
DROP TABLE IF EXISTS `game_event_arena_seasons`;
DROP TABLE IF EXISTS `game_event_battleground_holiday`;
DROP TABLE IF EXISTS `game_event_condition`;
DROP TABLE IF EXISTS `game_event_creature`;
DROP TABLE IF EXISTS `game_event_creature_quest`;
DROP TABLE IF EXISTS `game_event_gameobject`;
DROP TABLE IF EXISTS `game_event_gameobject_quest`;
DROP TABLE IF EXISTS `game_event_model_equip`;
DROP TABLE IF EXISTS `game_event_npcflag`;
DROP TABLE IF EXISTS `game_event_npc_vendor`;
DROP TABLE IF EXISTS `game_event_pool`;
DROP TABLE IF EXISTS `game_event_prerequisite`;
DROP TABLE IF EXISTS `game_event_quest_condition`;
DROP TABLE IF EXISTS `game_event_seasonal_questrelation`;
DROP TABLE IF EXISTS `game_tele`;
DROP TABLE IF EXISTS `game_weather`;
DROP TABLE IF EXISTS `gossip_menu`;
DROP TABLE IF EXISTS `gossip_menu_option`;
DROP TABLE IF EXISTS `gossip_menu_option_locale`;
DROP TABLE IF EXISTS `graveyard_zone`;
DROP TABLE IF EXISTS `holiday_dates`;
DROP TABLE IF EXISTS `instance_encounters`;
DROP TABLE IF EXISTS `instance_spawn_groups`;

--DROP TABLE IF EXISTS `instance_template`;

DROP TABLE IF EXISTS `item_enchantment_template`;
DROP TABLE IF EXISTS `item_loot_template`;
DROP TABLE IF EXISTS `item_set_names`;
DROP TABLE IF EXISTS `item_set_names_locale`;
DROP TABLE IF EXISTS `item_template`;
DROP TABLE IF EXISTS `item_template_locale`;
DROP TABLE IF EXISTS `lfg_dungeon_rewards`;
DROP TABLE IF EXISTS `lfg_dungeon_template`;
DROP TABLE IF EXISTS `linked_respawn`;
DROP TABLE IF EXISTS `mail_level_reward`;
DROP TABLE IF EXISTS `mail_loot_template`;
DROP TABLE IF EXISTS `milling_loot_template`;
DROP TABLE IF EXISTS `npc_spellclick_spells`;

--DROP TABLE IF EXISTS `npc_text`;
DROP TABLE IF EXISTS `npc_text2`;

DROP TABLE IF EXISTS `npc_text_locale`;
DROP TABLE IF EXISTS `npc_vendor`;
DROP TABLE IF EXISTS `outdoorpvp_template`;
DROP TABLE IF EXISTS `page_text`;
DROP TABLE IF EXISTS `page_text_locale`;
DROP TABLE IF EXISTS `pet_levelstats`;
DROP TABLE IF EXISTS `pet_name_generation`;
DROP TABLE IF EXISTS `pickpocketing_loot_template`;
DROP TABLE IF EXISTS `playercreateinfo`;
DROP TABLE IF EXISTS `playercreateinfo_action`;
DROP TABLE IF EXISTS `playercreateinfo_cast_spell`;
DROP TABLE IF EXISTS `playercreateinfo_item`;
DROP TABLE IF EXISTS `playercreateinfo_skills`;
DROP TABLE IF EXISTS `playercreateinfo_spell_custom`;
DROP TABLE IF EXISTS `player_classlevelstats`;
DROP TABLE IF EXISTS `player_factionchange_achievement`;
DROP TABLE IF EXISTS `player_factionchange_items`;
DROP TABLE IF EXISTS `player_factionchange_quests`;
DROP TABLE IF EXISTS `player_factionchange_reputations`;
DROP TABLE IF EXISTS `player_factionchange_spells`;
DROP TABLE IF EXISTS `player_factionchange_titles`;
DROP TABLE IF EXISTS `player_levelstats`;
DROP TABLE IF EXISTS `player_totem_model`;
DROP TABLE IF EXISTS `player_xp_for_level`;
DROP TABLE IF EXISTS `points_of_interest`;
DROP TABLE IF EXISTS `points_of_interest_locale`;
DROP TABLE IF EXISTS `pool_members`;
DROP TABLE IF EXISTS `pool_template`;
DROP TABLE IF EXISTS `prospecting_loot_template`;
DROP TABLE IF EXISTS `quest_details`;
DROP TABLE IF EXISTS `quest_greeting`;
DROP TABLE IF EXISTS `quest_greeting_locale`;
DROP TABLE IF EXISTS `quest_mail_sender`;
DROP TABLE IF EXISTS `quest_offer_reward`;
DROP TABLE IF EXISTS `quest_offer_reward_locale`;

--DROP TABLE IF EXISTS `quest_poi`;
DROP TABLE IF EXISTS `quest_poi2`;

--DROP TABLE IF EXISTS `quest_poi_points`;
DROP TABLE IF EXISTS `quest_poi_points`;

DROP TABLE IF EXISTS `quest_pool_members`;
DROP TABLE IF EXISTS `quest_pool_template`;
DROP TABLE IF EXISTS `quest_request_items`;
DROP TABLE IF EXISTS `quest_request_items_locale`;
DROP TABLE IF EXISTS `quest_template`;
DROP TABLE IF EXISTS `quest_template_addon`;
DROP TABLE IF EXISTS `quest_template_locale`;
DROP TABLE IF EXISTS `reference_loot_template`;
DROP TABLE IF EXISTS `reputation_reward_rate`;
DROP TABLE IF EXISTS `reputation_spillover_template`;
DROP TABLE IF EXISTS `script_spline_chain_meta`;
DROP TABLE IF EXISTS `script_spline_chain_waypoints`;
DROP TABLE IF EXISTS `script_waypoint`;
DROP TABLE IF EXISTS `skill_discovery_template`;
DROP TABLE IF EXISTS `skill_extra_item_template`;
DROP TABLE IF EXISTS `skill_fishing_base_level`;
DROP TABLE IF EXISTS `skill_perfect_item_template`;
DROP TABLE IF EXISTS `skinning_loot_template`;
DROP TABLE IF EXISTS `smart_scripts`;
DROP TABLE IF EXISTS `spawn_group`;
DROP TABLE IF EXISTS `spawn_group_template`;
DROP TABLE IF EXISTS `spelldifficulty_dbc`;
DROP TABLE IF EXISTS `spell_area`;
DROP TABLE IF EXISTS `spell_bonus_data`;
DROP TABLE IF EXISTS `spell_custom_attr`;
DROP TABLE IF EXISTS `spell_dbc`;
DROP TABLE IF EXISTS `spell_enchant_proc_data`;
DROP TABLE IF EXISTS `spell_group`;
DROP TABLE IF EXISTS `spell_group_stack_rules`;
DROP TABLE IF EXISTS `spell_learn_spell`;
DROP TABLE IF EXISTS `spell_linked_spell`;
DROP TABLE IF EXISTS `spell_loot_template`;
DROP TABLE IF EXISTS `spell_pet_auras`;
DROP TABLE IF EXISTS `spell_proc`;
DROP TABLE IF EXISTS `spell_ranks`;
DROP TABLE IF EXISTS `spell_required`;
DROP TABLE IF EXISTS `spell_scripts`;
DROP TABLE IF EXISTS `spell_script_names`;
DROP TABLE IF EXISTS `spell_target_position`;
DROP TABLE IF EXISTS `spell_required`;
DROP TABLE IF EXISTS `spell_required`;
DROP TABLE IF EXISTS `spell_threat`;
DROP TABLE IF EXISTS `trainer`;
DROP TABLE IF EXISTS `trainer_locale`;
DROP TABLE IF EXISTS `trainer_spell`;
DROP TABLE IF EXISTS `transports`;
DROP TABLE IF EXISTS `trinity_string`;
DROP TABLE IF EXISTS `updates`;
DROP TABLE IF EXISTS `updates_include`;
DROP TABLE IF EXISTS `vehicle_accessory`;
DROP TABLE IF EXISTS `vehicle_seat_addon`;
DROP TABLE IF EXISTS `vehicle_template_accessory`;

--DROP TABLE IF EXISTS `version`;

DROP TABLE IF EXISTS `warden_checks`;
DROP TABLE IF EXISTS `waypoints`;
DROP TABLE IF EXISTS `waypoint_data`;
DROP TABLE IF EXISTS `waypoint_scripts`;