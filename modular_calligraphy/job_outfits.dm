/obj/item/storage/box/survival/PopulateContents()
	if(crafted)
		return
	if(!isnull(mask_type))
		new mask_type(src)

	if(!isplasmaman(loc))
		new internal_type(src)
	else
		new /obj/item/tank/internals/plasmaman/belt(src)

	if(!isnull(medipen_type))
		new medipen_type(src)

	if(HAS_TRAIT(SSstation, STATION_TRAIT_PREMIUM_INTERNALS))
		new /obj/item/flashlight/flare(src)
		new /obj/item/radio/off(src)
	// This is the only line i added, the rest is just copied over
	new /obj/item/kanji_tome(src)

// COMMAND

/datum/outfit/job/captain
	belt = /obj/item/gun/magic/wand/kanji/blasting
	l_pocket = /obj/item/modular_computer/pda/heads/captain

/datum/outfit/job/hop
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/storage/box/ids = 1,
		/obj/item/gun/magic/wand/kanji = 1, //only a normal wand
		)

// SECURITY

// Armor has a janky way of setting what can go in the suit slot in its Initialize() so I cant edit it in a modularized way

/datum/outfit/job/security
	suit_store = /obj/item/restraints/handcuffs
	belt = /obj/item/gun/magic/wand/kanji/blasting
	l_pocket = /obj/item/modular_computer/pda/security

/datum/outfit/job/detective
	belt = /obj/item/gun/magic/wand/kanji/blasting
	l_pocket = /obj/item/modular_computer/pda/detective

/datum/outfit/job/warden
	suit_store = /obj/item/restraints/handcuffs
	belt = /obj/item/gun/magic/wand/kanji/blasting
	l_pocket = /obj/item/modular_computer/pda/warden

/datum/outfit/job/hos
	suit_store = /obj/item/restraints/handcuffs
	belt = /obj/item/gun/magic/wand/kanji/blasting
	l_pocket = /obj/item/modular_computer/pda/heads/hos

// MEDICAL

/datum/outfit/job/doctor
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji/mending = 1,
		/obj/item/inscription_tool/fairy = 1,
		)

/datum/outfit/job/paramedic
	backpack_contents = list(
		/obj/item/roller = 1,
		/obj/item/gun/magic/wand/kanji/mending = 1,
		)

/datum/outfit/job/chemist
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji/mending = 1,
		)

/datum/outfit/job/virologist
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji/mending = 1,
		)

/datum/outfit/job/cmo
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/gun/magic/wand/kanji/mending = 1,
		/obj/item/inscription_tool/fairy = 1,
		)

// ENGINEERING

/datum/outfit/job/engineer
	backpack_contents = list(
		/obj/item/inscription_tool/plasma = 1,
		)

/datum/outfit/job/atmos
	backpack_contents = list(
		/obj/item/inscription_tool/plasma = 1,
		)

/datum/outfit/job/ce
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/gun/magic/wand/kanji = 1,
		/obj/item/inscription_tool/plasma = 1,
		)

// CARGO

/datum/outfit/job/cargo_tech
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji = 1,
	)

/datum/outfit/job/miner
	backpack_contents = list(
		/obj/item/flashlight/seclite = 1,
		/obj/item/knife/combat/survival = 1,
		/obj/item/mining_voucher = 1,
		/obj/item/stack/marker_beacon/ten = 1,
		/obj/item/inscription_tool = 1,
	)

/datum/outfit/job/quartermaster
	name = "Quartermaster"
	jobtype = /datum/job/quartermaster
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1, // why does qm get a telebaton? he isnt even a head
		/obj/item/gun/magic/wand/kanji = 1,
		/obj/item/inscription_tool = 1,
	)

// SCIENCE

/datum/outfit/job/scientist
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji = 1,
		)

/datum/outfit/job/roboticist
	backpack_contents = list(
		/obj/item/inscription_tool = 1,
		)

/datum/outfit/job/rd
	backpack_contents = list(
		/obj/item/melee/baton/telescopic = 1,
		/obj/item/gun/magic/wand/kanji = 1,
		)

// SERVICE

// service should just go buy something from cargo since they get paid

// NEET

/datum/outfit/job/assistant
	backpack_contents = list(
		/obj/item/gun/magic/wand/kanji = 1,
		)
