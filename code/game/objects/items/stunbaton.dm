#define STUNBATON_CHARGE_LENIENCY 0.3
#define STUNBATON_DEPLETION_RATE 0.006

/obj/item/melee/baton
	name = "stunbaton"
	desc = "A stun baton for incapacitating people with."
	icon_state = "stunbaton"
	item_state = "baton"
	lefthand_file = 'icons/mob/inhands/equipment/security_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/equipment/security_righthand.dmi'
	slot_flags = ITEM_SLOT_BELT
	force = 10
	throwforce = 7
	w_class = WEIGHT_CLASS_NORMAL
	attack_verb = list("beaten")
	armor = list(MELEE = 0, BULLET = 0, LASER = 0, ENERGY = 0, BOMB = 50, BIO = 0, RAD = 0, FIRE = 80, ACID = 80)
	attack_speed = CLICK_CD_MELEE

	var/stamina_loss_amount = 35
	var/turned_on = FALSE
	var/armor_pen = 100
	var/knockdown = TRUE
	/// block percent needed to prevent knockdown/disarm
	var/block_percent_to_counter = 50
	var/obj/item/stock_parts/cell/cell
	var/hitcost = 750
	var/throw_hit_chance = 50
	var/preload_cell_type //if not empty the baton starts with this type of cell
	var/cooldown_duration = 2.5 SECONDS //How long our baton rightclick goes on cooldown for after applying a knockdown
	var/status_duration = 3 SECONDS //how long our status effects last for otherwise
	COOLDOWN_DECLARE(shove_cooldown)

/obj/item/melee/baton/examine(mob/user)
	. = ..()
	. += "<span class='notice'>Right click attack while in combat mode to knockdown, but only once per [cooldown_duration / 10] seconds.</span>"
	. += "<span class='notice'>This knockdown will also put them off balance for  [status_duration / 20] seconds, allowing you to shove a weapon out of their hand with a right click in Disarm intent.</span>"

/obj/item/melee/baton/get_cell()
	. = cell
	if(iscyborg(loc))
		var/mob/living/silicon/robot/R = loc
		. = R.get_cell()

/obj/item/melee/baton/suicide_act(mob/user)
	user.visible_message("<span class='suicide'>[user] is putting the live [name] in [user.ru_ego()] mouth! It looks like [user.p_theyre()] trying to commit suicide!</span>")
	return (FIRELOSS)

/obj/item/melee/baton/Initialize(mapload)
	. = ..()
	if(preload_cell_type)
		if(!ispath(preload_cell_type,/obj/item/stock_parts/cell))
			log_mapping("[src] at [AREACOORD(src)] had an invalid preload_cell_type: [preload_cell_type].")
		else
			cell = new preload_cell_type(src)
	update_icon()

	register_item_context()

/obj/item/melee/baton/DoRevenantThrowEffects(atom/target)
	switch_status()

/obj/item/melee/baton/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	..()
	var/mob/thrown_by = thrownby?.resolve()
	//Only mob/living types have stun handling
	if(turned_on && prob(throw_hit_chance) && iscarbon(hit_atom) && thrown_by)
		baton_stun(hit_atom, thrown_by, shoving = TRUE)

/obj/item/melee/baton/loaded //this one starts with a cell pre-installed.
	preload_cell_type = /obj/item/stock_parts/cell/high/plus

/obj/item/melee/baton/proc/deductcharge(chrgdeductamt, chargecheck = TRUE, explode = TRUE)
	var/obj/item/stock_parts/cell/copper_top = get_cell()
	if(!copper_top)
		switch_status(FALSE, TRUE)
		return FALSE
	//Note this value returned is significant, as it will determine
	//if a stun is applied or not

	copper_top.use(min(chrgdeductamt, copper_top.charge), explode)
	if(QDELETED(src))
		return FALSE
	if(turned_on && (!copper_top || !copper_top.charge || (chargecheck && copper_top.charge < (hitcost * STUNBATON_CHARGE_LENIENCY))))
		//we're below minimum, turn off
		switch_status(FALSE)

/obj/item/melee/baton/proc/switch_status(new_status = FALSE, silent = FALSE)
	if(turned_on != new_status)
		turned_on = new_status
		if(!silent)
			playsound(loc, "sparks", 75, 1, -1)
		if(turned_on)
			START_PROCESSING(SSobj, src)
		else
			STOP_PROCESSING(SSobj, src)
	update_icon()

/obj/item/melee/baton/process()
	deductcharge(round(hitcost * STUNBATON_DEPLETION_RATE), FALSE, FALSE)

/obj/item/melee/baton/update_icon_state()
	if(turned_on)
		icon_state = "[initial(name)]_active"
	else if(!cell)
		icon_state = "[initial(name)]_nocell"
	else
		icon_state = "[initial(name)]"

/obj/item/melee/baton/examine(mob/user)
	. = ..()
	var/obj/item/stock_parts/cell/copper_top = get_cell()
	if(copper_top)
		. += "<span class='notice'>\The [src] is [round(copper_top.percent())]% charged.</span>"
		. += "<span class='notice'>\The [src] currently can penetrate [round(copper_top.maxcharge/1000)]% of enemy armor thanks to it's loaded cell.</span>"
	else
		. += "<span class='warning'>\The [src] does not have a power source installed.</span>"

/obj/item/melee/baton/attackby(obj/item/W, mob/user, params)
	if(istype(W, /obj/item/stock_parts/cell))
		var/obj/item/stock_parts/cell/C = W
		if(cell)
			to_chat(user, "<span class='notice'>[src] already has a cell.</span>")
		else
			if(C.maxcharge < (hitcost * STUNBATON_CHARGE_LENIENCY))
				to_chat(user, "<span class='notice'>[src] requires a higher capacity cell.</span>")
				return
			if(!user.transferItemToLoc(W, src))
				return
			cell = W
			to_chat(user, "<span class='notice'>You install a cell in [src].</span>")
			update_icon()

	else if(W.tool_behaviour == TOOL_SCREWDRIVER)
		if(cell)
			cell.update_icon()
			cell.forceMove(get_turf(src))
			cell = null
			to_chat(user, "<span class='notice'>You remove the cell from [src].</span>")
			switch_status(FALSE, TRUE)
	else
		return ..()

/obj/item/melee/baton/attack_self(mob/user)
	var/obj/item/stock_parts/cell/copper_top = get_cell()
	if(!copper_top || copper_top.charge < (hitcost * STUNBATON_CHARGE_LENIENCY))
		switch_status(FALSE, TRUE)
		if(!copper_top)
			to_chat(user, "<span class='warning'>[src] does not have a power source!</span>")
		else
			to_chat(user, "<span class='warning'>[src] is out of charge.</span>")
	else
		switch_status(!turned_on)
		to_chat(user, "<span class='notice'>[src] is now [turned_on ? "on" : "off"].</span>")
	add_fingerprint(user)

/obj/item/melee/baton/attack(mob/M, mob/living/carbon/human/user)
	var/interrupt = common_baton_melee(M, user, FALSE)
	if(!interrupt)
		return ..()

/obj/item/melee/baton/add_item_context(datum/source, list/context, atom/target, mob/living/user)
	if (isturf(target))
		return NONE

	if (isobj(target))
		LAZYSET(context[SCREENTIP_CONTEXT_LMB], INTENT_ANY, "Attack")
	else
		if (turned_on)
			LAZYSET(context[SCREENTIP_CONTEXT_RMB], INTENT_ANY, "Knockdown")

			LAZYSET(context[SCREENTIP_CONTEXT_LMB], INTENT_ANY, "Stun")
			LAZYSET(context[SCREENTIP_CONTEXT_LMB], INTENT_HARM, "Harmful stun")
		else
			LAZYSET(context[SCREENTIP_CONTEXT_RMB], INTENT_ANY, "Knockdown") // DON'T TELL EM, PRANKED.

			LAZYSET(context[SCREENTIP_CONTEXT_LMB], INTENT_ANY, "Stun") // STILL DO NOT DARE TELLING THEM
			LAZYSET(context[SCREENTIP_CONTEXT_LMB], INTENT_HARM, "Attack") // It's fine i guess...?

	return CONTEXTUAL_SCREENTIP_SET

/obj/item/melee/baton/alt_pre_attack(atom/A, mob/living/user, params)
	if(!user.CheckActionCooldown(CLICK_CD_MELEE))
		return
	. = common_baton_melee(A, user, TRUE)		//return true (attackchain interrupt) if this also returns true. no harm-shoving.

//return TRUE to interrupt attack chain.
/obj/item/melee/baton/proc/common_baton_melee(mob/M, mob/living/user, shoving = FALSE)
	if(iscyborg(M) || !isliving(M))		//can't baton cyborgs
		return FALSE
	if(turned_on && HAS_TRAIT(user, TRAIT_CLUMSY) && prob(50))
		clowning_around(user)
	if(IS_STAMCRIT(user))			//CIT CHANGE - makes it impossible to baton in stamina softcrit
		to_chat(user, "<span class='danger'>You're too exhausted to use [src] properly.</span>")
		return TRUE
	user.DelayNextAction()
	if(ishuman(M))
		var/mob/living/carbon/human/L = M
		if(check_martial_counter(L, user))
			return TRUE
	if(turned_on)
		if(baton_stun(M, user, shoving))
			user.do_attack_animation(M)
	else if(user.a_intent != INTENT_HARM)			//they'll try to bash in the last proc.
		M.visible_message("<span class='warning'>[user] has prodded [M] with [src]. Luckily it was off.</span>", \
						"<span class='warning'>[user] has prodded you with [src]. Luckily it was off</span>")
	return shoving || (user.a_intent != INTENT_HARM)

/obj/item/melee/baton/proc/baton_stun(mob/living/L, mob/living/user, shoving = FALSE)
	var/list/return_list = list()
	if(L.mob_run_block(src, 0, "[user]'s [name]", ATTACK_TYPE_MELEE, 0, user, null, return_list) & BLOCK_SUCCESS) //No message; check_shields() handles that
		playsound(L, 'sound/weapons/genhit.ogg', 50, 1)
		return FALSE
	var/final_stamina_loss_amount = stamina_loss_amount //Our stunning power for the baton
	var/shoved = FALSE //Did we succeed on knocking our target over?
	var/zap_penetration = armor_pen
	var/zap_block = L.run_armor_check(BODY_ZONE_CHEST, MELEE, null, null, zap_penetration) //armor check, including calculation for armor penetration, for our attack
	final_stamina_loss_amount = block_calculate_resultant_damage(final_stamina_loss_amount, return_list)

	var/obj/item/stock_parts/cell/our_cell = get_cell()

	if(!our_cell)
		switch_status(FALSE)
		return FALSE
	var/stuncharge = our_cell.charge
	deductcharge(hitcost, FALSE)
	if(QDELETED(src) || QDELETED(our_cell)) //it was rigged
		return FALSE
	if(stuncharge < hitcost)
		if(stuncharge < (hitcost * STUNBATON_CHARGE_LENIENCY))
			L.visible_message("<span class='warning'>[user] has prodded [L] with [src]. Luckily it was out of charge.</span>", \
							"<span class='warning'>[user] has prodded you with [src]. Luckily it was out of charge.</span>")
			return FALSE
		final_stamina_loss_amount *= round(stuncharge/hitcost, 0.1)

	if(user && !user.UseStaminaBuffer(getweight(user, STAM_COST_BATON_MOB_MULT), warn = TRUE))
		return FALSE

	if(shoving && COOLDOWN_FINISHED(src, shove_cooldown) && !HAS_TRAIT(L, TRAIT_IWASBATONED)) //Rightclicking applies a knockdown, but only once every couple of seconds, based on the cooldown_duration var. If they were recently knocked down, they can't be knocked down again by a baton.
		if(L.mob_weight < MOB_WEIGHT_HEAVY_SUPER) // BLUEMOON ADD - больших и тяжёлых существ проблематично нормально оглушить
			L.DefaultCombatKnockdown(50, override_stamdmg = 0)
			L.apply_status_effect(STATUS_EFFECT_TASED_WEAK_NODMG, status_duration) //Even if they shove themselves up, they're still slowed.
		// BLUEMOON ADD START - больших и тяжёлых существ проблематично нормально оглушить
		else
			if(get_size(L) > 1)
				final_stamina_loss_amount *= 1 / get_size(L) // я за час не придумал, как из 1 получить 1 и из 2 получить 0.5 - сделайте вы
		// BLUEMOON ADD END
		L.apply_status_effect(STATUS_EFFECT_OFF_BALANCE, status_duration) //They're very likely to drop items if shoved briefly after a knockdown.
		shoved = TRUE
		COOLDOWN_START(src, shove_cooldown, cooldown_duration)
		ADD_TRAIT(L, TRAIT_IWASBATONED, STATUS_EFFECT_TRAIT) //Prevents swapping to a new baton to avoid the cooldown by just acquiring more batons
		addtimer(TRAIT_CALLBACK_REMOVE(L, TRAIT_IWASBATONED, STATUS_EFFECT_TRAIT), cooldown_duration)
		playsound(loc, 'sound/weapons/zapbang.ogg', 50, 1, -1)
	else //If we cannot/don't knock down the target, we apply a stagger, which keeps them from just running off
		L.apply_status_effect(STATUS_EFFECT_STAGGERED, status_duration)

	L.apply_damage (final_stamina_loss_amount, STAMINA, BODY_ZONE_CHEST, zap_block)
	L.apply_effect(EFFECT_STUTTER, stamina_loss_amount)
	SEND_SIGNAL(L, COMSIG_LIVING_MINOR_SHOCK)
	if(user)
		if(L.mob_weight < MOB_WEIGHT_HEAVY_SUPER) // BLUEMOON ADD - больших и тяжёлых существ проблематично нормально оглушить
			L.Jitter(25)
			L.Dizzy(25)
		L.set_last_attacker(user)
		L.visible_message("<span class='danger'>[user] has [shoved ? "brutally stunned" : "stunned"] [L] with [src]!</span>", \
								"<span class='userdanger'>[user] has [shoved ? "brutally stunnned" : "stunned"] you with [src]!</span>")
		log_combat(user, L, shoved ? "stunned and attempted knockdown" : "stunned")

	playsound(loc, 'sound/weapons/egloves.ogg', 50, 1, -1)

	if(ishuman(L))
		var/mob/living/carbon/human/H = L
		H.forcesay(GLOB.hit_appends)


	return TRUE

/obj/item/melee/baton/proc/clowning_around(mob/living/user)
	user.visible_message("<span class='danger'>[user] accidentally hits себя with [src]!</span>", \
						"<span class='userdanger'>You accidentally hit yourself with [src]!</span>")
	SEND_SIGNAL(user, COMSIG_LIVING_MINOR_SHOCK)
	user.DefaultCombatKnockdown(stamina_loss_amount*6)
	playsound(loc, 'sound/weapons/egloves.ogg', 50, 1, -1)
	deductcharge(hitcost)

/obj/item/melee/baton/emp_act(severity)
	. = ..()
	if (!(. & EMP_PROTECT_SELF))
		switch_status(FALSE)
		if(!iscyborg(loc))
			deductcharge(severity*10, TRUE, FALSE)

/obj/item/melee/baton/can_give()
	if(turned_on)
		return FALSE
	else
		..()

/obj/item/melee/baton/stunsword
	name = "stunsword"
	desc = "Not actually sharp, this sword is functionally identical to its baton counterpart."
	icon_state = "stunsword"
	item_state = "sword"

/obj/item/melee/baton/stunsword/get_belt_overlay()
	if(istype(loc, /obj/item/storage/belt/sabre))
		return mutable_appearance('icons/obj/clothing/belt_overlays.dmi', "stunsword")
	return ..()

/obj/item/melee/baton/stunsword/get_worn_belt_overlay(icon_file)
	return mutable_appearance(icon_file, "-stunsword")

/obj/item/melee/baton/stunsword/on_exit_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/secbelt/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/unsheath.ogg', 25, 1)
	..()

/obj/item/melee/baton/stunsword/on_enter_storage(datum/component/storage/S)
	var/obj/item/storage/belt/sabre/secbelt/B = S.parent
	if(istype(B))
		playsound(B, 'sound/items/sheath.ogg', 25, 1)
	..()

/obj/item/ssword_kit
	name = "stunsword kit"
	desc = "a modkit for making a stunbaton into a stunsword"
	icon = 'icons/obj/vending_restock.dmi'
	icon_state = "refill_donksoft"
	var/product = /obj/item/melee/baton/stunsword //what it makes
	var/list/fromitem = list(/obj/item/melee/baton, /obj/item/melee/baton/loaded) //what it needs

/obj/item/ssword_kit/afterattack(obj/O, mob/user as mob)
	if(istype(O, product))
		to_chat(user,"<span class='warning'>[O] is already modified!")
		return
	if(O.type in fromitem) //makes sure O is the right thing
		var/obj/item/melee/baton/B = O
		if(!B.cell) //checks for a powercell in the baton. If there isn't one, continue. If there is, warn the user to take it out
			new product(usr.loc) //spawns the product
			user.visible_message("<span class='warning'>[user] modifies [O]!","<span class='warning'>You modify the [O]!")
			qdel(O) //Gets rid of the baton
			qdel(src) //gets rid of the kit
		else
			to_chat(user,"<span class='warning'>Remove the powercell first!</span>") //We make this check because the stunsword starts without a battery.
	else
		to_chat(user, "<span class='warning'> You can't modify [O] with this kit!</span>")

//Makeshift stun baton. Replacement for stun gloves.
/obj/item/melee/baton/cattleprod
	name = "stunprod"
	desc = "An improvised stun baton."
	icon_state = "stunprod_nocell"
	item_state = "prod"
	lefthand_file = 'icons/mob/inhands/weapons/melee_lefthand.dmi'
	righthand_file = 'icons/mob/inhands/weapons/melee_righthand.dmi'
	w_class = WEIGHT_CLASS_BULKY
	force = 3
	throwforce = 5
	stamina_loss_amount = 30
	armor_pen = 35
	hitcost = 1000
	throw_hit_chance = 10
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_BACK
	cooldown_duration = 7 SECONDS //It's a little on the weak side
	status_duration = 3 //Slows someone for a tiny bit
	var/obj/item/assembly/igniter/sparkler

/obj/item/melee/baton/cattleprod/Initialize(mapload)
	. = ..()
	sparkler = new (src)
	sparkler.activate_cooldown = 7 //Helps visualize the knockdown

/obj/item/melee/baton/cattleprod/baton_stun(mob/living/L, mob/living/carbon/user, shoving = FALSE)
	sparkler?.activate()
	. = ..()

/obj/item/melee/baton/boomerang
	name = "\improper OZtek Boomerang"
	desc = "A device invented in 2486 for the great Space Emu War by the confederacy of Australicus, these high-tech boomerangs also work exceptionally well at stunning crewmembers. Just be careful to catch it when thrown!"
	throw_speed = 1.5
	icon_state = "boomerang"
	item_state = "boomerang"
	force = 5
	throwforce = 5
	throw_range = 10
	hitcost = 2000
	throw_hit_chance = 99  //Have you prayed today?
	custom_materials = list(/datum/material/iron = 10000, /datum/material/glass = 4000, /datum/material/silver = 10000, /datum/material/gold = 2000)

/obj/item/melee/baton/boomerang/throw_at(atom/target, range, speed, mob/thrower, spin=1, diagonals_first = 0, datum/callback/callback, force, quickstart = TRUE)
	if(turned_on)
		if(ishuman(thrower))
			var/mob/living/carbon/human/H = thrower
			H.throw_mode_on() //so they can catch it on the return.
	return ..()

/obj/item/melee/baton/boomerang/throw_impact(atom/hit_atom, datum/thrownthing/throwingdatum)
	if(turned_on)
		var/caught = hit_atom.hitby(src, FALSE, FALSE, throwingdatum=throwingdatum)
		var/mob/thrown_by = thrownby?.resolve()
		if(ishuman(hit_atom) && !caught && prob(throw_hit_chance) && thrown_by)//if they are a carbon and they didn't catch it
			baton_stun(hit_atom, thrown_by, shoving = TRUE)
		if(thrownby && !caught)
			throw_back()
	else
		return ..()

/obj/item/melee/baton/boomerang/proc/throw_back()
	set waitfor = FALSE
	sleep(1)
	var/mob/thrown_by = thrownby?.resolve()
	if(!QDELETED(src))
		throw_at(thrown_by, throw_range+2, throw_speed, null, TRUE)

/obj/item/melee/baton/boomerang/update_icon()
	. = ..()
	if(turned_on)
		icon_state = "[initial(icon_state)]_active"
	else if(!cell)
		icon_state = "[initial(icon_state)]_nocell"
	else
		icon_state = "[initial(icon_state)]"

/obj/item/melee/baton/boomerang/loaded //Same as above, comes with a cell.
	preload_cell_type = /obj/item/stock_parts/cell/high

#undef STUNBATON_CHARGE_LENIENCY
#undef STUNBATON_DEPLETION_RATE
