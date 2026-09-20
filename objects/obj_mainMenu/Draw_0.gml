var center_x = room_width / 2;

var y1 = 440;
var y2 = 540;
var y3 = 640;

var button_y = [y1, y2, y3];
var button_text = ["Start", "Compendium", "Exit"];

for (var i = 0; i < 3; i++)
{
    if (selected == i)
        draw_sprite(menuButton_active, 0, center_x, button_y[i]);
    else
        draw_sprite(menuButton, 0, center_x, button_y[i]);

    draw_set_font(fnt_header);
    draw_set_halign(fa_center);
    draw_set_valign(fa_middle);

    draw_text(center_x, button_y[i], button_text[i]);
}

// Reset drawing settings
draw_set_font(-1);
draw_set_halign(fa_left);
draw_set_valign(fa_top);