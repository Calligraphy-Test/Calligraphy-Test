// List of all metadata spells which should be ignored when searching, does not blacklist child classes
#define FAKE_SPELL_BLACKLIST list(/datum/kanji_spell, /datum/kanji_spell/projectile, /datum/kanji_spell/creation, /datum/kanji_spell/target, /datum/kanji_spell/modification, /datum/kanji_spell/modification/toggleable, /datum/kanji_spell/modification/toggleable/gender, /datum/kanji_spell/modification/toggleable/status_effect, /datum/kanji_spell/reagent)

/// Initialises all /datum/kanji_spell into a list indexed by kanji
/proc/init_kanji_spells_list()
	var/list/kanji_list = list()

	var/paths = subtypesof(/datum/kanji_spell)

	for(var/path in paths)
		if(path in FAKE_SPELL_BLACKLIST)
			continue
		var/datum/kanji_spell/spell = new path()
		kanji_list[spell.kanji] = spell

	return kanji_list

/// Spell with kanji and it's data
/datum/kanji_spell
	var/name = "null spell"
	var/desc = "A base class for spells, if you see this please report it to an authority."
	var/kanji = ""
	var/charges = 1
	var/school = SCHOOL_UNSET
	var/limitation_flags = 0
	/// Time delay between casts in deciseconds, click delay restricts you to 4 minimum (at least for guns I think)
	var/cast_delay = 0
	var/cast_sound = 'sound/weapons/emitter.ogg'
	/// Used in KanjiPreview.js to search based on keywords
	var/list/filters = list()

/datum/kanji_spell/projectile
	school = SCHOOL_EVOCATION
	var/obj/item/ammo_casing/ammo_type = /obj/item/ammo_casing/magic/nothing
	/// Burstfire for the spell, if you have one you must also set a cast_delay
	var/burst_fire = 1
	filters = list(KANJI_FILTER_COMBAT)

/datum/kanji_spell/creation
	school = SCHOOL_CONJURATION
	var/atom/creation

// Creates the item at the target location and returns the new atom
/datum/kanji_spell/creation/proc/make_creation(target, mob/living/user)
	var/created_thing
	if(islist(creation))
		var/picked = pick_weight(fill_with_ones(creation))
		created_thing = new picked(get_turf(target))
	else
		created_thing = new creation(get_turf(target))

	// I would set created_thing to have a sell value of 0 but thats handled in /datum/export so I cant
	// best solution is to just delete the item if it gets too far away from the caster maybe
	return created_thing

/datum/kanji_spell/target
	school = SCHOOL_EVOCATION
	/// Effect that spawns before the cast delay
	var/warning_effect
	/// Effect that spawns after the cast delay
	var/effect
	/// Effect that spawns before the cast delay in an area
	var/aoe_effect
	/// Size of the area aoe_effect is spawned in, in the shape of a square
	var/aoe_range = 1
	/// Delay till the effect is spawned
	var/effect_delay = 0

/datum/kanji_spell/target/proc/effect(target, mob/living/user)
	var/turf/target_turf = get_turf(target)
	if(warning_effect)
		new warning_effect(target_turf)
	addtimer(CALLBACK(src, TYPE_PROC_REF(/datum/kanji_spell/target, after_delay), target, target_turf, user), effect_delay)

/datum/kanji_spell/target/proc/after_delay(target, turf/original_turf, mob/living/user)
	on_hit(target, user)
	if(effect)
		new effect(original_turf)
	for(var/turf/T in RANGE_TURFS(aoe_range, original_turf))
		on_aoe(T, user)
		if(aoe_effect)
			new aoe_effect(T)

/// affects the atom that was clicked after the effect_delay even if the atom moved
/datum/kanji_spell/target/proc/on_hit(target, mob/living/user)
	return

/// affects the tiles in a square area around the click with a radius of aoe_range
/datum/kanji_spell/target/proc/on_aoe(turf/aoe_turf, mob/living/user)
	return

/// Requires a target atom and modifies it somehow
/datum/kanji_spell/modification
	school = SCHOOL_TRANSMUTATION
	// Used for fitering suitable targets out
	var/target_type = /atom

/// Returns FALSE for failure or ..() (TRUE) for success
/datum/kanji_spell/modification/proc/apply_modification(atom/target, mob/living/user)
	return TRUE

/// Keeps track of a modification that can be reversed, instanciate this
/datum/kanji_spell/modification/toggleable
	//the atom that has the modification applied
	var/atom/holder
	// Remove after the duration if a duration is set, -1 for infinite
	var/duration = -1

/// Sets the time, -1 for infinite
/datum/kanji_spell/modification/toggleable/proc/set_duration(new_duration)
	if(new_duration == -1)
		STOP_PROCESSING(SSprocessing, src)
	else
		START_PROCESSING(SSprocessing, src)
	duration = world.time + new_duration

/datum/kanji_spell/modification/toggleable/apply_modification(atom/target, mob/living/user, override_duration)
	holder = target
	set_duration(override_duration ? override_duration : duration)
	return ..()

/// Undos the effect caused by apply_modification(), you should always implement this if you're making a new /toggleable, return FALSE for failure or ..() (TRUE) for success 
/datum/kanji_spell/modification/toggleable/proc/remove_modification()
	qdel(src)
	return TRUE

/datum/kanji_spell/modification/toggleable/process(seconds_per_tick, times_fired)
	SHOULD_NOT_OVERRIDE(TRUE)
	if(QDELETED(holder))
		qdel(src)
		return
	if(duration != -1 && duration < world.time)
		remove_modification()

/datum/kanji_spell/modification/toggleable/Destroy()
	STOP_PROCESSING(SSprocessing, src)
	if(holder)
		holder = null
	return ..()

// maybe all toggleables should be wrapped in a status effect, but im doing it like this to support the possibility of /datum/kanji_spell/modification/toggleable/component
/datum/kanji_spell/modification/toggleable/status_effect
	target_type = /mob/living
	var/datum/status_effect/status_effect

/datum/kanji_spell/modification/toggleable/status_effect/apply_modification(atom/target, mob/living/user)
	var/mob/living/L = target
	if(istype(L))
		L.apply_status_effect(status_effect, duration)
		return ..()
	return FALSE

/datum/kanji_spell/modification/toggleable/status_effect/remove_modification(atom/target, mob/living/user)
	var/mob/living/L = target
	if(istype(L))
		L.remove_status_effect(status_effect)
		return ..()

/datum/kanji_spell/reagent
	school = SCHOOL_CONJURATION
	/// Type of the reagent to spawn
	var/datum/reagent/reagent
	/// Units of the reagent that should spawn
	var/reagent_ammount = 15
	/// Container to use if we are asked to spawn the reagent in one
	var/atom/default_container = /obj/item/reagent_containers/cup/glass/bottle/kanji

/datum/kanji_spell/reagent/proc/add_reagents_to(datum/reagents/target)
	target.add_reagent(reagent, reagent_ammount)

/datum/kanji_spell/reagent/proc/spawn_filled_container(target, mob/living/user)
	var/atom/container = new default_container(get_turf(target))
	container.reagents.add_reagent(reagent, reagent_ammount)
	return container

/obj/item/reagent_containers/cup/glass/bottle/kanji
	name = "magic bottle"
	desc = "A magic bottle with the weight of a feather, its not as good of a weapon as a normal bottle so don't get any funny ideas."
	fill_icon_thresholds = list(0, 10, 20, 30, 40, 50, 60, 70, 80, 90)
	amount_per_transfer_from_this = 10
	volume = 100
	force = 0
	throwforce = 0
	bottle_knockdown_duration = 0
	drink_type = NONE
