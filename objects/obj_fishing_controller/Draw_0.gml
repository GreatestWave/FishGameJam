var fisherman = instance_find(obj_fisherman, 0);
var bobber = instance_find(obj_bobber, 0);

if (
    bobber_instance != noone
    && instance_exists(bobber_instance)
) {
    if (bobber_instance.visible) {
        draw_set_color(c_white);

        draw_line_width(
            rod_x,
            rod_y,
            bobber_instance.x,
            bobber_instance.y,
            1
        );
    }
}

draw_set_color(c_white);
