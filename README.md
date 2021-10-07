# TDBtoArc

## Introduction

TDBtoArc its a NON-OFFICIAL database conversion project for ArcEmu just for learning purposes. It will partially convert [TrinityCore](https://github.com/TrinityCore) world database 335.21081 to [ArcEmu structure.](https://github.com/arcemu/arcemu/blob/master/sql/world_structure.sql)

Feel free to [open tickets to report bugs.](https://github.com/cressidagp/tdbtoarc/issues/new) Constructive feedback its apreciated.


## Features

Scripts to obtain the following tables populated: 

* *ai_threattospellid, auctionhouse*

* *battlemasters*

* *creature_formations, creature_names, creature_names_localized, creature_proto, creature_quest_finisher, creature_quest_starter, creature_spawns, creature_waypoints*

* *fishing*

* *gameobject_names, gameobject_names_localized, gameobject_quest_finisher, gameobject_quest_item_binding, gameobject_quest_starter, gameobject_spawns*

* *itemnames, itempages, itempages_localized, itempetfood, items, items_localized, instance_bosses*

* *npc_gossip_textid, npc_monstersay, npc_text, npc_text_localized*

* *playercreateinfo_bars, professiondiscoveries*

* *quest_poi, quest_poi_points, quests, quests_localized*

* *recall*

* *spellclickspells*

* *totemdisplayids, transport_data*

* *vendors*


The next ones are provided by arcemu so there is no need of conversion:

* *spell_coef_override, spell_effects_override, spell_proc, spelltargetconstraints* 

* *unit_display_sizes*

* *worldstring_tables, world_db_version*


The following tables are not going to be supported:

* *ai_agents, areatriggers*

* *clientaddons*

* *display_bounding_boxes*

* *gameobject_quest_pickup_binding, graveyards*

* *item_randomprop_groups, item_randomsuffix_groups*

* *loot_creatures, loot_fishing, loot_gameobjects, loot_items, loot_pickpocketing, loot_skining*

* *petdefaultspells, playercreateinfo, playercreateinfo_items, playercreateinfo_skills, playercreateinfo_spells*

* *reputation_creature_onkill, reputation_faction_onkill, reputation_instance_onkill*

* *spelloverride*

* *teleport_coords, trainer_defs, trainer_spells*

* *vendor_restrictions*

* *weather, weather_season, worldmap_info, worldstate_templates, worldstring_tables_localized*

* *zoneguards*


Finally, there are some special cases:

* *creature_timed_emotes, worldmap_info_localized (empty in all projects, so it wont be missed)*

* *creature_staticspawns (useless)*

* *gameobject_staticspawns (needed by core)*

* *gameobject_teleports, items_extendedcost (for custom stuff)*

* *transport_creatures, vehicle_accessories (this are very bugged, also poor implemented)*

* *command_overrides, spell_disable, trainerspelloverride, worldbroadcast, worldbroadcast_localized, wordfilter_chat, wordfilter_character_names (server admin)*

* *banned_phrases, item_quest_association, map_checkpoint (deprecated?)*


## Requirements

This require the TDB world database release 335.21081


## Instalation

1. Setup a TDB world database.

2. Run all files inside scripts folder or run install tool.

3. Execute remove_tdb_tables.sql

4. Execute add_arc_world_structure.sql, it would be logeable at this point.

5. Apply hotfixes in order. Additional notes on each file.

6. Can be completed with tables from [ArcDB.](https://github.com/DarkAngel39/ArcDB)


## Credits to

* TrinityCore for his wonderfull database job. 
* Formers ArcEmu database projects: NCDB, WHYDB, IFDB, POTD and ARCDB (so far).
* Marforius for ArcAddons who make my life much easier.
* ArcEmu developers for ArcEmu, specially to dfighter1985.


## Useful Links

* [ArcEmu Forums](http://www.arcemu.org/forums/)
* [ArcEmu Github](https://github.com/arcemu)
* [ArcEmu Wiki](https://arcemu.fandom.com/wiki/Arcemu_Wiki)