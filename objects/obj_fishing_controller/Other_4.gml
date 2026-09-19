if (!instance_exists(bobber_instance)) {
    bobber_instance = instance_create_layer(
        rod_x,
        rod_y,
        "FishingLine",
        obj_bobber
    );

    bobber_instance.visible = false;
    bobber_instance.is_in_water = false;
    bobber_instance.is_biting = false;
}