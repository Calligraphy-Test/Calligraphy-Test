/datum/kanji_spell/creation/book
	name = "Summon book"
	desc = "Summons a random book of often bizzare taste."
	kanji = "本"
	charges = 10
	creation = /obj/item/book/manual/random

// I kinda wana make this take a random book from the library at some point instead
/datum/kanji_spell/creation/book/make_creation(var/target, mob/living/user)
	var/banned_books = list(/obj/item/book/manual/random, /obj/item/book/manual/nuclear, /obj/item/book/manual/wiki)
	var/selected_reading = pick(subtypesof(/obj/item/book/manual) - banned_books)
	return new selected_reading(get_turf(target))

/datum/kanji_spell/creation/paper
	name = "Summon paper"
	desc = "Summons a sheet of paper."
	kanji = "紙"
	charges = 10
	creation = /obj/item/paper

/datum/kanji_spell/creation/chair
	name = "Summon chair"
	desc = "Summons a chair."
	kanji = "椅"
	creation = /obj/structure/chair

/datum/kanji_spell/creation/vehicle
	name = "Summon vehicle"
	desc = "Summons a vehicle. Don't forget to also summon the key"
	kanji = "車"
	creation = /obj/vehicle/ridden/atv

	// nothing good will come from spawning a speedwagon
	// /obj/vehicle/ridden/speedwagon
	// the bicycle is too fast
	// /obj/vehicle/ridden/bicycle

/datum/kanji_spell/creation/key
	name = "Summon key"
	desc = "Summons a mysterious key."
	kanji = "鍵"
	creation = /obj/item/key/atv // other /obj/item/key types are secway and janitor but I dont think those should be spawned

////////////
//  FOOD  //
////////////

/datum/kanji_spell/creation/meat
	name = "Summon meat"
	desc = "Summons mystery meat."
	kanji = "肉"
	charges = 5
	creation = /obj/item/food/meat/slab

/datum/kanji_spell/creation/rice
	name = "Summon rice"
	desc = "Summons uncooked rice."
	kanji = "米"
	charges = 5
	creation = /obj/item/food/uncooked_rice

/datum/kanji_spell/creation/meal
	name = "Summon cooked rice"
	desc = "Summons cooked rice."
	kanji = "飯"
	charges = 2
	creation = /obj/item/food/boiledrice

/datum/kanji_spell/creation/fruit
	name = "Summon fruit"
	desc = "Summons a random fruit."
	kanji = "果"
	charges = 6
	creation = list(/obj/item/food/grown/apple, /obj/item/food/grown/banana, /obj/item/food/grown/citrus/orange, /obj/item/food/grown/citrus/lemon, /obj/item/food/grown/citrus/lime)

/datum/kanji_spell/creation/vegetable
	name = "Summon vegetable"
	desc = "Summons a random vegetable."
	kanji = "菜" // 野菜
	charges = 6
	creation = list(/obj/item/food/grown/cabbage, /obj/item/food/grown/onion, /obj/item/food/grown/carrot)

/datum/kanji_spell/creation/gourd
	name = "Summon gourd"
	desc = "Summons a gourd. For clarity, common examples of gourds are watermelons, pumpkins, and cucumbers."
	kanji = "瓜" // 西瓜 or "west gourd" for watermelon, 南瓜 or "south gourd" for pumpkin, 胡瓜 or "foreign gourd" for cucumber
	charges = 6
	creation = list(/obj/item/food/grown/watermelon, /obj/item/food/grown/pumpkin, /obj/item/food/grown/cucumber)

/datum/kanji_spell/creation/legume
	name = "Summon legume"
	desc = "Summons legumes. This spell seems to only make soy beans for some reason..."
	kanji = "豆"
	charges = 6
	creation = /obj/item/food/grown/soybeans

/datum/kanji_spell/creation/grain
	name = "Summon grain"
	desc = "Summons a grain plant. So for example, wheat and oats. You still need to process this plant however."
	kanji = "麦"
	charges = 6
	creation = list(/obj/item/food/grown/wheat, /obj/item/food/grown/oat)

/datum/kanji_spell/creation/flower
	name = "Summon flower"
	desc = "Summons a flower. It smells magical."
	kanji = "花"
	charges = 6
	creation = list(/obj/item/food/grown/poppy, /obj/item/food/grown/harebell, /obj/item/food/grown/poppy/lily)

/datum/kanji_spell/creation/egg
	name = "Summon egg"
	desc = "Summons a egg. Maybe the egg really did come before the chicken..."
	kanji = "卵"
	charges = 12
	creation = /obj/item/food/egg

////////////////
//  CLOTHING  //
////////////////

// I kinda want to make it so only 1 summoned crown could exist at a time since people fighting over it would be funny
/datum/kanji_spell/creation/crown
	name = "Summon crown"
	desc = "Summons a gaudy crown."
	kanji = "王" // 王 is for king, 位 is for the position, 冠 might be the best, we are using 王 because it is the simplist
	creation = /obj/item/clothing/head/costume/crown

// If someone wants to get all non gameplay relevant clothes be my guest

/datum/kanji_spell/creation/hat
	name = "Summon hat"
	desc = "Summons a random hat."
	kanji = "帽"
	creation = list(/obj/item/clothing/head/hats/tophat, /obj/item/clothing/head/hats/bowler, /obj/item/clothing/head/fedora, /obj/item/clothing/head/flatcap, /obj/item/clothing/head/soft/black)

/datum/kanji_spell/creation/clothes
	name = "Summon clothes"
	desc = "Summons a grey jumpsuit."
	kanji = "服" // 衣 is another generic kanji for clothing but idk how i should differentiate it from 服
	creation = /obj/item/clothing/under/color/grey

/datum/kanji_spell/creation/shoes
	name = "Summon shoes"
	desc = "Summons a simple pair of shoes."
	kanji = "靴"
	creation = /obj/item/clothing/shoes/sneakers

/////////////////
//  MATERIALS  //
/////////////////

/datum/kanji_spell/creation/metal
	name = "Summon metal"
	desc = "Summons a sheet of iron for industrial usage."
	kanji = "鉄" // 鋼 is for steel
	charges = 10
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/sheet/iron/five

/datum/kanji_spell/creation/glass
	name = "Summon glass"
	desc = "Summons a window pane which you could probably use for more than windows."
	kanji = "窓" // 硝子 is glass, however that means "saltpeter child" so we use 窓 instead which means window
	charges = 20
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/sheet/glass

/datum/kanji_spell/creation/wood
	name = "Summon wood"
	desc = "Summons a stack off wooden planks."
	kanji = "木" // 材 is for lumber and 木 is for trees so I might need to swap it over eventually
	charges = 20
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/sheet/mineral/wood

/datum/kanji_spell/creation/sand
	name = "Summon sand"
	desc = "Summons a pile of sand."
	kanji = "砂"
	charges = 5 // Sand can do stamina damage when thrown at someone without glasses so limit this number
	creation = /obj/item/stack/ore/glass

/datum/kanji_spell/creation/gold
	name = "Summon gold"
	desc = "Summons a bar of gold."
	kanji = "金"
	charges = 5
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/sheet/mineral/gold

/datum/kanji_spell/creation/silver
	name = "Summon silver"
	desc = "Summons a bar of silver."
	kanji = "銀"
	charges = 5
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/sheet/mineral/silver

/datum/kanji_spell/creation/crystal
	name = "Summon crystal"
	desc = "Summons an unusual small jem."
	kanji = "玉"
	limitation_flags = KANJI_SPELL_BUILDING_MATERIALS
	creation = /obj/item/stack/ore/bluespace_crystal/artificial

//////////////
//  COMBAT  //
//////////////

/datum/kanji_spell/creation/spear
	name = "Summon spear"
	desc = "Summons a spear, hopefully not one in motion."
	kanji = "槍"
	limitation_flags = KANJI_SPELL_COMBAT
	filters = list(KANJI_FILTER_COMBAT)
	creation = /obj/item/spear

/datum/kanji_spell/creation/sword
	name = "Summon sword"
	desc = "Summons a sword, please be careful and do so responsibly."
	kanji = "刀"
	limitation_flags = KANJI_SPELL_COMBAT
	filters = list(KANJI_FILTER_COMBAT)
	creation = list(/obj/item/claymore, /obj/item/katana, /obj/item/claymore/cutlass) // non katanas should maybe be attached to 剣 instead

/datum/kanji_spell/creation/bow
	name = "Summon bow"
	desc = "Summons a bow, arrows not included."
	kanji = "弓"
	limitation_flags = KANJI_SPELL_COMBAT
	filters = list(KANJI_FILTER_COMBAT)
	creation = /obj/item/gun/ballistic/bow/longbow

/datum/kanji_spell/creation/arrow
	name = "Summon arrow"
	desc = "Summons an arrow, bow not included."
	kanji = "矢"
	charges = 10
	limitation_flags = KANJI_SPELL_COMBAT
	filters = list(KANJI_FILTER_COMBAT)
	creation = /obj/item/ammo_casing/arrow
