/datum/kanji_spell/creation/human
	name = "Summon human"
	desc = "Summons an empty human body."
	kanji = "人"
	limitation_flags = KANJI_SPELL_NOT_THROWABLE
	creation = /mob/living/carbon/human

/datum/kanji_spell/creation/dog
	name = "Summon lesser canine"
	desc = "Summons a corgi."
	kanji = "犬"
	charges = 5
	creation = /mob/living/basic/pet/dog/corgi

/datum/kanji_spell/creation/cat
	name = "Summon lesser feline"
	desc = "Summons a cat."
	kanji = "猫"
	charges = 5
	creation = /mob/living/simple_animal/pet/cat

/datum/kanji_spell/creation/fox
	name = "Summon fox"
	desc = "Summons a fox."
	kanji = "狐"
	charges = 5
	creation = /mob/living/simple_animal/pet/fox

/datum/kanji_spell/creation/sheep
	name = "Summon sheep"
	desc = "Summons a goat."
	kanji = "羊"
	charges = 4
	creation = list(/mob/living/basic/sheep, /mob/living/simple_animal/hostile/retaliate/goat)

/datum/kanji_spell/creation/cow
	name = "Summon cow"
	desc = "Summons a cow."
	kanji = "牛"
	charges = 2
	creation = /mob/living/basic/cow

/datum/kanji_spell/creation/deer
	name = "Summon deer"
	desc = "Summons a deer."
	kanji = "鹿"
	charges = 6
	creation = /mob/living/basic/deer

/datum/kanji_spell/creation/pig
	name = "Summon pig"
	desc = "Summons a pig."
	kanji = "豚"
	charges = 5
	creation = /mob/living/basic/pig

/datum/kanji_spell/creation/rabbit
	name = "Summon rabbit"
	desc = "Summons a rabbit."
	kanji = "兎"
	charges = 4
	creation = /mob/living/basic/rabbit

/datum/kanji_spell/creation/frog
	name = "Summon frog"
	desc = "Summons a frog."
	kanji = "蛙"
	charges = 4
	creation = /mob/living/basic/frog

/datum/kanji_spell/creation/mouse
	name = "Summon mouse"
	desc = "Summons a mouse."
	kanji = "鼠"
	charges = 10
	creation = list(/mob/living/basic/mouse,
	/mob/living/basic/mouse/white,
	/mob/living/basic/mouse/gray,
	/mob/living/basic/mouse/brown)
	// /mob/living/simple_animal/hostile/regalrat)

/datum/kanji_spell/creation/bird
	name = "Summon bird"
	desc = "Summons a bird."
	kanji = "鳥" // 烏 is a different kanji for ravens/crows
	charges = 5
	creation = list(/mob/living/basic/chicken = 10,
	/mob/living/simple_animal/parrot = 10,
	/mob/living/simple_animal/hostile/retaliate/goose = 10,
	/mob/living/simple_animal/pet/penguin/emperor = 10,
	/mob/living/simple_animal/pet/penguin/emperor/shamebrero,
	/mob/living/simple_animal/pet/penguin/baby = 5)
	// Not a real type
	// /mob/living/simple_animal/pet/penguin,

/datum/kanji_spell/creation/lizard
	name = "Summon lizard"
	desc = "Summons a lizard."
	kanji = "蜥" // Maybe bad, uses 2 kanji  蜥蜴, it rarely accepts this too
	charges = 10
	creation = list(/mob/living/basic/axolotl, /mob/living/basic/lizard)

/datum/kanji_spell/creation/insect
	name = "Summon insect"
	desc = "Summons a insect."
	kanji = "虫"
	charges = 10
	creation = list(/mob/living/basic/ant = 2,
	/mob/living/simple_animal/hostile/bee = 10,
	/mob/living/simple_animal/hostile/bee/queen,
	/mob/living/basic/butterfly = 10,
	/mob/living/basic/cockroach = 10)

/datum/kanji_spell/creation/fairy
	name = "Summon fairy"
	desc = "Summons a fairy."
	kanji = "精"
	limitation_flags = KANJI_SPELL_HEALING
	creation = /mob/living/basic/lightgeist

/datum/kanji_spell/creation/ghost
	name = "Summon ghost"
	desc = "Summons a ghost."
	kanji = "亡" // Maybe not the best kanji for this
	charges = 15
	creation = list(/mob/living/basic/ghost,
	/mob/living/basic/ghost/swarm)
	// /mob/living/simple_animal/shade

/datum/kanji_spell/creation/mushroom
	name = "Summon mushroom"
	desc = "We are kinoko."
	kanji = "茸"
	charges = 3
	creation = /mob/living/simple_animal/hostile/mushroom

/datum/kanji_spell/creation/crab
	name = "Summon crab"
	desc = "Summons a crab."
	kanji = "蟹"
	charges = 6
	creation = list(/mob/living/simple_animal/crab = 100,
	/mob/living/simple_animal/crab/evil = 10,
	/mob/living/simple_animal/crab/kreb = 10,
	/mob/living/simple_animal/crab/evil/kreb = 1)

/datum/kanji_spell/creation/snake
	name = "Summon snake"
	desc = "Summons a small garden snake."
	kanji = "蛇"
	charges = 6
	creation = /mob/living/simple_animal/hostile/retaliate/snake

/////////////////
//  Dangerous  //
/////////////////

/datum/kanji_spell/creation/carp
	name = "Summon carp"
	desc = "Summons a hungry carp."
	kanji = "魚"
	charges = 4
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/basic/carp = 9, /mob/living/basic/carp/mega)

/datum/kanji_spell/creation/bat
	name = "Summon bat"
	desc = "Summons a bat."
	kanji = "蝙" // Maybe bad, uses 2 kanji  蝙蝠
	charges = 10
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = /mob/living/basic/bat // They make a noise

/datum/kanji_spell/creation/spider
	name = "Summon spider"
	desc = "Summons a spider."
	kanji = "蜘" // Maybe bad, uses 2 kanji 蜘蛛, it rarely accepts this too
	charges = 8
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/basic/giant_spider,
	/mob/living/basic/giant_spider/hunter,
	/mob/living/basic/giant_spider/nurse,
	/mob/living/basic/giant_spider/tarantula,
	/mob/living/basic/giant_spider/viper,
	/mob/living/basic/giant_spider/midwife)
	///mob/living/basic/giant_spider/maintenance)

/datum/kanji_spell/creation/monkey
	name = "Summon monkey"
	desc = "Summons a monkey."
	kanji = "猿"
	charges = 5
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/carbon/human/species/monkey = 10,
	/mob/living/carbon/human/species/monkey/angry = 10,
	/mob/living/simple_animal/hostile/gorilla)

/datum/kanji_spell/creation/bear
	name = "Summon bear"
	desc = "Summons a bear."
	kanji = "熊"
	charges = 4
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/simple_animal/hostile/bear,
	/mob/living/simple_animal/hostile/bear/snow,
	/mob/living/simple_animal/hostile/bear/russian,
	/mob/living/simple_animal/pet/gondola)
	// Astroid polar bears are too strong
	// /mob/living/simple_animal/hostile/asteroid/polarbear/lesser,
	// /mob/living/simple_animal/hostile/asteroid/polarbear,

/datum/kanji_spell/creation/wolf
	name = "Summon greater canine"
	desc = "Summons a wolf."
	kanji = "狼"
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = /mob/living/simple_animal/hostile/asteroid/wolf

/datum/kanji_spell/creation/skeleton
	name = "Summon skeleton"
	desc = "Summons a skeleton."
	kanji = "骨"
	charges = 8
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = /mob/living/simple_animal/hostile/skeleton
	// The other skeletons dont look a lot like skeletons
	// list(/mob/living/simple_animal/hostile/skeleton,
	// /mob/living/simple_animal/hostile/skeleton/eskimo,
	// /mob/living/simple_animal/hostile/skeleton/templar,
	// /mob/living/simple_animal/hostile/skeleton/ice,
	// /mob/living/simple_animal/hostile/skeleton/plasmaminer,
	// /mob/living/simple_animal/hostile/skeleton/plasmaminer/jackhammer)

/datum/kanji_spell/creation/demon
	name = "Summon demon"
	desc = "Summons a demon."
	kanji = "鬼"
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/basic/blankbody = 10,
	/mob/living/basic/migo = 10,
	/mob/living/simple_animal/hostile/imp = 20,
	/mob/living/simple_animal/hostile/imp/slaughter = 1)

/datum/kanji_spell/creation/eye
	name = "Summon eye"
	desc = "Summons a eye."
	kanji = "目"
	charges = 2 // Not strong but it makes sense for 2 for eyes, plus this kanji should probably be used for something else
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = /mob/living/simple_animal/hostile/eyeball

/datum/kanji_spell/creation/bandit
	name = "Summon bandit"
	desc = "Summons a bandit."
	kanji = "賊" // 賊 is the actual kanji for bandits and it is easier for the recognizer than 戝
	charges = 3
	limitation_flags = KANJI_SPELL_HOSTILE_CREATURE
	creation = list(/mob/living/simple_animal/hostile/pirate,
	/mob/living/simple_animal/hostile/pirate/melee,
	/mob/living/simple_animal/hostile/pirate/ranged)
	// too different from the other pirates
	// /mob/living/simple_animal/hostile/pirate/melee/space,
	// /mob/living/simple_animal/hostile/pirate/ranged/space,
