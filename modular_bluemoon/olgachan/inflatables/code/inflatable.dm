
#define TAPE_REQUIRED_TO_FIX 2
#define INFLATABLE_DOOR_OPENED FALSE
#define INFLATABLE_DOOR_CLOSED TRUE
#define BOX_DOOR_AMOUNT 7
#define BOX_WALL_AMOUNT 14

/obj/structure/inflatable
	name = "inflatable wall"
	desc = "An inflated membrane. Do not puncture."
	CanAtmosPass = ATMOS_PASS_DENSITY
	density = TRUE
	anchored = TRUE
	max_integrity = 40
	icon = 'modular_bluemoon/olgachan/inflatables/icons/inflatable.dmi'
	icon_state = "wall"
	/// The type we drop when damaged.
	var/torn_type = /obj/item/inflatable/torn
	/// The type we drop when deflated.
	var/deflated_type = /obj/item/inflatable
	/// The hitsound made when we're... hit...
	var/hit_sound = 'sound/effects/Glasshit.ogg'
	/// How quickly we deflate when manually deflated.
	var/has_been_deflated = FALSE

/obj/structure/inflatable/Initialize(mapload)
	. = ..()
	air_update_turf(TRUE, !density)
	if (!armor)
		armor = list(MELEE = 0, BULLET =30, LASER = 20, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)
	. = ..()
	if(smooth)
		queue_smooth(src)
		queue_smooth_neighbors(src)
		icon_state = ""
	GLOB.cameranet.updateVisibility(src)

/obj/structure/Destroy()
	GLOB.cameranet.updateVisibility(src)
	if(smooth)
		queue_smooth_neighbors(src)
	return ..()

/obj/structure/inflatable/ex_act(severity)
	switch(severity)
		if(EXPLODE_DEVASTATE)
			qdel(src)
			return
		if(EXPLODE_HEAVY)
			deflate(TRUE)
			return
		if(EXPLODE_LIGHT)
			if(prob(50))
				deflate(TRUE)
				return


/obj/structure/inflatable/attackby(obj/item/attacking_item, mob/user, params)
	if(attacking_item.sharpness)
		visible_message(span_danger("<b>[user] pierces [src] with [attacking_item]!</b>"))
		deflate(TRUE)
		return

/obj/structure/inflatable/play_attack_sound(damage_amount, damage_type, damage_flag)
	playsound(src, hit_sound, 75, TRUE)

// Deflates the airbag and drops a deflated airbag item. If violent, drops a broken item instantly.
/obj/structure/inflatable/proc/deflate(violent)
	if(has_been_deflated)
		return

	has_been_deflated = TRUE

	var/turf/inflatable_loc = get_turf(src)
	inflatable_loc.balloon_alert_to_viewers("[src] rapidly deflates!") // just so we don't balloon alert from the qdeleted inflatable object
	if(torn_type)
		new torn_type(get_turf(src))
	qdel(src)

/obj/structure/inflatable/verb/hand_deflate()
	set name = "Deflate"
	set category = "Object"
	set src in oview(1)

	if(usr.stat || usr.can_interact())
		return
	deflate(FALSE)


/obj/structure/inflatable/door
	name = "inflatable door"
	CanAtmosPass = ATMOS_PASS_DENSITY
	icon = 'modular_bluemoon/olgachan/inflatables/icons/inflatable.dmi'
	icon_state = "door_closed"
	base_icon_state = "door"
	torn_type = /obj/item/inflatable/door/torn
	deflated_type = /obj/item/inflatable/door
	/// Are we open(FALSE), or are we closed(TRUE)?
	var/door_state = INFLATABLE_DOOR_CLOSED

/obj/structure/inflatable/door/Initialize(mapload)
	. = ..()
	density = door_state

/obj/structure/inflatable/door/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	if(!user.can_interact_with(src))
		return
	toggle_door()
	to_chat(user, span_notice("You [door_state ? "close" : "open"] [src]!"))

/obj/structure/inflatable/door/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state]_[door_state ? "closed" : "open"]"

/obj/structure/inflatable/door/proc/toggle_door()
	if(door_state) // opening
		door_state = INFLATABLE_DOOR_OPENED
		flick("[base_icon_state]_opening", src)
	else // Closing
		door_state = INFLATABLE_DOOR_CLOSED
		flick("[base_icon_state]_closing", src)
	density = door_state
	air_update_turf(TRUE, !density)
	update_appearance()


// The deployable item
/obj/item/inflatable
	name = "inflatable wall"
	desc = "A folded membrane which rapidly expands into a large cubical shape on activation."
	icon = 'modular_bluemoon/olgachan/inflatables/icons/inflatable.dmi'
	icon_state = "folded_wall"
	base_icon_state = "folded_wall"
	w_class = WEIGHT_CLASS_SMALL
	/// The structure we deploy when used.
	var/structure_type = /obj/structure/inflatable
	/// Are we torn?
	var/torn = FALSE

/obj/item/inflatable/Initialize(mapload)
	. = ..()
	update_appearance()

/obj/item/inflatable/torn
	torn = TRUE

/obj/item/inflatable/attack_self(mob/user)
	. = ..()
	if(torn)
		to_chat(user, span_warning("[src] is too damaged to function!"))
		return
	if(locate(structure_type) in get_turf(user))
		to_chat(user, span_warning("There is already a wall here!"))
		return
	playsound(loc, 'sound/items/zip.ogg', 75, 1)
	to_chat(user, span_notice("You inflate [src]."))
	if(do_after(user, 1 SECONDS, src))
		new structure_type(get_turf(user))
		qdel(src)

/obj/item/inflatable/attackby(obj/item/attacking_item, mob/user)
	if(!istype(attacking_item, /obj/item/stack/sticky_tape))
		return ..()
	if(!torn)
		to_chat(user, span_notice("[src] does not need repairing!"))
		return
	var/obj/item/stack/sticky_tape/attacking_tape = attacking_item
	if(attacking_tape.use(TAPE_REQUIRED_TO_FIX, check = TRUE))
		to_chat(user, span_danger("There is not enough of [attacking_tape]! You need at least [TAPE_REQUIRED_TO_FIX] pieces!"))
		return
	if(!do_after(user, 2 SECONDS, src))
		return
	playsound(user, 'modular_bluemoon/olgachan/inflatables/sound/ducttape1.ogg', 50, 1)
	to_chat(user, span_notice("You fix [src] using [attacking_tape]!"))
	attacking_tape.use(TAPE_REQUIRED_TO_FIX)
	torn = FALSE
	update_appearance()

/obj/item/inflatable/update_icon_state()
	. = ..()
	icon_state = "[base_icon_state][torn ? "_torn" : ""]"

/obj/item/inflatable/examine(mob/user)
	. = ..()
	if(torn)
		. += span_warning("It is badly torn, and cannot be used! The damage looks like it could be repaired with some <b>tape</b>.")

/obj/item/inflatable/door
	name = "inflatable door"
	desc = "A folded membrane which rapidly expands into a simple door on activation."
	icon = 'modular_bluemoon/olgachan/inflatables/icons/inflatable.dmi'
	icon_state = "folded_door"
	base_icon_state = "folded_door"
	structure_type = /obj/structure/inflatable/door

/obj/item/inflatable/door/torn
	torn = TRUE
