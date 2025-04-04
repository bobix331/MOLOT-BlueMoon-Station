/obj/item/seeds/herbs
	name = "herb seed pack"
	desc = "These seeds grow to produce an assortment of herbs and seasonings."
	icon = 'modular_bluemoon/icons/obj/hydroponics/seeds.dmi'
	icon_state = "seed-herbs"
	species = "herbs"
	plantname = "Herbs"
	product = /obj/item/reagent_containers/food/snacks/grown/herbs
	yield = 5
	potency = 20
	growthstages = 2
	growing_icon = 'modular_bluemoon/icons/obj/hydroponics/growing.dmi'
	icon_grow = "herbs-grow"
	icon_dead = "herbs-dead"
	genes = list(/datum/plant_gene/trait/repeated_harvest)
	reagents_add = list(/datum/reagent/consumable/nutriment/vitamin = 0.04, /datum/reagent/consumable/nutriment = 0.1)

/obj/item/reagent_containers/food/snacks/grown/herbs
	seed = /obj/item/seeds/herbs
	name = "bundle of herbs"
	desc = "A bundle of various herbs. Somehow, you're always able to pick what you need out."
	icon_state = "herbs"
	foodtype = VEGETABLES
	grind_results = list(/datum/reagent/consumable/nutriment = 0)
	juice_results = list(/datum/reagent/consumable/nutriment = 0)
	tastes = list("nondescript herbs" = 1)
	distill_reagent = /datum/reagent/consumable/ethanol/fernet
