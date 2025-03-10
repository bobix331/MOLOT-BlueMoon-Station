//Defines for atom layers and planes
//KEEP THESE IN A NICE ACSCENDING ORDER, PLEASE

#define PLANE_VOID -100

#define CLICKCATCHER_PLANE -99

#define PLANE_SPACE -98
#define PLANE_SPACE_RENDER_TARGET "PLANE_SPACE"

#define PLANE_SPACE_PARALLAX -95
#define PLANE_SPACE_PARALLAX_RENDER_TARGET "PLANE_SPACE_PARALLAX"

#define OPENSPACE_LAYER 17 //Openspace layer over all

//SINGULARITY EFFECT
#define SINGULARITY_EFFECT_PLANE_0 -16
#define SINGULARITY_0_RENDER_TARGET "*SINGULARITY_0_RENDER_TARGET"
#define SINGULARITY_EFFECT_PLANE_1 -15
#define SINGULARITY_1_RENDER_TARGET "*SINGULARITY_1_RENDER_TARGET"
#define SINGULARITY_EFFECT_PLANE_2 -14
#define SINGULARITY_2_RENDER_TARGET "*SINGULARITY_2_RENDER_TARGET"
#define SINGULARITY_EFFECT_PLANE_3 -13
#define SINGULARITY_3_RENDER_TARGET "*SINGULARITY_3_RENDER_TARGET"

#define GRAVITY_PULSE_PLANE -12
#define GRAVITY_PULSE_RENDER_TARGET "*GRAVPULSE_RENDER_TARGET"

#define OPENSPACE_PLANE -10 //Openspace plane below all turfs
#define OPENSPACE_BACKDROP_PLANE -9 //Black square just over openspace plane to guaranteed cover all in openspace turf

#define FLOOR_PLANE -8
#define FLOOR_PLANE_RENDER_TARGET "FLOOR_PLANE"

#define WALL_PLANE -3
#define WALL_PLANE_RENDER_TARGET "WALL_PLANE"

#define ABOVE_WALL_PLANE -3
#define ABOVE_WALL_PLANE_RENDER_TARGET "ABOVE_WALL_PLANE"

#define FIELD_OF_VISION_BLOCKER_PLANE -5
#define FIELD_OF_VISION_BLOCKER_RENDER_TARGET "*FIELD_OF_VISION_BLOCKER_PLANE"

#define FIELD_OF_VISION_PLANE -4
#define FIELD_OF_VISION_RENDER_TARGET "*FIELD_OF_VISION_PLANE"
#define FIELD_OF_VISION_LAYER 17 //used to place the visual (not the mask) shadow cone above any other floor plane stuff.

#define GAME_PLANE -3
#define GAME_PLANE_RENDER_TARGET "GAME_PLANE"

#define FIELD_OF_VISION_VISUAL_PLANE -2 //Yea, FoV does require quite a few planes to work with 513 filters to a decent degree.
#define FIELD_OF_VISION_VISUAL_RENDER_TARGET "FIELD_OF_VISION_VISUAL_PLANE"

#define CHAT_PLANE -1 //We don't want heard messages to be hidden by FoV.

#define CHAT_LAYER 12.0001 // Do not insert layers between these two values
#define CHAT_LAYER_MAX 12.9999

#define BLACKNESS_PLANE 0 //To keep from conflicts with SEE_BLACKNESS internals
#define BLACKNESS_PLANE_RENDER_TARGET "BLACKNESS_PLANE"

///Layers most often used by atoms of plane lower than GAME_PLANE
#define SPACE_LAYER 1.8
//#define TURF_LAYER 2 //For easy recordkeeping; this is a byond define
#define MID_TURF_LAYER 2.02
#define HIGH_TURF_LAYER 2.03
#define TURF_PLATING_DECAL_LAYER 2.031
#define TURF_DECAL_LAYER 2.039 //Makes turf decals appear in DM how they will look inworld.
#define ABOVE_OPEN_TURF_LAYER 2.04
#define CLOSED_TURF_LAYER 2.05
#define BULLET_HOLE_LAYER 2.06
#define ABOVE_NORMAL_TURF_LAYER 2.08
#define LATTICE_LAYER 2.2
#define DISPOSAL_PIPE_LAYER 2.3
#define GAS_PIPE_HIDDEN_LAYER 2.35
#define WIRE_LAYER 2.4
#define WIRE_TERMINAL_LAYER 2.45
#define GAS_SCRUBBER_LAYER 2.46
#define GAS_PIPE_VISIBLE_LAYER 2.47
#define GAS_FILTER_LAYER 2.48
#define GAS_PUMP_LAYER 2.49
#define LOW_OBJ_LAYER 2.5
///catwalk overlay of /turf/open/floor/plating/plating_catwalk
#define CATWALK_LAYER 2.51
#define LOW_SIGIL_LAYER 2.52
#define SIGIL_LAYER 2.54
#define HIGH_SIGIL_LAYER 2.56
///Layers most often used by atoms of plane equal or higher than GAME_PLANE
#define BELOW_OPEN_DOOR_LAYER 2.6
#define BLASTDOOR_LAYER 2.65
#define OPEN_DOOR_LAYER 2.7
#define DOOR_ACCESS_HELPER_LAYER 2.71 //keep this above OPEN_DOOR_LAYER, special layer used for /obj/effect/mapping_helpers/airlock/access
#define DOOR_HELPER_LAYER 2.72 //keep this above OPEN_DOOR_LAYER
#define PROJECTILE_HIT_THRESHHOLD_LAYER 2.75 //projectiles won't hit objects at or below this layer if possible
#define TABLE_LAYER 2.8
#define TRAY_LAYER 2.85
#define GATEWAY_UNDERLAY_LAYER 2.85
#define BELOW_OBJ_LAYER 2.9
#define LOW_ITEM_LAYER 2.95
//#define OBJ_LAYER 3 //For easy recordkeeping; this is a byond define
#define CLOSED_DOOR_LAYER 3.1
#define CLOSED_FIREDOOR_LAYER 3.11
#define CLOSED_BLASTDOOR_LAYER 3.115 // BLUEMOON EDIT, WAS 3.05
#define SHUTTER_LAYER 3.12 // HERE BE DRAGONS
#define ABOVE_OBJ_LAYER 3.2
#define ABOVE_WINDOW_LAYER 3.3
#define SIGN_LAYER 3.4
#define NOT_HIGH_OBJ_LAYER 3.5
#define HIGH_OBJ_LAYER 3.6

#define BELOW_MOB_LAYER 3.7
#define LYING_MOB_LAYER 3.8
#define MOB_LOWER_LAYER 3.95
//#define MOB_LAYER 4 //For easy recordkeeping; this is a byond define
#define MOB_UPPER_LAYER 4.05
#define ABOVE_MOB_LAYER 4.1
#define WALL_OBJ_LAYER 4.25
#define EDGED_TURF_LAYER 4.3
#define ON_EDGED_TURF_LAYER 4.35
#define LARGE_MOB_LAYER 4.4
#define ABOVE_ALL_MOB_LAYER 4.5
#define RAILING_LAYER 4.7

#define SPACEVINE_LAYER 4.8
#define SPACEVINE_MOB_LAYER 4.9
//#define FLY_LAYER 5 //For easy recordkeeping; this is a byond define
#define ABOVE_FLY_LAYER 5.1
#define GASFIRE_LAYER 5.2
#define RIPPLE_LAYER 5.3

#define GHOST_LAYER 6
#define LOW_LANDMARK_LAYER 9
#define MID_LANDMARK_LAYER 9.1
#define HIGH_LANDMARK_LAYER 9.2
#define AREA_LAYER 10
#define MASSIVE_OBJ_LAYER 11
#define POINT_LAYER 12

#define EMISSIVE_BLOCKER_PLANE 12
#define EMISSIVE_BLOCKER_LAYER 12
#define EMISSIVE_BLOCKER_RENDER_TARGET "*EMISSIVE_BLOCKER_PLANE"

#define EMISSIVE_PLANE 13
#define EMISSIVE_LAYER 13

#define EMISSIVE_UNBLOCKABLE_PLANE 4 //Пробуем починить Леерсы.
#define EMISSIVE_UNBLOCKABLE_LAYER 4
#define EMISSIVE_LAYER_UNBLOCKABLE 4
#define EMISSIVE_UNBLOCKABLE_RENDER_TARGET "*EMISSIVE_UNBLOCKABLE_PLANE"
#define EMISSIVE_RENDER_TARGET "*EMISSIVE_PLANE"

#define LIGHTING_PLANE 4
#define LIGHTING_LAYER 4
#define LIGHTING_RENDER_TARGET "LIGHT_PLANE"

#define O_LIGHTING_VISUAL_PLANE 110
#define O_LIGHTING_VISUAL_RENDER_TARGET "O_LIGHT_VISUAL_PLANE"

#define RAD_TEXT_LAYER 15.1

#define ABOVE_LIGHTING_PLANE 4
#define ABOVE_LIGHTING_LAYER 4 //Пробуем починить Леерсы.
#define ABOVE_LIGHTING_RENDER_TARGET "ABOVE_LIGHTING_PLANE"

#define BYOND_LIGHTING_PLANE 18
#define BYOND_LIGHTING_LAYER 18
#define BYOND_LIGHTING_RENDER_TARGET "BYOND_LIGHTING_PLANE"

#define CAMERA_STATIC_PLANE 19
#define CAMERA_STATIC_LAYER 19
#define CAMERA_STATIC_RENDER_TARGET "CAMERA_STATIC_PLANE"

/// Plane for balloon text (text that fades up)
/// It's over lighting and every other crap because this is nearly as important as hud content and only visible to the user.
#define BALLOON_CHAT_PLANE 20

///Visuals that represent sounds happening, and can be seen while blind.
#define SOUND_EFFECT_VISUAL_PLANE 25

//HUD layer defines

#define FULLSCREEN_PLANE 20
#define FLASH_LAYER 20
#define FULLSCREEN_LAYER 20.1
#define UI_DAMAGE_LAYER 20.2
#define BLIND_LAYER 20.3
#define CRIT_LAYER 20.4
#define CURSE_LAYER 20.5
#define FULLSCREEN_RENDER_TARGET "FULLSCREEN_PLANE"

#define HUD_PLANE 21
#define HUD_LAYER 21
#define HUD_RENDER_TARGET "HUD_PLANE"

#define VOLUMETRIC_STORAGE_BOX_PLANE 22
#define VOLUMETRIC_STORAGE_BOX_LAYER 22
#define VOLUMETRIC_STORAGE_BOX_RENDER_TARGET "VOLUME_STORAGE_BOX_PLANE"

#define VOLUMETRIC_STORAGE_ITEM_PLANE 23
#define VOLUMETRIC_STORAGE_ITEM_LAYER 23
#define VOLUMETRIC_STORAGE_ACTIVE_ITEM_LAYER 25
#define VOLUMETRIC_STORAGE_ACTIVE_ITEM_PLANE 25
#define VOLUMETRIC_STORAGE_ITEM_RENDER_TARGET "VOLUME_STORAGE_ITEM_PLANE"

#define ABOVE_HUD_PLANE 30
#define ABOVE_HUD_LAYER 30
#define ABOVE_HUD_RENDER_TARGET "ABOVE_HUD_PLANE"

///Layer for lobby menu collapse button
#define LOBBY_BELOW_MENU_LAYER 2
///Layer for lobby menu background image and main buttons (Join/Ready, Observe, Charater Prefs)
#define LOBBY_MENU_LAYER 3
///Layer for lobby menu shutter, which covers up the menu to collapse/expand it
#define LOBBY_SHUTTER_LAYER 4
///Layer for lobby menu buttons that are hanging away from and lower than the main panel
#define LOBBY_BOTTOM_BUTTON_LAYER 5

#define SPLASHSCREEN_LAYER 90
#define SPLASHSCREEN_PLANE 90
#define SPLASHSCREEN_RENDER_TARGET "SPLASHSCREEN_PLANE"

//-------------------- Rendering ---------------------
#define RENDER_PLANE_GAME 100
#define RENDER_PLANE_NON_GAME 101

// Only VERY special planes should be here, as they are above not just the game, but the UI planes as well.

/// Plane related to the menu when pressing Escape.
/// Needed so that we can apply a blur effect to EVERYTHING, and guarantee we are above all UI.
#define ESCAPE_MENU_PLANE 105
#define ESCAPE_MENU_DIMMER_LAYER 105.1
#define ESCAPE_MENU_DEFAULT_LAYER 105.2

#define RENDER_PLANE_MASTER 110

// Lummox I swear to god I will find you
// NOTE! You can only ever have planes greater then -10000, if you add too many with large offsets you will brick multiz
// Same can be said for large multiz maps. Tread carefully mappers
#define HIGHEST_EVER_PLANE RENDER_PLANE_MASTER
/// The range unique planes can be in
#define PLANE_RANGE (HIGHEST_EVER_PLANE - PLANE_VOID)

#define SINGULARITY_LAYER 1
#define ABOVE_SINGULARITY_LAYER 2

#define FOV_EFFECTS_LAYER 2 //Blindness effects are not layer 4, they lie to you

//Plane master critical flags
//Describes how different plane masters behave when they are being culled for performance reasons
/// This plane master will not go away if its layer is culled. useful for preserving effects
#define PLANE_CRITICAL_DISPLAY (1<<0)
/// This plane master will temporarially remove relays to non critical planes if it's layer is culled (and it's critical)
/// This is VERY hacky, but needed to ensure that some instances of BLEND_MULITPLY work as expected (fuck you god damn parallax)
/// It also implies that the critical plane has a *'d render target, making it mask itself
#define PLANE_CRITICAL_NO_EMPTY_RELAY (1<<1)

#define RENDER_PLANE_GAME_WORLD -1

#define RENDER_PLANE_LIGHTING 15

// Admin popup layer
#define ADMIN_POPUP_LAYER 1

///Plane master controller keys
#define PLANE_MASTERS_GAME "plane_masters_game"

///Layer for screentips
#define SCREENTIP_LAYER 40
