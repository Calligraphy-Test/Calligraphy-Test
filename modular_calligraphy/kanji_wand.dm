/obj/item/gun/magic/wand/kanji
	name = "wand of adequacy"
	desc = "A basic wand, capable of many basic things."
	w_class = WEIGHT_CLASS_NORMAL
	slot_flags = ITEM_SLOT_BELT | ITEM_SLOT_SUITSTORE
	//flags for enabling special spells
	var/limitation_flags = NONE
	school = SCHOOL_UNSET
	max_charges = 0
	variable_charges = FALSE
	var/kanji = null
	// Is it going to do a target location spell rather than a projectile
	var/datum/kanji_spell/target/special_cast = null
	// Passed to ui
	var/ui_theme = null
	var/ui_stroke_color = null
	vary_fire_sound = FALSE // Causes problems with burst fire or pellets(idk which) for some reason

/obj/item/gun/magic/wand/kanji/Initialize(mapload)
	. = ..()
	update_icon() // Wands start empty

// Run this after changing the kanji to update it's stats and recharge it
/obj/item/gun/magic/wand/kanji/proc/handle_new_kanji(var/new_kanji)
	var/datum/kanji_spell/spell = GLOB.kanji_spells[new_kanji]
	if(!spell)
		to_chat(usr, span_warning("The spell fizzles, this spell hasn't been fabricated by the fates yet."))
		return FALSE
	
	if((spell.limitation_flags & limitation_flags) != spell.limitation_flags)
		to_chat(usr, span_warning("The spell sparks, this spell may work with a different type of wand."))
		return FALSE

	var/succeded = FALSE
	// Projectiles
	var/datum/kanji_spell/projectile/projectile_spell = spell
	if(istype(projectile_spell))
		burst_size = projectile_spell.burst_fire
		special_cast = null
		qdel(chambered)
		ammo_type = projectile_spell.ammo_type
		chambered = new projectile_spell.ammo_type(src)
		succeded = TRUE
	// Targets
	var/datum/kanji_spell/target/target_spell = spell
	if(istype(target_spell))
		burst_size = 1
		special_cast = target_spell
		qdel(chambered)
		ammo_type = /obj/item/ammo_casing/magic/blank
		chambered = new /obj/item/ammo_casing/magic/blank(src)
		succeded = TRUE
	// Creations
	var/datum/kanji_spell/creation/creation_spell = spell
	if(istype(creation_spell))
		burst_size = 1
		special_cast = creation_spell
		qdel(chambered)
		ammo_type = /obj/item/ammo_casing/magic/blank
		chambered = new /obj/item/ammo_casing/magic/blank(src)
		succeded = TRUE
	// Reagents
	var/datum/kanji_spell/reagent/reagent_spell = spell
	if(istype(reagent_spell))
		burst_size = 1
		special_cast = reagent_spell
		qdel(chambered)
		ammo_type = /obj/item/ammo_casing/magic/blank
		chambered = new /obj/item/ammo_casing/magic/blank(src)
		succeded = TRUE

	// Handle all the non unique logic
	if(succeded)
		max_charges = creation_spell.charges
		charges = creation_spell.charges
		school = creation_spell.school
		fire_sound = creation_spell.cast_sound
		fire_delay = projectile_spell.cast_delay
	else
		to_chat(usr, span_warning("The spell sputters, this spell may work with a different tool."))
	
	return succeded

// Guns have weird behavior when shooting within 1 tile of the user so im using shoot_live_shot() instead of something else
/obj/item/gun/magic/wand/kanji/shoot_live_shot(mob/living/user, pointblank, atom/target, message)
	. = ..()
	if(special_cast)
		// Target
		var/datum/kanji_spell/target/T = special_cast
		if(istype(T))
			T.effect(target, user)
		// Creation
		var/datum/kanji_spell/creation/C = special_cast
		if(istype(C))
			var/atom/movable/M = C.make_creation(src, user)
			M.AddComponent(/datum/component/delete_distance, src)
			M.throw_at(get_turf(target), 7, 1, user)
		// Reagent
		var/datum/kanji_spell/reagent/R = special_cast
		if(istype(R))
			if(pointblank && target.reagents && !target.reagents.holder_full())
				R.add_reagents_to(target.reagents)
			else
				var/atom/movable/M = R.spawn_filled_container(src, user)
				M.throw_at(get_turf(target), 7, 1, user)

/obj/item/gun/magic/wand/kanji/zap_self(mob/living/user)
	charges--
	shoot_live_shot(user, TRUE, user, FALSE)
	return ..()
	
/obj/item/gun/magic/wand/kanji/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KanjiRecognizer")
		ui.open()

/obj/item/gun/magic/wand/kanji/ui_data(mob/user)
	var/list/data = list()
	data["theme"] = ui_theme
	data["strokeColor"] = ui_stroke_color
	data["quickKanji"] = kanji
	return data

/obj/item/gun/magic/wand/kanji/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return
	switch(action)
		if("foundKanji")
			// Penalty for using the same spell as last time
			if(kanji == params["kanji"])
				to_chat(usr, span_notice("You begin to recast the previous spell."))
				ui.close()
				if(!do_after(usr, 5 SECONDS))
					to_chat(usr, span_warning("You abandon attempting to recast the previous spell."))
					return FALSE
			// Checks if kanji is available for use and prepares spell if it is
			if(handle_new_kanji(params["kanji"]))
				kanji = params["kanji"]
				ui.close()
				update_icon()
				return TRUE
			return FALSE

/obj/item/gun/magic/wand/kanji/examine()
	. = ..()
	if(kanji)
		. += span_notice("It has <b>[kanji]</b> prepared for use.")

/obj/item/gun/magic/wand/kanji/blasting
	name = "rod of blasting"
	desc = "A versatile rod, for all your violent needs."
	w_class = WEIGHT_CLASS_BULKY
	limitation_flags = KANJI_SPELL_COMBAT
	icon_state = "firewand"
	base_icon_state = "firewand"

/obj/item/gun/magic/wand/kanji/mending
	name = "scepter of mending"
	desc = "A helpful scepter which can heal people in a pinch."
	limitation_flags = KANJI_SPELL_HEALING
	icon_state = "revivewand"
	base_icon_state = "revivewand"

/obj/item/gun/magic/wand/kanji/malice
	name = "wand of malice"
	desc = "A small malevolent wand recognized for its malicious uses. Small enough to hide in a bag."
	limitation_flags = KANJI_SPELL_COMBAT | KANJI_SPELL_HOSTILE_CREATURE
	icon_state = "deathwand"
	base_icon_state = "deathwand"

/obj/item/gun/magic/wand/kanji/debug
	name = "wand of debug"
	desc = "An unfortunate wand of unfortunate origins."
	limitation_flags = ALL

/obj/item/gun/magic/wand/kanji/debug/handle_new_kanji()
	. = ..()
	charges = INFINITY
