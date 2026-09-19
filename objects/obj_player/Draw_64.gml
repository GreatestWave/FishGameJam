//Notification to pick up
if (nearby_item != noone) {
    draw_set_halign(fa_center);
    draw_text(
        display_get_gui_width() / 2,
        display_get_gui_height() - 60,
        "E - Pick up " + nearby_item.item_name
    );
    draw_set_halign(fa_left);
}

//Timer
var time_display = ceil(collection_time);

draw_set_halign(fa_center);
draw_set_valign(fa_top);

draw_text(
    display_get_gui_width() / 2,
    20,
    "Time: " + string(time_display)
);

draw_set_halign(fa_left);
draw_set_valign(fa_top);

//inventory
draw_set_halign(fa_left);

draw_text(
    20,
    20,
    "Collected: " + string(array_length(inventory))
);

for (var i = 0; i < array_length(inventory); i++) {
    var item = inventory[i];

    draw_text(
        20,
        50 + i * 22,
        string(i + 1) + ". " + item.name
    );
}

// Reset drawing settings
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
