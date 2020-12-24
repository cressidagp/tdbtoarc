# TDBtoARC

## Introduction

TDBtoARC its a NON-OFFICIAL database conversion project for ArcEmu just for learning purposes. It will partially convert the latest Trinity world database to ArcEmu structure.

WARNING: this stuff its experimental and eventually i can find something than cant be done, so if you have a database then keep developing it.

Feel free to open tickets to report bugs. Feedback its apreciated.


## Features

Scripts to obtain the following tables populated: 

* ai_threattospellid

* battlemasters

* creature_formations, creature_names, creature_names_localized, creature_proto, creature_quest_finisher, creature_quest_starter, creature_spawns, creature_waypoints
* itempages, itempages_localized, itempetfood, items, items_localized

* gameobject_names, gameobject_names_localized, gameobject_quest_starter, gameobject_quest_finisher, gameobject_spawns

* instance_bosses

* npc_gossip_textid, npc_monstersay, npc_text, npc_text_localized

* playercreateinfo_bars

* quest_poi, quest_poi_points, quests, quests_localized

* spellclickspells


The following tables are not going to be supported:

* ai_agents, areatriggers, auctionhouse

* clientaddons, command_overrides, creature_staticspawns, creature_timed_emotes

* display_bounding_boxes

* fishing

* gameobject_staticspawns, graveyards

So far. 


## Requirements

This require the latest release of TDB world database.


## Instalation

1. Setup a TDB world database.

2. Apply all tool files.

3. Apply table remover.

4. Add missing tables (you can use formers arcemu database projects or run world_structure)


## Credits to

* Trinity for his wonderfull database job. 
* KFL for some info about guardtype and IsTrainingDummy.
* Formers ArcEmu database projects: NCDB, WHYDB, IFDB, POTD and ARCDB (so far).
* ArcEmu developers for ArcEmu, specially to dfighter1985.


## Links

* [ArcEmu Forums](http://www.arcemu.org/forums/)
* [ArcEmu Github](https://github.com/arcemu)
* [ArcEmu Wiki](https://arcemu.fandom.com/wiki/Arcemu_Wiki)