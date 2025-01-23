/turf/open/floor/festive/cobblestone/safe/mesafcobble

/turf/open/floor/festive/cobblestone/safe/mesafcobble/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/floor/festive/cobblestone/safe/mesafcobble/singularity_act()
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/break_tile()
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/burn_tile()
	return

/turf/open/floor/festive/cobblestone/safe/mesafcobble/can_have_cabling()
	return TRUE

/turf/open/floor/festive/cobblestone/safe/mesafcobble/crowbar_act(mob/living/user, obj/item/I)
	return

/turf/closed/mineral/black_mesa
	turf_type = /turf/open/floor/plating/ironsand/black_mesa
	baseturfs = /turf/open/floor/plating/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS

/turf/open/floor/plating/ironsand/black_mesa
	baseturfs = /turf/open/floor/plating/ironsand/black_mesa
	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = TRUE

/turf/open/floor/festive/sidewalk/mesawalk

	initial_gas_mix = OPENTURF_DEFAULT_ATMOS
	planetary_atmos = FALSE

/turf/open/floor/festive/sidewalk/mesawalk/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/floor/festive/sidewalk/mesawalk/singularity_act()
	return

/turf/open/floor/festive/sidewalk/mesawalk/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return

/turf/open/floor/festive/sidewalk/mesawalk/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/festive/sidewalk/mesawalk/try_replace_tile(obj/item/stack/tile/T, mob/user, params)
	return

/turf/open/floor/festive/sidewalk/mesawalk/break_tile()
	return

/turf/open/floor/festive/sidewalk/mesawalk/burn_tile()
	return

/turf/open/floor/festive/sidewalk/mesawalk/can_have_cabling()
	return TRUE

/turf/open/floor/festive/sidewalk/mesawalk/crowbar_act(mob/living/user, obj/item/I)
	return


/turf/open/floor/plating/ironsand/indestructible

/turf/open/floor/plating/ironsand/indestructible/Melt()
	to_be_destroyed = FALSE
	return src

/turf/open/floor/plating/ironsand/indestructible/singularity_act()
	return

/turf/open/floor/plating/ironsand/indestructible/TerraformTurf(path, new_baseturf, flags, defer_change = FALSE, ignore_air = FALSE)
	return
