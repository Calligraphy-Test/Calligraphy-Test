/datum/component/delete_distance
	var/datum/movement_detector/parent_tracker
	var/datum/movement_detector/target_tracker
	var/atom/target
	var/max_dist

/datum/component/delete_distance/Initialize(target, max_dist = 7)
	if(!isatom(parent) || !isatom(target))
		return COMPONENT_INCOMPATIBLE
	src.target = target
	src.max_dist = max_dist
	parent_tracker = new(parent, CALLBACK(src, PROC_REF(checkMove)))
	target_tracker = new(target, CALLBACK(src, PROC_REF(checkMove)))

/datum/component/delete_distance/proc/checkMove()
	SIGNAL_HANDLER

	if (get_dist(parent, target) > max_dist)
		new /obj/effect/temp_visual/telekinesis(get_turf(parent))
		qdel(parent)

/datum/component/delete_distance/Destroy(force, silent)
	QDEL_NULL(parent_tracker)
	QDEL_NULL(target_tracker)
	return ..()
