/obj/effect/decal/cleanable/kanji_rune
	name = "magic circle"
	desc = "A magic circle capable of basic conjuration."
	anchored = TRUE
	icon = 'icons/obj/rune.dmi'
	icon_state = "1"
	resistance_flags = FIRE_PROOF | UNACIDABLE | ACID_PROOF
	layer = SIGIL_LAYER
	var/original_color = COLOR_WHITE
	var/datum/kanji_spell/kanji_spell = null

/obj/effect/decal/cleanable/kanji_rune/Initialize()
	. = ..()
	icon_state = "[rand(1, 7)]"

/obj/effect/decal/cleanable/kanji_rune/proc/set_spell(datum/kanji_spell/new_spell)
	kanji_spell = new new_spell.type()

/obj/effect/decal/cleanable/kanji_rune/attack_hand(mob/living/user, list/modifiers)
	. = ..()
	activate(user)

/obj/effect/decal/cleanable/kanji_rune/proc/activate(mob/living/user)
	var/has_activated = FALSE

	// Creation
	var/datum/kanji_spell/creation/C = kanji_spell
	if(istype(C))
		var/atom/created = C.make_creation(src, user)
		created.AddComponent(/datum/component/delete_distance, user)
		visible_message(span_notice("[user] activates [src], creating [created]."), span_notice("You activate [src], creating [created]."))
		has_activated = TRUE
	
	// Modification
	var/datum/kanji_spell/modification/M = kanji_spell
	if(istype(M))
		var/turf/T = get_turf(src)
		for(var/potential_target in T)
			if(istype(potential_target, M.target_type))
				if(M.apply_modification(potential_target, user))
					visible_message(span_warning("[user] activates [src], affecting [potential_target]."), span_notice("You activate [src], affecting [potential_target]."))
					has_activated = TRUE
					break

	// Reagent
	var/datum/kanji_spell/reagent/R = kanji_spell
	if(istype(R))
		var/turf/T = get_turf(src)
		for(var/obj/item/potential_target in T)
			if(potential_target.reagents && !potential_target.reagents.holder_full())
				R.add_reagents_to(potential_target.reagents)
				visible_message(span_notice("[user] activates [src], filling [potential_target]."), span_notice("You activate [src], filling [potential_target]."))
				has_activated = TRUE
				break
		if(!has_activated)
			var/created = R.spawn_filled_container(src, user)
			visible_message(span_notice("[user] activates [src], creating [created]."), span_notice("You activate [src], creating [created]."))
			has_activated = TRUE
	
	// Target
	var/datum/kanji_spell/target/T = kanji_spell
	if(istype(T))
		T.effect(src, user)
		visible_message(span_notice("[user] activates [src]."), span_notice("You activate [src]."))
		has_activated = TRUE

	if(has_activated)
		activate_animation()
		if(--kanji_spell.charges <= 0)
			visible_message(span_warning("[src] disipates."))
			qdel(src)
	else
		visible_message(span_warning("[src]'s spell malfunctions and [src] disipates."))
		qdel(src)

/obj/effect/decal/cleanable/kanji_rune/attack_hand_secondary(mob/user, list/modifiers)
	visible_message(span_notice("[user] sweeps away [src] nullifying it."), span_notice("You sweep away [src], nullifying it."))
	qdel(src)

/obj/effect/decal/cleanable/kanji_rune/proc/activate_animation()
	// var/oldcolor = color
	color = rgb(0, 255, 255)
	animate(src, color = original_color, time = 5)

/obj/effect/decal/cleanable/kanji_rune/examine()
	. = ..()
	if(kanji_spell)
		. += span_notice("It has <b>[kanji_spell.kanji]</b> enscribed at the center.")

/obj/effect/decal/cleanable/kanji_rune/spray_paint
	name = "spray painted magic circle"
	desc = "A shoddy magic circle which unfortunately can activate when stepped on."

// on entered is actually defined in /obj/effect/decal/cleanable using /datum/element/connect_loc and COMSIG_ATOM_ENTERED
/obj/effect/decal/cleanable/kanji_rune/spray_paint/on_entered(datum/source, atom/movable/AM)
	if(isliving(AM))
		activate(AM)
	return ..()

/obj/effect/decal/cleanable/kanji_rune/spray_paint/attack_hand_secondary(mob/user, list/modifiers)
	to_chat(user, span_warning("You cannot sweep away [src] with your bare hand since it is made of spray paint!"))
