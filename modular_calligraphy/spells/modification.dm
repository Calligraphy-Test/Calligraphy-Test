/datum/kanji_spell/modification/color
	name = "Polymorph (Color)" // No, "Polymorph ([color_text])" doesnt work
	desc = "Colors something a random color, you could probably just wash it off..."
	kanji = "色"
	charges = 10
	target_type = /obj/item //it was targeting wires underneath tiles, TODO: dont do that
	var/possible_colors = list("#00aedb","#a200ff","#f47835","#d41243","#d11141","#00b159","#00aedb","#f37735","#ffc425","#008744","#0057e7","#d62d20","#ffa700")

/datum/kanji_spell/modification/color/apply_modification(var/atom/target, mob/living/user)
	target.add_atom_colour(pick(possible_colors), WASHABLE_COLOUR_PRIORITY)
	return ..()

/datum/kanji_spell/modification/color/red
	name = "Polymorph (Red)"
	desc = "Colors something red, you could probably just wash it off..."
	kanji = "赤"
	possible_colors = list(COLOR_RED, COLOR_DARK_RED, COLOR_RED_LIGHT, COLOR_MAROON, COLOR_VIVID_RED)

/datum/kanji_spell/modification/color/yellow
	name = "Polymorph (Yellow)"
	desc = "Colors something yellow, you could probably just wash it off..."
	kanji = "黄"
	possible_colors = list(COLOR_YELLOW, COLOR_VIVID_YELLOW)

/datum/kanji_spell/modification/color/blue
	name = "Polymorph (Blue)"
	desc = "Colors something blueish-green, you could probably just wash it off..."
	kanji = "青"
	possible_colors = list(COLOR_BLUE, COLOR_BLUE_LIGHT, COLOR_NAVY, COLOR_CYAN, COLOR_TEAL)

// I dont think people actually use this kanji often so its commented out for now to discourage people from caring about it
// /datum/kanji_spell/modification/color/orange
// 	kanji = "橙"
// 	color_text = "orange"
// 	possible_colors = list(COLOR_ORANGE, COLOR_DARK_ORANGE, COLOR_BRIGHT_ORANGE, COLOR_TAN_ORANGE)

/datum/kanji_spell/modification/color/green
	name = "Polymorph (Green)"
	desc = "Colors something green, you could probably just wash it off..."
	kanji = "緑"
	possible_colors = list(COLOR_GREEN, COLOR_LIME, COLOR_DARK_LIME)

/datum/kanji_spell/modification/color/purple
	name = "Polymorph (Purple)"
	desc = "Colors something purple, you could probably just wash it off..."
	kanji = "紫"
	possible_colors = list(COLOR_PURPLE, COLOR_VIOLET, COLOR_MAGENTA, COLOR_DARK_PURPLE)

// This was just removing colors
// /datum/kanji_spell/modification/color/white
// 	name = "Polymorph (White)"
// 	desc = "Colors something white, you could probably just wash it off..."
// 	kanji = "白"
// 	possible_colors = list(COLOR_WHITE)

/datum/kanji_spell/modification/color/black
	name = "Polymorph (Black)"
	desc = "Colors something black, you could probably just wash it off..."
	kanji = "黒"
	possible_colors = list(COLOR_BLACK)

/datum/kanji_spell/modification/revive
	name = "Resurrection"
	desc = "Revives and heals a creature after some time."
	kanji = "生"
	limitation_flags = KANJI_SPELL_HEALING
	filters = list(KANJI_FILTER_HEALING)
	school = SCHOOL_RESTORATION
	target_type = /mob/living
	var/time_till_revive = 30 SECONDS

/datum/kanji_spell/modification/revive/apply_modification(var/atom/target, mob/living/user)
	var/mob/living/L = target
	if(istype(L))
		var/atom/movable/bubble = new /obj/structure/revival_bubble(get_turf(L))
		if(!bubble.buckle_mob(L, TRUE))
			return FALSE
		addtimer(CALLBACK(bubble, TYPE_PROC_REF(/obj/structure/revival_bubble, revive_buckled)), time_till_revive)
	return ..()

/obj/structure/revival_bubble
	name = "ambrosia bubble"
	desc = "A bubble which will heal and eventually revive the being within if they are dead. If you dont want this to happen, you can simply pop the bubble."
	icon = 'icons/effects/effects.dmi'
	icon_state = "shield-yellow"
	anchored = TRUE
	layer = ABOVE_ALL_MOB_LAYER
	plane = ABOVE_GAME_PLANE

/obj/structure/revival_bubble/Initialize(mapload)
	. = ..()
	AddElement(/datum/element/movetype_handler)
	ADD_TRAIT(src, TRAIT_MOVE_FLOATING, INNATE_TRAIT)

/obj/structure/revival_bubble/attack_hand(mob/living/user, list/modifiers)
	visible_message(span_warning("[user] pops [src], dispelling it."), span_notice("You pop [src], dispelling it."))
	qdel(src)

/obj/structure/revival_bubble/proc/revive_buckled()
	buckled_mobs[1].revive(HEAL_DAMAGE | HEAL_BODY)
	visible_message(span_warning("[src] finishes up and pops."))
	qdel(src)

/datum/kanji_spell/modification/rewind
	name = "Return"
	desc = "Returns something to the casting location after a certain time."
	kanji = "帰"
	target_type = /mob/living

/datum/kanji_spell/modification/rewind/apply_modification(var/atom/target, mob/living/user)
	target.AddComponent(/datum/component/dejavu)
	return ..()

/datum/kanji_spell/modification/fear
	name = "Fear"
	desc = "Afflicts a living creature with fear."
	kanji = "怖" //恐い has the same pronunciation and meaning
	target_type = /mob/living

/datum/kanji_spell/modification/fear/apply_modification(var/atom/target, mob/living/user)
	var/mob/living/L = target
	if(istype(L))
		L.apply_status_effect(/datum/status_effect/terrified) //this status effect doesnt allow a duration
		return ..()
	return FALSE

/datum/kanji_spell/modification/toggleable/gender
	name = "Polymorph (Gender)"
	desc = "The elusive 'it' gender."
	target_type = /mob
	duration = 30 SECONDS
	var/gender = NEUTER //PLURAL is the 4th option
	// Used for removal of the spell
	var/original_gender
	var/original_physique

/datum/kanji_spell/modification/toggleable/gender/apply_modification(var/atom/target, mob/living/user)
	var/mob/M = target
	if(M.gender == gender)
		return FALSE
	original_gender = M.gender
	M.gender = gender
	var/mob/living/carbon/human/H = M
	if(istype(H))
		original_physique = H.physique
		H.physique = gender
		H.dna.update_ui_block(DNA_GENDER_BLOCK)
		H.update_body()
		H.updateappearance(mutcolor_update = TRUE)
	return ..()

/datum/kanji_spell/modification/toggleable/gender/remove_modification()
	var/mob/M = holder
	M.gender = original_gender
	var/mob/living/carbon/human/H = M
	if(istype(H))
		H.physique = original_physique
		H.dna.update_ui_block(DNA_GENDER_BLOCK)
		H.update_body()
		H.updateappearance(mutcolor_update = TRUE)
	return ..()

/datum/kanji_spell/modification/toggleable/gender/male
	name = "Polymorph (Male)"
	desc = "Turns a creature into a male."
	kanji = "男"
	gender = MALE

/datum/kanji_spell/modification/toggleable/gender/female
	name = "Polymorph (Female)"
	desc = "Turns a creature into a female."
	kanji = "女"
	gender = FEMALE

// /datum/status_effect/gender
// 	id = "silent"
// 	alert_type = null
// 	remove_on_fullheal = TRUE
// 	// Used for removal of the spell
// 	var/original_gender
// 	var/original_physique

// /datum/status_effect/gender/on_creation(mob/living/new_owner, duration = 10 SECONDS, gender)
// 	src.duration = duration
// 	. = ..()
// 	if(owner.gender == gender)
// 		return FALSE
// 	original_gender = owner.gender
// 	owner.gender = gender
// 	var/mob/living/carbon/human/H = owner
// 	if(istype(H))
// 		original_physique = H.physique
// 		H.physique = gender
// 		H.dna.update_ui_block(DNA_GENDER_BLOCK)
// 		H.update_body()
// 		H.update_mutations_overlay(mutcolor_update = TRUE)

// /datum/status_effect/gender/on_remove()
// 	owner.gender = original_gender
// 	var/mob/living/carbon/human/H = owner
// 	if(istype(H))
// 		H.physique = original_physique
// 		H.dna.update_ui_block(DNA_GENDER_BLOCK)
// 		H.update_body()
// 		H.update_mutations_overlay(mutcolor_update = TRUE)
// 	return ..()

/datum/kanji_spell/modification/toggleable/status_effect/stop
	name = "Hold Person"
	desc = "Holds a humanoid in place."
	kanji = "止"
	duration = 10 SECONDS
	status_effect = /datum/status_effect/incapacitating/immobilized

/datum/kanji_spell/modification/toggleable/status_effect/peace
	name = "Pacify"
	desc = "Prevents someone from commiting violent actions."
	kanji = "平"
	duration = 10 SECONDS
	status_effect = /datum/status_effect/pacify

/datum/kanji_spell/modification/toggleable/status_effect/quiet
	name = "Silence"
	desc = "Prevents a creature from speaking."
	kanji = "静" //黙
	duration = 30 SECONDS
	status_effect = /datum/status_effect/silenced

/datum/kanji_spell/modification/toggleable/status_effect/fast
	name = "Haste"
	desc = "Allows a creature to move faster."
	kanji = "早"
	duration = 5 SECONDS
	// status_effect = /datum/status_effect/speed_boost
	status_effect = /datum/status_effect/lightningorb

/datum/kanji_spell/modification/toggleable/status_effect/sleep
	name = "Sleep"
	desc = "Puts a creature to sleep for a time."
	kanji = "寝"
	duration = 5 SECONDS
	status_effect = /datum/status_effect/incapacitating/sleeping
