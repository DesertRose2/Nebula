/obj/machinery/network/router/wall_mounted
	name = "wall-mounted network router"
	icon = 'icons/obj/machines/wall_router.dmi'
	icon_state = "wall_router"
	frame_type = /obj/item/frame/wall_router
	construct_state = /decl/machine_construction/wall_frame/panel_closed
	density = 0
	base_type = /obj/machinery/network/router/wall_mounted

/obj/machinery/network/router/wall_mounted/Initialize()
	. = ..()
	queue_icon_update()

/obj/machinery/network/router/wall_mounted/on_update_icon()
	. = ..()
	// Set pixel offsets
	pixel_x = 0
	pixel_y = 0
	var/turf/T = get_step(get_turf(src), turn(dir, 180))
	if(istype(T) && T.density)
		if(dir == NORTH)
			pixel_y = -21
		else if(dir == SOUTH)
			pixel_y = 21
		else if(dir == WEST)
			pixel_x = 21
		else if(dir == EAST)
			pixel_x = -21