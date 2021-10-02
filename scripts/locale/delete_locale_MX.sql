SET @LOCALE := 'esMX';

DELETE FROM `creature_names_localized` WHERE `language_code` = @LOCALE;

DELETE FROM `gameobject_names_localized` WHERE `language_code` = @LOCALE;

DELETE FROM `itempages_localized` WHERE `language_code` = @LOCALE;

DELETE FROM `npc_text_localized` WHERE `language_code` = @LOCALE;

DELETE FROM `quests_localized` WHERE `language_code` = @LOCALE;