var gui_width = display_get_gui_width();
var gui_height = display_get_gui_height();

switch (state){
	case "select":
    var bait_count =
        array_length(global.bait_inventory);

    var return_index = bait_count;

    var panel_bottom =
        min(
            gui_height - 25,
            180 + bait_count * 36
        );


    // =============================
    // INVENTORY BACKGROUND
    // =============================

    draw_set_alpha(0.85);
    draw_set_color(c_black);

    draw_rectangle(
        20,
        70,
        500,
        panel_bottom,
        false
    );

    draw_set_alpha(1);
    draw_set_halign(fa_left);
    draw_set_color(c_white);

    draw_text(
        40,
        70,
        "CHOOSE BAIT"
    );


    // =============================
    // EMPTY INVENTORY MESSAGE
    // =============================

    if (bait_count <= 0) {
        draw_set_color(c_ltgray);

        draw_text(
            40,
            105,
            "No bait remaining!"
        );
    }


    // =============================
    // BAIT LIST
    // =============================

    for (var i = 0; i < bait_count; i++) {
        var bait =
            global.bait_inventory[i];

        var item_y =
            115 + i * 36;

        // Selection background
        if (i == selected_bait) {
            draw_set_color(c_dkgray);

            draw_rectangle(
                32,
                item_y - 6,
                285,
                item_y + 26,
                false
            );
        }

        // Bait icon
        if (variable_struct_exists(bait, "sprite")) {
            var target_size = 20;

            var icon_scale =
                target_size
                / sprite_get_width(bait.sprite);

            draw_sprite_ext(
                bait.sprite,
                0,
                52,
                item_y + 10,
                icon_scale,
                icon_scale,
                0,
                c_white,
                1
            );
        }

        // Bait name
        if (i == selected_bait) {
            draw_set_color(c_yellow);
        } else {
            draw_set_color(c_white);
        }

        draw_text(
            75,
            item_y,
            bait.name
        );
    }


    // =============================
    // RETURN BUTTON
    // =============================

    var return_y =
        115 + bait_count * 36 + 5;

    if (selected_bait == return_index) {
        draw_set_color(c_dkgray);

        draw_rectangle(
            32,
            return_y - 6,
            285,
            return_y + 26,
            false
        );

        draw_set_color(c_yellow);
    } else {
        draw_set_color(c_white);
    }

    draw_text(
        50,
        return_y,
        "Stop fishing"
    );


    // =============================
    // CONTROLS
    // =============================

    draw_set_color(c_white);

    draw_text(
        150,
        panel_bottom - 22,
        "W/S: select"
    );

    draw_text(
        40,
        panel_bottom - 22,
        "Enter: confirm"
    );

    break;
	
	case "casting":
    draw_set_color(c_white);
    draw_set_halign(fa_center);

    draw_text(
        gui_width / 2,
        40,
        "Casting..."
    );

    break;
	
	case "waiting":
    draw_set_color(c_white);
    draw_set_halign(fa_center);

    draw_text(
        gui_width / 2,
        40,
        "Wait for a bite..."
    );

    draw_text(
        gui_width / 2,
        65,
        "Watch the bobber"
    );

    break;
	
	case "bite":
    draw_set_color(c_yellow);
    draw_set_halign(fa_center);

    draw_text_transformed(
        gui_width / 2,
        40,
        "BITE!",
        1.5,
        1.5,
        0
    );

    draw_set_color(c_white);

    draw_text(
        gui_width / 2,
        80,
        "PRESS SPACE!"
    );

    var bite_progress = clamp(
        bite_timer / bite_window,
        0,
        1
    );

    draw_rectangle(
        gui_width / 2 - 102,
        108,
        gui_width / 2 + 102,
        132,
        true
    );

    draw_set_color(c_lime);

    draw_rectangle(
        gui_width / 2 - 100,
        110,
        gui_width / 2 - 100
            + 200 * bite_progress,
        130,
        false
    );

    break;
	
	case "mashing":
    draw_set_color(c_white);
    draw_set_halign(fa_center);

    draw_text(
        gui_width / 2,
        40,
        "REEL IT IN!"
    );

    draw_text(
        gui_width / 2,
        65,
        "PRESS SPACE REPEATEDLY!"
    );

    draw_text(
        gui_width / 2,
        95,
        string(mash_count)
        + " / "
        + string(mash_target)
    );

    break;
	
	case "caught":
    // =====================================
    // FULL-SCREEN BACKGROUND
    // =====================================

    draw_set_alpha(1);
    draw_set_color(make_color_rgb(20, 30, 45));

    draw_rectangle(
        0,
        0,
        gui_width,
        gui_height,
        false
    );


    // =====================================
    // DECORATIVE PANEL
    // =====================================

    draw_set_color(make_color_rgb(230, 220, 180));

    draw_rectangle(
        30,
        25,
        gui_width - 30,
        gui_height - 25,
        false
    );

    draw_set_color(make_color_rgb(45, 55, 65));

    draw_rectangle(
        40,
        35,
        gui_width - 40,
        gui_height - 35,
        false
    );


    // =====================================
    // TITLE
    // =====================================

    draw_set_color(c_yellow);
    draw_set_halign(fa_center);
    draw_set_valign(fa_top);

    draw_text_transformed(
        gui_width / 2,
        55,
        "YOU CAUGHT",
        1.5,
        1.5,
        0
    );


    // =====================================
    // FISH IMAGE
    // =====================================

var fish_sprite = current_fish.sprite;

var fish_width =
    sprite_get_width(fish_sprite);

var fish_height =
    sprite_get_height(fish_sprite);

var maximum_width = gui_width * 0.55;
var maximum_height = gui_height * 0.4;

var fish_scale = min(
    maximum_width / fish_width,
    maximum_height / fish_height
);

var draw_width = fish_width * fish_scale;
var draw_height = fish_height * fish_scale;

var fish_x = (gui_width - draw_width) / 2;
var fish_y = 105;


// Glow only for Golden Fish
if (current_fish.id == "gold_fish") {
    var glow_pulse =
        1 + sin(current_time / 200) * 0.04;

    var glow_width =
        draw_width * 1.15 * glow_pulse;

    var glow_height =
        draw_height * 1.15 * glow_pulse;

    var glow_x =
        fish_x - (glow_width - draw_width) / 2;

    var glow_y =
        fish_y - (glow_height - draw_height) / 2;

    gpu_set_blendmode(bm_add);

    draw_sprite_stretched_ext(
        fish_sprite,
        0,
        glow_x,
        glow_y,
        glow_width,
        glow_height,
        c_yellow,
        0.35
    );

    gpu_set_blendmode(bm_normal);
}


// Normal fish image
draw_set_color(c_white);

draw_sprite_stretched(
    fish_sprite,
    0,
    fish_x,
    fish_y,
    draw_width,
    draw_height
);

    // =====================================
    // FISH NAME
    // =====================================

    var text_y =
        fish_y + draw_height + 15;

    draw_set_color(c_white);
    draw_set_halign(fa_center);

    draw_text_transformed(
        gui_width / 2,
        text_y,
        current_fish.name,
        1.3,
        1.3,
        0
    );


    // =====================================
    // DESCRIPTION
    // =====================================

    draw_set_color(c_ltgray);
    draw_set_halign(fa_center);

    draw_text_ext(
        gui_width / 2,
        text_y + 40,
        current_fish.description,
        24,
        gui_width - 120
    );


    // =====================================
    // SCORE
    // =====================================

    draw_set_color(c_yellow);

    draw_text(
        gui_width / 2,
        gui_height - 90,
        "+" + string(current_fish.points) + " points"
    );

	var caught_total = 0;

	for (
		var i = 0;
		i < array_length(global.fish_compendium);
		i++
	) {
	  if (global.fish_compendium[i].id == current_fish.id) {
			caught_total =
		        global.fish_compendium[i].caught_count;
	
			break;
		}
	}

draw_set_color(c_ltgray);

draw_text(
    gui_width / 2,
    gui_height - 115,
    "Caught: " + string(caught_total)
);

    // =====================================
    // CONTINUE
    // =====================================

    draw_set_color(c_white);

    draw_text(
        gui_width / 2,
        gui_height - 55,
        "Press ENTER to continue"
    );

    break;
}

draw_set_color(c_white);
draw_set_alpha(1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);