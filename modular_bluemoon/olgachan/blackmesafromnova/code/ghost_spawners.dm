/obj/effect/mob_spawn/human/black_mesa
	name = "Black mesa scientist"
	icon = 'icons/obj/machines/sleeper.dmi'
	icon_state = "sleeper_s"
	density = TRUE
	roundstart = FALSE
	death = FALSE
	outfit = /datum/outfit/science_team
	short_desc = "Ты являешься одним из немногих выживших после инцидента в чёрной мезе"
	flavour_text = "Ты старший научный научный сотрудник сектора H. Недавно тебя повысили в должности, перенаправив в этот сектор, но что-то пошло не так. Исходя из оповещений BMAS, По всему сектору начались портальные штормы. По этому вы, засев в одном из кабинетов, ждёте помощи."
	important_info = "Не пытайся исследовать комплекс до прибытия экспедиционной группы. В случае, когда прошло 20 минут от начала раунда, а исследователи так и не пришли, ты можешь постепенно продвигаться по комплексу."
/obj/effect/mob_spawn/human/black_mesa/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.remove_language(/datum/language/common)

/datum/outfit/science_team
	name = "science team member"

	uniform = /obj/item/clothing/under/rank/rnd/scientist/halflife
	suit = /obj/item/clothing/suit/toggle/labcoat
	shoes = /obj/item/clothing/shoes/laceup
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio, /obj/item/reagent_containers/glass/beaker)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/science_team

/datum/id_trim/science_team
	assignment = "Учёный Чёрной Мезы"
	trim_state = "trim_scientist"

/obj/effect/mob_spawn/human/black_mesa/guard
	name = "Black mesa guard"
	outfit = /datum/outfit/security_guard
	short_desc = "Ты являешься выжившим охранником чёрной мезы"
	flavour_text = "Ты один из охранников Чёрной Мезы, а конкретно Сектора H. Твоя работа была размеренной и спокойной, но что-то пошло не так. Теперь ты, оставшись со своим напарником, лежишь без сознания в чудом уцелевшем КПП охраны"
/obj/effect/mob_spawn/human/black_mesa/guard/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.remove_language(/datum/language/common)

/datum/outfit/security_guard
	name = "Black mesa guard"
	uniform = /obj/item/clothing/under/rank/security/officer/peacekeeper
	head = /obj/item/clothing/head/helmet/blueshirt
	gloves = /obj/item/clothing/gloves/color/black
	suit = /obj/item/clothing/suit/armor/vest/blueshirt
	shoes = /obj/item/clothing/shoes/jackboots
	back = /obj/item/storage/backpack
	backpack_contents = list(/obj/item/radio, /obj/item/gun/ballistic/automatic/pistol/hl9mm, /obj/item/ammo_box/magazine/pistolm9mm, /obj/item/reagent_containers/food/snacks/donut/apple,)
	id = /obj/item/card/id
	id_trim = /datum/id_trim/security_guard

/datum/id_trim/security_guard
	assignment = "Охранник Чёрной Мезы"
	access = list(ACCESS_BRIG, ACCESS_SECURITY, ACCESS_AWAY_SEC)

/obj/item/clothing/under/rank/rnd/scientist/halflife
	name = "science team costume"
	desc = "Самый обычный костюм работника комплекса чёрной мезы"
	icon = 'modular_bluemoon/olgachan/blackmesafromnova/icons/gear/rnd.dmi'
	mob_overlay_icon = 'modular_bluemoon/olgachan/blackmesafromnova/icons/gear/rndmob.dmi'
	anthro_mob_worn_overlay = 'modular_bluemoon/olgachan/blackmesafromnova/icons/gear/rnd_digi.dmi'
	icon_state = "hl_scientist"
	item_state = "hl_scientist"
	can_adjust = FALSE


/obj/effect/mob_spawn/human/black_mesa/hecu
	name = "HECU grunt"
	outfit = /datum/outfit/hecu
	short_desc = "Ты являешься, скорее всего, одним из немногих обычных пехотинцев, оставшихся в секторе H без какой либо поддержки со стороны правительства."
	flavour_text = "Ваш отряд был направлен в Чёрную Мезу для оказания медицинской, инженерной и боевой помощи основным отрядам HECU. Но, к сожалению, с каждым часом ситуация становилась всё хуже. Ведь правительство, поняв, что посланные пехотинцы не справляются, решили их всех предательски убить. Всё, что вы смутно знаете о миссии, так это только то, что основная задача отрядов, которым вы помогали - устранять всех свидетелей? Но имеет ли это вес, когда вас бросили? Теперь ваша задача сейчас - окопаться в этом клятом лагере и или ждать помощи, или попытаться следовать приказу основных отрядов."
	important_info = "Не пытайтесь исследовать карту далее основного атриума и небольшого медицинского отдела ( не ломайте стены в комнату, закрытой ключ картой). Вы можете покинуть гейт ТОЛЬКО В ТОМ СЛУЧАЕ, когда договоритесь с исследовательской командой. Если вы решили враждовать с исследователями, то вам после этого запрещено покидать гейт."
/obj/effect/mob_spawn/human/black_mesa/hecu/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.remove_language(/datum/language/common)

/obj/effect/mob_spawn/human/black_mesa/hecu/breacher
	name = "HECU breacher"
	outfit = /datum/outfit/hecu_breacher

/obj/effect/mob_spawn/human/black_mesa/hecu/medic
	name = "HECU field medic"
	outfit = /datum/outfit/hecu_medic
	short_desc = "Ты являешься профессиональным полевым медиком небольшого отряда поддержки HECU."

/obj/effect/mob_spawn/human/black_mesa/hecu/engineer
	name = "HECU engineer"
	outfit = /datum/outfit/hecu_engineer
	short_desc = "Ты являешься профессиональным инженером небольшого отряда поддержки HECU."
/obj/effect/mob_spawn/human/black_mesa/hecu/special(mob/living/carbon/human/spawned_human)
	. = ..()
	spawned_human.remove_language(/datum/language/common)

/datum/outfit/hecu
	name = "HECU grunt"

	uniform = /obj/item/clothing/under/rank/security/officer/urban_camo
	mask = /obj/item/clothing/mask/gas/hecu
	head = /obj/item/clothing/head/helmet/hecu
	suit = /obj/item/clothing/suit/armor/hecu
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/assault/hecu
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/reagent_containers/food/drinks/flask
	r_pocket = /obj/item/flashlight/flare
	r_hand = /obj/item/gun/ballistic/automatic/mp5
	back = /obj/item/storage/backpack/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/firstaid/emergency,
		/obj/item/kitchen/knife/combat,
		/obj/item/ammo_box/magazine/mp5,
	)

/datum/outfit/hecu_engineer
	name = "HECU engineer"

	uniform = /obj/item/clothing/under/rank/security/officer/urban_camo
	glasses = /obj/item/clothing/glasses/welding/hecu
	head = /obj/item/clothing/head/helmet/hecu
	suit = /obj/item/clothing/suit/armor/hecu
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/utility/chief/full
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/reagent_containers/food/drinks/flask
	r_pocket = /obj/item/flashlight/flare
	r_hand = /obj/item/gun/ballistic/automatic/mp5
	back = /obj/item/storage/backpack/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/firstaid/emergency,
		/obj/item/kitchen/knife/combat,
		/obj/item/lighter/donator/bm/militaryzippo,
		/obj/item/storage/fancy/cigarettes/cigpack_robust,
		/obj/item/gun/ballistic/automatic/pistol/hl9mm,
		/obj/item/ammo_box/magazine/pistolm9mm,
		/obj/item/ammo_box/magazine/pistolm9mm,
		/obj/item/ammo_box/magazine/mp5,
	)

/datum/outfit/hecu_breacher
	name = "HECU breacher"

	uniform = /obj/item/clothing/under/rank/security/officer/urban_camo
	mask = /obj/item/clothing/mask/balaclava
	glasses = /obj/item/clothing/glasses/hud/security/hecu_ski
	suit = /obj/item/clothing/suit/armor/hecu
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/bandolier
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/reagent_containers/food/drinks/flask
	r_pocket = /obj/item/flashlight/flare
	r_hand = /obj/item/gun/ballistic/shotgun/spas
	back = /obj/item/storage/backpack/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/firstaid/emergency,
		/obj/item/kitchen/knife/combat,
		/obj/item/gun/ballistic/automatic/pistol/hl9mm,
		/obj/item/ammo_box/magazine/pistolm9mm,
		/obj/item/ammo_box/shotgun/loaded/buckshot,
	)

/datum/outfit/hecu_medic
	name = "HECU medic"

	uniform = /obj/item/clothing/under/rank/security/officer/urban_camo
	glasses = /obj/item/clothing/glasses/hud/health/sunglasses/hecu
	head = /obj/item/clothing/head/helmet/hecu
	suit = /obj/item/clothing/suit/armor/hecu
	gloves = /obj/item/clothing/gloves/combat
	belt = /obj/item/storage/belt/military/assault/hecu
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/reagent_containers/food/drinks/flask
	r_pocket = /obj/item/flashlight/flare
	back = /obj/item/storage/backpack/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/firstaid/emergency,
		/obj/item/kitchen/knife/combat,
		/obj/item/storage/firstaid/tactical,
		/obj/item/gun/ballistic/automatic/pistol/hl9mm,
		/obj/item/ammo_box/magazine/pistolm9mm,
		/obj/item/ammo_box/magazine/pistolm9mm,
	)

/obj/effect/mob_spawn/human/black_mesa/hecu/leader
	name = "HECU squad leader"
	outfit = /datum/outfit/hecu_leader
	short_desc = "Ты являешься лидером неболього отряда поддержки HECU"

/datum/outfit/hecu_leader
	name = "HECU squad leader"

	uniform = /obj/item/clothing/under/rank/security/officer/urban_camo
	head = /obj/item/clothing/head/beret/sec
	suit = /obj/item/clothing/suit/armor/hecu
	gloves = /obj/item/clothing/gloves/tackler/combat/insulated
	belt = /obj/item/storage/belt/military/assault/hecu
	shoes = /obj/item/clothing/shoes/combat
	l_pocket = /obj/item/grenade/smokebomb
	r_pocket = /obj/item/binoculars
	r_hand = /obj/item/gun/ballistic/automatic/mp5
	back = /obj/item/storage/backpack/hecu
	backpack_contents = list(
		/obj/item/storage/box/survival/radio,
		/obj/item/storage/firstaid/emergency,
		/obj/item/kitchen/knife/combat,
		/obj/item/book/granter/martial/cqc,
		/obj/item/gun/ballistic/automatic/pistol/deagle,
		/obj/item/ammo_box/magazine/m50,
	)
