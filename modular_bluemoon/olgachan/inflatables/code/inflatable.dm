//ВНИМАНИЕ!!! У ЭТИХ НАДУВНЫХ СИЛЬНО ПОРЕЗАН КОД ИЗ-ЗА ВЫЗОВА НЕАДЕКВАТНОГО КОЛИЧЕСТВА РАНТАЙМОВ!!! РЕКОМЕНДУЕТСЯ ИСПОЛЬЗОВАТЬ ИСКЛЮЧИТЕЛЬНО В КОСМЕТИЧЕСКИХ ЦЕЛЯХ


#define TAPE_REQUIRED_TO_FIX 2
#define INFLATABLE_DOOR_OPENED FALSE
#define INFLATABLE_DOOR_CLOSED TRUE
#define BOX_DOOR_AMOUNT 7
#define BOX_WALL_AMOUNT 14

/obj/structure/inflatable
	name = "inflatable wall"
	desc = "An inflated membrane. Do not puncture."
	anchored = TRUE
	max_integrity = 40
	icon = 'modular_bluemoon/olgachan/inflatables/icons/inflatable.dmi'
	icon_state = "wall"
	armor = list(MELEE = 0, BULLET =30, LASER = 20, ENERGY = 0, BOMB = 0, BIO = 0, RAD = 0, FIRE = 50, ACID = 50)
