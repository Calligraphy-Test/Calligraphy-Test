/obj/effect/temp_visual/blip
	icon_state = "blip"
	duration = 6

/datum/kanji_spell/target/meteor
	name = "Meteor Strike"
	desc = "Attracts a meteor from above to a target location."
	kanji = "天"
	charges = 7
	limitation_flags = KANJI_SPELL_COMBAT
	filters = list(KANJI_FILTER_COMBAT)
	cast_sound = 'sound/magic/fleshtostone.ogg'
	warning_effect = /obj/effect/temp_visual/fireball // If you want to do something other than effect_delay = 9, make a new subclass
	aoe_effect = /obj/effect/hotspot
	effect_delay = 9
	var/aoe_damage = 40

/datum/kanji_spell/target/meteor/on_aoe(turf/aoe_turf, mob/living/user)
	for(var/mob/living/L in aoe_turf)
		L.adjustFireLoss(aoe_damage)

/datum/kanji_spell/target/meteor/after_delay(target, turf/original_turf, mob/living/user)
	. = ..()
	playsound(original_turf, SFX_EXPLOSION, 80, TRUE)

/datum/kanji_spell/target/healing
	name = "Healing Circle"
	desc = "Heals creatures in a small area after some time."
	kanji = "治"
	charges = 5
	limitation_flags = KANJI_SPELL_HEALING
	filters = list(KANJI_FILTER_HEALING)
	school = SCHOOL_RESTORATION
	cast_sound = 'sound/magic/staff_healing.ogg'
	cast_delay = 1 SECONDS
	effect_delay = 1 SECONDS
	var/healing_ammount = 12
	warning_effect = /obj/effect/temp_visual/blip/yellow
	aoe_effect = /obj/effect/temp_visual/healing_circle

/datum/kanji_spell/target/healing/on_aoe(turf/aoe_turf, mob/living/user)
	for(var/mob/living/L in aoe_turf)
		L.adjustToxLoss(-healing_ammount, FALSE)
		L.adjustOxyLoss(-healing_ammount, FALSE)
		L.adjustFireLoss(-healing_ammount, FALSE)
		L.adjustBruteLoss(-healing_ammount, FALSE)
		L.updatehealth()

/obj/effect/temp_visual/blip/yellow
	color = COLOR_YELLOW

/obj/effect/temp_visual/healing_circle
	icon_state = "blessed"
	duration = 6

/datum/kanji_spell/target/water
	name = "Extinguish"
	desc = "Splashes water at a target location."
	kanji = "消"
	charges = 7
	cast_sound = 'sound/effects/extinguish.ogg'
	aoe_effect = /obj/effect/particle_effect/water/kanji

/obj/effect/particle_effect/water/kanji

/obj/effect/particle_effect/water/kanji/Initialize(mapload)
	. = ..()
	
	reagents = new /datum/reagents(5)
	reagents.add_reagent(/datum/reagent/water, 5)
	
	// reagents.expose(get_turf(src)) // Causes slippery tiles
	for(var/atom/thing as anything in get_turf(src))
		reagents.expose(thing)

/datum/kanji_spell/target/snow
	name = "Snow"
	desc = "Casues light snowfall at the target location."
	kanji = "雪"
	charges = 7
	limitation_flags = KANJI_SPELL_COMBAT
	cast_sound = null
	aoe_effect = /obj/effect/temp_visual/snow

/obj/effect/temp_visual/snow
	icon = 'icons/effects/weather_effects.dmi'
	icon_state = "light_snow"
//	icon_state2 = "snow_storm"
	name = "snow fall"
	desc = "Is it getting colder in here?"
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE
	randomdir = FALSE
	duration = 5 SECONDS

/obj/effect/temp_visual/snow/Initialize(mapload)
	START_PROCESSING(SSprocessing, src)
	return ..()

/obj/effect/temp_visual/snow/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	return ..()

/obj/effect/temp_visual/snow/process()
	for(var/atom/thing in get_turf(src))
		thing.extinguish() // Only affects items
	for(var/mob/living/L in get_turf(src))
		L.extinguish_mob()
		var/mob/living/carbon/C = L
		if(istype(C))
			C.adjust_bodytemperature(-80, 80)

/datum/kanji_spell/target/pull
	name = "Pull"
	desc = "Attracts an object towards the user."
	kanji = "引"
	charges = 5
	school = SCHOOL_TRANSLOCATION
	cast_sound = null

/datum/kanji_spell/target/pull/on_hit(var/target, mob/living/user)
	var/atom/movable/AM = target
	if(istype(AM) && !AM.anchored && !ismob(AM))
		AM.throw_at(get_turf(user), 5, 1, user)

/datum/kanji_spell/target/smoke
	name = "Smoke Screen"
	desc = "Floods the area with smoke."
	kanji = "吸"
	charges = 2
	cast_sound = 'sound/effects/smoke.ogg'

// /datum/kanji_spell/target/cloud
// 	name = "Fog Cloud"
// 	desc = "Forms a fog cloud at the target location."
// 	kanji = "雲" // 曇 seems more common but 雲 is less strokes
// 	charges = 2
// 	cast_sound = 'sound/effects/smoke.ogg'

/datum/kanji_spell/target/smoke/on_hit(var/target, mob/living/user)
	var/datum/effect_system/fluid_spread/smoke/smoke = new
	smoke.set_up(2, holder = target, location = target)
	smoke.start()
	qdel(smoke)
