/obj/item/inscription_tool
	name = "chalk"
	desc = "A powdery white stick used for drawing magic circles."
	icon = 'icons/obj/art/crayons.dmi'
	icon_state = "crayonwhite"
	worn_icon_state = "crayon"
	w_class = WEIGHT_CLASS_TINY
	grind_results = list()
	var/limitation_flags = KANJI_SPELL_NOT_THROWABLE
	// Passed to ui
	var/ui_theme = null
	var/draw_color = COLOR_WHITE
	var/magic_circle = /obj/effect/decal/cleanable/kanji_rune

/obj/item/inscription_tool/proc/try_draw(var/datum/kanji_spell/spell)
	if(!spell)
		to_chat(usr, span_warning("This spell seems inert, it probably hasn't been fabricated by the fates yet. You choose not to finish the magic circle."))
		return FALSE
	
	if(!istype(spell, /datum/kanji_spell/creation) && !istype(spell, /datum/kanji_spell/modification) && !istype(spell, /datum/kanji_spell/target) && !istype(spell, /datum/kanji_spell/reagent))
		to_chat(usr, span_warning("This spell seems very weak, this is probably the wrong type of tool for this spell. You choose not to finish the magic circle."))
		return FALSE
	
	if((spell.limitation_flags & limitation_flags) != spell.limitation_flags)
		to_chat(usr, span_warning("This spell seems too strong, a better type of writing implement may work for this spell. You choose not to finish the magic circle."))
		return FALSE
	
	var/obj/effect/decal/cleanable/kanji_rune/rune = new magic_circle(get_turf(src))
	usr.visible_message(span_notice("[usr] draws [rune]."), span_notice("You draw [rune]."))
	rune.set_spell(spell)
	rune.color = draw_color
	rune.original_color = draw_color
	return TRUE

/obj/item/inscription_tool/ui_interact(mob/user, datum/tgui/ui)
	ui = SStgui.try_update_ui(user, src, ui)
	if(!ui)
		ui = new(user, src, "KanjiRecognizer")
		ui.open()

/obj/item/inscription_tool/ui_data(mob/user)
	var/list/data = list()
	data["theme"] = ui_theme
	data["strokeColor"] = draw_color
	return data

/obj/item/inscription_tool/ui_act(action, list/params, datum/tgui/ui)
	if(..())
		return
	switch(action)
		if("foundKanji")
			var/spell = GLOB.kanji_spells[params["kanji"]]
			if(!try_draw(spell))
				return FALSE
			ui.close()
			return TRUE

/obj/item/inscription_tool/plasma
	name = "plasma chalk"
	desc = "A chalk stick that had plasma dust mixed into it so that it can produce industry grade materials strong enough for construction."
	icon_state = "crayonpurple"
	worn_icon_state = "purple"
	limitation_flags = KANJI_SPELL_NOT_THROWABLE | KANJI_SPELL_BUILDING_MATERIALS
	draw_color = COLOR_PURPLE

/obj/item/inscription_tool/fairy
	name = "fairy chalk"
	desc = "A chalk stick that had fairy dust baked into it so that it can be used for healing spells. All fairy dust used for fairy chalk is ethically sourced according to the ads, but how does one even ethically source fairy dust in the first place?"
	icon_state = "crayonyellow"
	worn_icon_state = "yellow"
	limitation_flags = KANJI_SPELL_NOT_THROWABLE | KANJI_SPELL_HEALING
	draw_color = COLOR_YELLOW

/obj/item/inscription_tool/spray
	name = "infused spray paint"
	desc = "Illegal yet cheap spray paint that can be used to draw less safe magic circles."
	icon_state = "deathcan"
	worn_icon_state = "black"
	limitation_flags = KANJI_SPELL_NOT_THROWABLE | KANJI_SPELL_COMBAT | KANJI_SPELL_HOSTILE_CREATURE
	ui_theme = "ntos_darkmode" // TODO: make my own themes
	magic_circle = /obj/effect/decal/cleanable/kanji_rune/spray_paint

/obj/item/inscription_tool/spray/Initialize(mapload)
	. = ..()
	draw_color = rgb(rand(100, 200), rand(100, 200), rand(100, 200))
