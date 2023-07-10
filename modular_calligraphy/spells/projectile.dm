/// Blank shots shouldnt actually do anything but appear like the wand was used
/obj/item/ammo_casing/magic/blank
	projectile_type = /obj/projectile/magic/blank

/obj/projectile/magic/blank
	range = 0

/datum/kanji_spell/projectile/fire
	name = "Produce flame"
	desc = "Spews fire."
	kanji = "火"
	charges = 21
	burst_fire = 3
	cast_delay = 1
	limitation_flags = KANJI_SPELL_COMBAT
	cast_sound = 'sound/magic/fireball.ogg'
	ammo_type = /obj/item/ammo_casing/magic/flame

/obj/item/ammo_casing/magic/flame
	pellets = 3
	variance = 20
	randomspread = TRUE
	projectile_type = /obj/projectile/magic/flame

/obj/projectile/magic/flame
	name = "flame"
	damage = 5
	icon_state = "fireball"
	projectile_piercing = PASSMOB|PASSVEHICLE
	damage_type = BURN
	armor_flag = FIRE
	light_system = MOVABLE_LIGHT
	light_range = 2
	light_power = 1
	light_color = LIGHT_COLOR_FIRE

/obj/projectile/magic/flame/on_hit(atom/target, blocked = FALSE)
	. = ..()
	target.fire_act(700, 50)

/obj/projectile/magic/flame/Move()
	. = ..()
	var/turf/location = get_turf(src)
	if(location)
		location.hotspot_expose(700, 50, 1)

/datum/kanji_spell/projectile/ice
	name = "Ice spear"
	desc = "Flings a spear made of ice."
	kanji = "氷"
	charges = 6
	cast_delay = 1 SECONDS
	limitation_flags = KANJI_SPELL_COMBAT
	cast_sound = 'sound/weapons/plasma_cutter.ogg' // maybe 'sound/magic/blink.ogg'
	ammo_type = /obj/item/ammo_casing/magic/ice_spear

/obj/item/ammo_casing/magic/ice_spear
	projectile_type = /obj/projectile/magic/ice_spear

/obj/projectile/magic/ice_spear
	name = "ice spear"
	damage = 50
	icon_state = "ice_2"
	projectile_piercing = PASSVEHICLE

/obj/projectile/magic/ice_spear/Initialize(mapload)
	. = ..()
	particles = new /particles/ice_trail() // Particles immediately go away when deleted so maybe not the best way of doing this

/obj/projectile/magic/ice_spear/on_hit(atom/target, blocked = FALSE)
	. = ..()
	var/mob/living/carbon/C = target
	if(istype(C))
		C.adjust_bodytemperature(-200, 80)

/obj/projectile/magic/ice_spear/on_range()
	var/turf/T = get_turf(src)
	if(isopenturf(T))
		var/turf/open/O = T
		O.freeze_turf()
	return ..()

/particles/ice_trail
	icon = 'icons/effects/particles/generic.dmi'
	icon_state = list("dot"=1,"cross"=4,"curl"=1)
	width = 64
	height = 500
	count = 100
	spawning = 2
	lifespan = 1 SECONDS
	fade = 1 SECONDS
	color = 0
	color_change = 0.05
	gradient = list("#d2faff", "#4de7fb", "#00e1ff")
	velocity = generator(GEN_VECTOR, list(-2, -34), list(2, -30), UNIFORM_RAND)
	drift = generator(GEN_VECTOR, list(-0.1, -0.1), list(0.1, 0.1), UNIFORM_RAND)
	spin = generator(GEN_NUM, list(-15,15), NORMAL_RAND)
	scale = generator(GEN_VECTOR, list(0.5,0.5), list(2,2), NORMAL_RAND)
