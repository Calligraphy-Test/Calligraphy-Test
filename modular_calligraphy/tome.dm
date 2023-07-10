/obj/item/kanji_tome
	name = "tome of caligraphy"
	desc = "Book listing all available spells and basic information about them."
	icon = 'icons/obj/library.dmi'
	icon_state ="book"
	worn_icon_state = "book"
	throw_speed = 1
	throw_range = 5
	w_class = WEIGHT_CLASS_SMALL
	attack_verb_continuous = list("bashes", "whacks", "educates")
	attack_verb_simple = list("bash", "whack", "educate")
	resistance_flags = FLAMMABLE
	drop_sound = 'sound/items/handling/book_drop.ogg'
	pickup_sound = 'sound/items/handling/book_pickup.ogg'

/obj/item/kanji_tome/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KanjiPreview")
		ui.open()

/obj/item/kanji_tome/ui_data(mob/user)
	var/list/data = list()
	data["allFilters"] = KANJI_FILTER_ALL

	var/datum/kanji_spell/KS
	data["kanjiList"] = list()
	for(var/kanji in GLOB.kanji_spells)
		KS = GLOB.kanji_spells[kanji]
		// data["kanjiList"][KS.kanji] = "{\"name\": \"[KS.name]\", \"desc\": \"[KS.desc]\"}"
		data["kanjiList"][KS.kanji] = list()
		data["kanjiList"][KS.kanji]["name"] = KS.name
		data["kanjiList"][KS.kanji]["desc"] = KS.desc
		data["kanjiList"][KS.kanji]["filters"] = KS.filters
	
	return data
