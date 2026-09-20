var center_x = 30;
var center_y = 90;

var spacing_x = 130;
var spacing_y = 130;

for (var row = 0; row < rows; row++)
{
    for (var col = 0; col < cols; col++)
    {
        var posX = center_x + col * spacing_x;
        var posY = center_y + row * spacing_y;

        // Button
        if (row == selected_row && col == selected_col)
            draw_sprite(buttonSmall_active, 0, posX, posY);
        else
            draw_sprite(buttonSmall, 0, posX, posY);

		// Item
		var fish_id = menu[row][col];
		var fish_get = get_fish_by_id(fish_id);
		
		if (fish_get != undefined)
		{
		    var item_sprite = fish_get.sprite;

		    var item_w = sprite_get_width(item_sprite);
			var item_h = sprite_get_height(item_sprite);

		    var max_size = 80;

		    var scale = min(
		        max_size / item_w,
		        max_size / item_h
		    );

		    // Find the sprite's visual center relative to its origin
		    var origin_x = sprite_get_xoffset(item_sprite);
		    var origin_y = sprite_get_yoffset(item_sprite);

		    var center_offset_x = (item_w / 2) - origin_x;
		    var center_offset_y = (item_h / 2) - origin_y;

		    // Compensate for the origin
		    var draw_x = posX - center_offset_x * scale + 54;
		    var draw_y = posY - center_offset_y * scale + 54;

		    draw_sprite_ext(item_sprite, 0, draw_x, draw_y, scale, scale, 0, c_white, 1);
		}
    }
};

var selected_id = menu[selected_row][selected_col];
var selected_fish = get_fish_by_id(selected_id);
var caught = get_fish_caught_count(selected_fish.id);

var item_w = sprite_get_width(selected_fish.sprite);
var item_h = sprite_get_height(selected_fish.sprite);
var scale = min(400 / item_w, 240 / item_h);
draw_sprite_ext(selected_fish.sprite, 0, 700, 60, scale, scale, 0, c_white, 1);

draw_set_font(fnt_fishName);
draw_set_color(make_color_rgb(81, 32, 13));
draw_text(700, 350, selected_fish.name);
draw_set_font(fnt_fishDescription);
draw_text_ext(700, 450, selected_fish.description, -1, 500);
draw_set_font(fnt_text);
draw_text(700, 670, "Points: " + string(selected_fish.points));
draw_text(940, 670, "Caught: " + string(caught));