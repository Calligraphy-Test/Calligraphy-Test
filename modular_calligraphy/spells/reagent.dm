/datum/kanji_spell/reagent/water
	name = "Pour water"
	desc = "Produces drinkable water."
	kanji = "水"
	charges = 7
	reagent = /datum/reagent/water

/datum/kanji_spell/reagent/sugar
	name = "Pour sugar"
	desc = "Produces drinkable sugar."
	kanji = "甘" //糖 is for sugar, we use 甘 since its simpler
	charges = 7
	reagent = /datum/reagent/consumable/sugar

/datum/kanji_spell/reagent/oil
	name = "Pour oil"
	desc = "Produces cooking oil."
	kanji = "油"
	charges = 7
	reagent = /datum/reagent/consumable/cooking_oil // maybe do /datum/reagent/fuel/oil but cooking oil has more uses iirc

/datum/kanji_spell/reagent/capsaicin
	name = "Pour hot sauce"
	desc = "Produces hot sauce which will surely be used for food."
	kanji = "辛"
	charges = 7
	reagent = /datum/reagent/consumable/capsaicin // maybe use /datum/reagent/consumable/condensedcapsaicin

/datum/kanji_spell/reagent/chilly
	name = "Pour frost oil"
	desc = "Produces the chilly sauce that comes from a chili."
	kanji = "冷"
	charges = 7
	reagent = /datum/reagent/consumable/frostoil

/datum/kanji_spell/reagent/salt
	name = "Pour salt"
	desc = "Produces common table salt."
	kanji = "塩"
	charges = 7
	reagent = /datum/reagent/consumable/salt

/datum/kanji_spell/reagent/alcohol
	name = "Pour alcohol"
	desc = "Produces a nice alcohol."
	kanji = "酒"
	charges = 7
	reagent = /datum/reagent/consumable/ethanol/sake // maybe do random alchohol types instead

/datum/kanji_spell/reagent/soy_sauce
	name = "Pour soy sauce"
	desc = "Produces low sodium soy sauce."
	kanji = "醤" // no ones going to use this since its too hard to write, also soy sauce is 醤油 or "a kind of miso oil"
	charges = 7
	reagent = /datum/reagent/consumable/soysauce

/datum/kanji_spell/reagent/tea
	name = "Pour tea"
	desc = "Produces warm tea."
	kanji = "茶"
	charges = 7
	reagent = /datum/reagent/consumable/tea

/datum/kanji_spell/reagent/milk
	name = "Pour milk"
	desc = "Produces a milk based food product."
	kanji = "乳"
	charges = 7
	reagent = /datum/reagent/consumable/milk

/datum/kanji_spell/reagent/honey
	name = "Pour honey"
	desc = "Produces organic, gmo free honey with only a few magical additives."
	kanji = "蜜"
	charges = 7
	reagent = /datum/reagent/consumable/honey

/datum/kanji_spell/reagent/vinegar
	name = "Pour vinegar"
	desc = "Produces vinegar."
	kanji = "酢"
	charges = 7
	reagent = /datum/reagent/consumable/vinegar

/datum/kanji_spell/reagent/tears
	name = "Pour tears"
	desc = "Cry me a river."
	kanji = "泣"
	charges = 7
	reagent = /datum/reagent/consumable/tearjuice

/datum/kanji_spell/reagent/flour
	name = "Pour flour"
	desc = "Produces all purpose flour."
	kanji = "粉"
	charges = 7
	reagent = /datum/reagent/consumable/flour

// Currently exists in creation/items.dm
// /datum/kanji_spell/reagent/rice
// 	name = "Pour rice"
// 	desc = "Produces short grain rice."
// 	kanji = "米"
// 	charges = 7
// 	reagent = /datum/reagent/consumable/rice

/datum/kanji_spell/reagent/noodles
	name = "Pour noodles"
	desc = "Produces cooked ramen."
	kanji = "麺"
	charges = 7
	reagent = /datum/reagent/consumable/hot_ramen

/datum/kanji_spell/reagent/blood
	name = "Pour blood"
	desc = "Produces blood."
	kanji = "血"
	charges = 7
	reagent = /datum/reagent/blood // blood type gets passed in as data in add_reagent() so idk if this is usable for people

/datum/kanji_spell/reagent/saltpeter
	name = "Pour saltpeter"
	desc = "Produces nitrate."
	kanji = "硝"
	charges = 7
	reagent = /datum/reagent/saltpetre

/datum/kanji_spell/reagent/sulfur
	name = "Pour sulfur"
	desc = "Produces brimstone."
	kanji = "硫"
	charges = 7
	reagent = /datum/reagent/sulfur

/datum/kanji_spell/reagent/lead
	name = "Pour lead"
	desc = "Produces a fine lead powder."
	kanji = "鉛"
	charges = 7
	reagent = /datum/reagent/lead

/datum/kanji_spell/reagent/acid
	name = "Pour acid"
	desc = "Produces sulfuic acid."
	kanji = "酸"
	charges = 7
	reagent = /datum/reagent/toxin/acid

/datum/kanji_spell/reagent/confetti
	name = "Pour confetti"
	desc = "Produces confetti."
	kanji = "丶" // confetti is actually 紙吹雪 or "paper puff snow" and 丶 isnt even a word but im using it since 1 stroke kanji usually dont have meaning anyways and confetti wont have a kanji otherwise
	charges = 7
	reagent = /datum/reagent/glitter/confetti

/datum/kanji_spell/reagent/rotatium
	name = "Pour rotatium"
	desc = "Produces rotatium, why not have a sip?"
	kanji = "転" // common kanji, used in things like bicycle
	charges = 7
	reagent = /datum/reagent/toxin/rotatium
