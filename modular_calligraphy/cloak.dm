// /obj/item/clothing/neck/cloak
// 	name = "brown cloak"
// 	desc = "It's a cape that can be worn around your neck."
// 	icon = 'icons/obj/clothing/cloaks.dmi'
// 	icon_state = "qmcloak"
// 	inhand_icon_state = null
// 	w_class = WEIGHT_CLASS_SMALL
// 	body_parts_covered = CHEST|GROIN|LEGS|ARMS
// 	flags_inv = HIDESUITSTORAGE

// /obj/item/clothing/neck/cloak/hos
// 	name = "head of security's cloak"
// 	desc = "Worn by Securistan, ruling the station with an iron fist."

// /obj/item/clothing/neck/cloak/skill_reward/attack_hand(mob/user, list/modifiers)
// 	if (!check_wearable(user))
// 		unworthy_unequip(user)
// 	return ..()

/obj/item/clothing/neck/cloak/kanji
	name = "enchanted cloak"
	desc = "A cloak that can be enchanted to cast a spell on its wearer."
	icon = 'icons/obj/clothing/neck.dmi'
	icon_state = "infinity_scarf"
	w_class = WEIGHT_CLASS_NORMAL
	custom_price = PAYCHECK_CREW
	greyscale_colors = "#EEEEEE"
	greyscale_config = /datum/greyscale_config/infinity_scarf
	greyscale_config_worn = /datum/greyscale_config/infinity_scarf_worn
	var/datum/kanji_spell/kanji_spell
	var/spell_active = FALSE

/obj/item/clothing/neck/cloak/kanji/Initialize(mapload)
	. = ..()
	color = "#" + random_color()

/obj/item/clothing/neck/cloak/kanji/proc/try_set_spell(datum/kanji_spell/new_spell)
	if(!new_spell)
		to_chat(usr, span_warning("That inscription seems inert so you dont finish it."))
		return FALSE
	var/datum/kanji_spell/modification/toggleable/MT = new new_spell.type()
	if(istype(MT))
		kanji_spell = MT
		to_chat(usr, span_notice("You finish embedding the inscription into [src]."))
		return TRUE
	to_chat(usr, span_warning("That inscription doesn't resonate with the [src] so you dont finish it. Perhaps try it with a different tool."))
	return FALSE

/obj/item/clothing/neck/cloak/kanji/equipped(mob/user, slot)
	if(!kanji_spell)
		return
	if(slot & (ITEM_SLOT_HANDS | ITEM_SLOT_DEX_STORAGE))
		return
	var/datum/kanji_spell/modification/toggleable/MT = kanji_spell
	if(istype(MT))
		spell_active = MT.apply_modification(user, user, -1)
	return ..()

/obj/item/clothing/neck/cloak/kanji/dropped(mob/user)
	var/datum/kanji_spell/modification/toggleable/MT = kanji_spell
	if(istype(MT) && spell_active)
		MT.remove_modification(user)
		spell_active = FALSE
	return ..()

/obj/item/clothing/neck/cloak/kanji/ui_interact(mob/user, datum/tgui/ui)
	if(kanji_spell)
		return
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KanjiRecognizer")
		ui.open()

/obj/item/clothing/neck/cloak/kanji/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return
	switch(action)
		if("foundKanji")
			var/spell = GLOB.kanji_spells[params["kanji"]]
			if(!try_set_spell(spell))
				return FALSE
			ui.close()
			return TRUE

/obj/item/clothing/neck/cloak/kanji/examine()
	. = ..()
	if(kanji_spell)
		. += span_notice("It has <b>[kanji_spell.kanji]</b> woven on the back.")

/obj/item/clothing/neck/cloak/kanji/cursed
	name = "cursed cloak"
	desc = "A cloak that can be enchanted to cast a spell on its wearer. Hopefully a good spell since this cloak cannot be removed once its put on."

/obj/item/clothing/neck/cloak/kanji/cursed/equipped(mob/user, slot)
	. = ..()
	if(!kanji_spell)
		return
	if(slot & (ITEM_SLOT_HANDS | ITEM_SLOT_DEX_STORAGE))
		return
	ADD_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))

/obj/item/clothing/neck/cloak/kanji/cursed/dropped(mob/user)
	. = ..()
	REMOVE_TRAIT(src, TRAIT_NODROP, CURSED_ITEM_TRAIT(type))
