/obj/effect/countdown
	name = "countdown"
	desc = "We're leaving together\n\
		But still it's farewell\n\
		And maybe we'll come back\n\
		To Earth, who can tell?"

	invisibility = INVISIBILITY_OBSERVER
	anchored = TRUE
	layer = GHOST_LAYER
	color = "#ff0000" // text color
	appearance_flags = APPEARANCE_UI_IGNORE_ALPHA
	vis_flags = VIS_INHERIT_ID
	var/text_size = 3 // larger values clip when the displayed text is larger than 2 digits.
	var/started = FALSE
	var/displayed_text
	var/atom/attached_to

/obj/effect/countdown/Initialize(mapload)
	. = ..()
	attach(loc)
	RegisterSignal(loc, COMSIG_PARENT_QDELETING, PROC_REF(on_parent_deleting))

/obj/effect/countdown/proc/on_parent_deleting(atom/being_deleted, force)
	qdel(src)

/obj/effect/countdown/examine(mob/user)
	. = ..()
	. += "This countdown is displaying: [displayed_text]."

/obj/effect/countdown/proc/attach(atom/A)
	attached_to = A
	if(ismovable(A))
		var/atom/movable/M = A
		moveToNullspace()
		M.vis_contents |= src
	else
		forceMove(get_turf(A))

/obj/effect/countdown/proc/start()
	if(!started)
		START_PROCESSING(SSfastprocess, src)
		started = TRUE

/obj/effect/countdown/proc/stop()
	if(started)
		maptext = null
		STOP_PROCESSING(SSfastprocess, src)
		started = FALSE

/obj/effect/countdown/proc/get_value()
	// Get the value from our atom
	return

/obj/effect/countdown/process()
	if(!attached_to || QDELETED(attached_to))
		qdel(src)
	if(!ismovable(attached_to))
		forceMove(get_turf(attached_to))
	var/new_val = get_value()
	if(new_val == displayed_text)
		return
	displayed_text = new_val

	if(displayed_text)
		maptext = MAPTEXT("[displayed_text]")
	else
		maptext = null

/obj/effect/countdown/Destroy()
	STOP_PROCESSING(SSfastprocess, src)
	UnregisterSignal(attached_to, COMSIG_PARENT_QDELETING)
	attached_to = null
	. = ..()

/obj/effect/countdown/ex_act(severity, target, origin) //immune to explosions
	return

/obj/effect/countdown/syndicatebomb
	name = "syndicate bomb countdown"

/obj/effect/countdown/syndicatebomb/get_value()
	var/obj/machinery/syndicatebomb/S = attached_to
	if(!istype(S))
		return
	else if(S.active)
		return S.seconds_remaining()

/obj/effect/countdown/nuclearbomb
	name = "nuclear bomb countdown"
	color = "#81FF14"

/obj/effect/countdown/nuclearbomb/get_value()
	var/obj/machinery/nuclearbomb/N = attached_to
	if(!istype(N))
		return
	else if(N.timing)
		return round(N.get_time_left(), 1)

/obj/effect/countdown/clonepod
	name = "cloning pod countdown"
	color = "#18d100"
	text_size = 1

/obj/effect/countdown/clonepod/get_value()
	var/obj/machinery/clonepod/C = attached_to
	if(!istype(C))
		return
	else if(C.occupant)
		var/completion = round(C.get_completion())
		return completion

/obj/effect/countdown/clockworkgate
	name = "gateway countdown"
	text_size = 1
	color = "#BE8700"
	layer = POINT_LAYER

/obj/effect/countdown/clockworkgate/get_value()
	var/obj/structure/destructible/clockwork/massive/celestial_gateway/G = attached_to
	if(!istype(G))
		return
	else if(G.obj_integrity && !G.purpose_fulfilled)
		return "<div align='center' valign='middle' style='position:relative; top:0px; left:6px'>[G.get_arrival_time(FALSE)]</div>"

/obj/effect/countdown/supermatter
	name = "supermatter damage"
	text_size = 1
	color = "#00ff80"
	pixel_y = 8

/obj/effect/countdown/supermatter/attach(atom/A)
	. = ..()
	if(istype(A, /obj/machinery/power/supermatter_crystal/shard))
		pixel_y = -12

/obj/effect/countdown/supermatter/get_value()
	var/obj/machinery/power/supermatter_crystal/S = attached_to
	if(!istype(S))
		return
	return "<div align='center' valign='middle' style='position:relative; top:0px; left:0px'>[round(S.get_integrity(), 1)]%</div>"

/obj/effect/countdown/transformer
	name = "transformer countdown"
	color = "#4C5866"

/obj/effect/countdown/transformer/get_value()
	var/obj/machinery/transformer/T = attached_to
	if(!istype(T))
		return
	else if(T.cooldown)
		var/seconds_left = max(0, (T.cooldown_timer - world.time) / 10)
		return "[round(seconds_left)]"

/obj/effect/countdown/doomsday
	name = "doomsday countdown"

/obj/effect/countdown/doomsday/get_value()
	var/obj/machinery/doomsday_device/DD = attached_to
	if(!istype(DD))
		return
	else if(DD.timing)
		return "<div align='center' valign='middle' style='position:relative; top:0px; left:0px'>[DD.seconds_remaining()]</div>"

/obj/effect/countdown/anomaly
	name = "anomaly countdown"

/obj/effect/countdown/anomaly/get_value()
	var/obj/effect/anomaly/A = attached_to
	if(!istype(A))
		return
	else
		var/time_left = max(0, (A.death_time - world.time) / 10)
		return round(time_left)

/obj/effect/countdown/singularity_pull()
	return

/obj/effect/countdown/singularity_act()
	return

/obj/effect/countdown/flower_bud
	name = "flower bud countdown"

/obj/effect/countdown/flower_bud/get_value()
	var/obj/structure/alien/resin/flower_bud/bud = attached_to
	if(!istype(bud))
		return
	if(!bud.finish_time)
		return -1
	var/time_left = max(0, (bud.finish_time - world.time) / 10)
	return time_left
