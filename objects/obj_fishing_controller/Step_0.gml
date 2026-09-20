// Time between frames in seconds
var dt = min(delta_time / 1000000, 0.1);

// Number of available bait items
var bait_count = array_length(global.bait_inventory);


switch (state) {
    // SELECT BAIT

    case "select":

    // Return button is always the last option
    var return_index = bait_count;

    // Total options:
    // bait items + return button
    var menu_option_count = bait_count + 1;


    // =============================
    // KEYBOARD SELECTION
    // =============================

    if (keyboard_check_pressed(ord("S"))) {
        selected_bait++;
    }

    if (keyboard_check_pressed(ord("W"))) {
        selected_bait--;
    }

    // Loop selection
    if (selected_bait >= menu_option_count) {
        selected_bait = 0;
    }

    if (selected_bait < 0) {
        selected_bait =
            menu_option_count - 1;
    }


    // =============================
    // RETURN BUTTON POSITION
    // =============================

    var return_y =
        115 + bait_count * 36 + 15;

    var mouse_gui_x =
        device_mouse_x_to_gui(0);

    var mouse_gui_y =
        device_mouse_y_to_gui(0);

    var mouse_over_return =
        point_in_rectangle(
            mouse_gui_x,
            mouse_gui_y,
            32,
            return_y - 6,
            285,
            return_y + 26
        );


    // =============================
    // RETURN TO MAIN MENU
    // =============================

    var return_pressed =
        (
            selected_bait == return_index
            && keyboard_check_pressed(vk_enter)
        )


    if (return_pressed) {
        room_goto(rm_main_menu);
        break;
    }


    // =============================
    // USE SELECTED BAIT
    // =============================

    if (
        keyboard_check_pressed(vk_enter)
        && selected_bait < bait_count
    ) {
        current_bait =
            global.bait_inventory[selected_bait];

        current_fish =
            get_fish_from_bait(current_bait.id);

        var bait_rarity =
            get_bait_rarity(current_bait.id);

        bite_window = max(
            0.4,
            1.2 - bait_rarity * 0.2
        );

        // Consume bait
        array_delete(
            global.bait_inventory,
            selected_bait,
            1
        );

        cast_timer = 0;

        if (instance_exists(bobber_instance)) {
            bobber_instance.x = rod_x;
            bobber_instance.y = rod_y;

            bobber_instance.visible = true;
            bobber_instance.is_in_water = false;
            bobber_instance.is_biting = false;

            state = "casting";
        }
    }

    break;

    // CASTING

case "casting":
    cast_timer += dt;

    var cast_progress = clamp(
        cast_timer / cast_duration,
        0,
        1
    );

    // Horizontal movement
    bobber_instance.x = lerp(
        rod_x,
        bobber_target_x,
        cast_progress
    );

    // Vertical movement with an arc
    bobber_instance.y =
        lerp(
            rod_y,
            bobber_target_y,
            cast_progress
        )
        - sin(cast_progress * pi)
        * cast_arc_height;

    // Bobber reached the water
if (cast_progress >= 1) {
    bobber_instance.x = bobber_target_x;
    bobber_instance.y = bobber_target_y;

    bobber_instance.water_y = bobber_target_y;
    bobber_instance.bob_time = 0;
    bobber_instance.is_in_water = true;
    bobber_instance.is_biting = false;

    // Play splash sound once
    audio_play_sound(
        snd_water_splash,
        1,
        false
    );

    waiting_timer = random_range(1.5, 4);
    state = "waiting";
}
	
	

    break;


    // WAITING FOR A BITE

    case "waiting":
        waiting_timer -= dt;

        if (waiting_timer <= 0) {
            with (obj_bobber) {
                is_biting = true;
            }

            bite_timer = bite_window;
            state = "bite";
        }

        break;

    // REACTION WINDOW

   case "bite":
    bite_timer -= dt;

if (keyboard_check_pressed(vk_space)) {
    bobber_instance.visible = true;
    bobber_instance.is_in_water = false;
    bobber_instance.is_biting = false;

    // Remember where reeling starts
    reel_start_x = bobber_instance.x;
    reel_start_y = bobber_instance.y;

    mash_count = 0;
    mash_target = 8 + current_fish.rarity * 4;
    mash_timer = mash_duration;

    state = "mashing";
}
    else if (bite_timer <= 0) {
        bobber_instance.visible = false;
        bobber_instance.is_in_water = false;
        bobber_instance.is_biting = false;

        result_text =
            current_fish.name + " escaped!";

        state = "failed";
    }

    break;


    // BUTTON MASH

   case "mashing":
    mash_timer -= dt;

    if (keyboard_check_pressed(vk_space)) {
        mash_count++;
    }

    var reel_progress = clamp(
        mash_count / mash_target,
        0,
        1
    );

    bobber_instance.x = lerp(
        reel_start_x,
        rod_x,
        reel_progress
    );

    bobber_instance.y = lerp(
        reel_start_y,
        rod_y,
        reel_progress
    );

    if (mash_count >= mash_target) {
		bobber_instance.visible = false;

		// Save fish in the compendium
		register_caught_fish(current_fish);

		result_text =
        "You caught " + current_fish.name + "!";

		state = "caught";
	}
    else if (mash_timer <= 0) {
        bobber_instance.visible = false;

        result_text =
            current_fish.name + " broke free!";

        state = "failed";
    }

    break;

    // SUCCESSFUL CATCH

case "caught":
    if (keyboard_check_pressed(vk_enter)) {

        if (bait_count > 0) {
            selected_bait = clamp(
                selected_bait,
                0,
                bait_count - 1
            );
        } else {
            selected_bait = 0;
        }

        current_bait = undefined;
        current_fish = undefined;
        result_text = "";

        // Open inventory again
        state = "select";
    }

    break;


    // FAILED CATCH

case "failed":
    if (keyboard_check_pressed(vk_space)) {

        if (bait_count > 0) {
            selected_bait = clamp(
                selected_bait,
                0,
                bait_count - 1
            );
        } else {
            selected_bait = 0;
        }

        current_bait = undefined;
        current_fish = undefined;
        result_text = "";

        state = "select";
    }

    break;
}