/obj/machinery/vending/tool
	payment_department = ACCOUNT_CAR // Cargo refills these so why isnt the payment always sent to them????

/obj/machinery/vending/tool/Initialize(mapload)
	// Has to be done in initialize, idk why
	products += list(
		/obj/item/gun/magic/wand/kanji = 5,
		/obj/item/inscription_tool = 10,
		/obj/item/clothing/neck/cloak/kanji = 10,
	)
	return ..()

// /datum/supply_pack/vending/vendomat
// 	name = "Part-Mart & YouTool Supply Crate"
// 	desc = "More tools for your IED testing facility."
// 	cost = CARGO_CRATE_VALUE * 2
// 	contains = list(/obj/item/vending_refill/assist,
// 					/obj/item/vending_refill/youtool,
// 				)
// 	crate_name = "\improper Part-Mart & YouTool supply crate"


// /datum/supply_pack/vending/vendomat
// 	name = "Part-Mart & YouTool Supply Crate"
// 	desc = "More tools for your IED testing facility."
// 	cost = CARGO_CRATE_VALUE * 2
// 	contains = list(/obj/item/vending_refill/assist,
// 					/obj/item/vending_refill/youtool,
// 				)
// 	crate_name = "\improper Part-Mart & YouTool supply crate"
