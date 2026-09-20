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
		if (menu[row][col] != -1)
		{
		    var item_sprite = menu[row][col];

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
}	