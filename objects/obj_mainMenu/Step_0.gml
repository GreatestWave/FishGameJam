// Move up
if (keyboard_check_pressed(ord("W")))
{
    selected--;

    if (selected < 0)
        selected = button_count - 1;
}

// Move down
if (keyboard_check_pressed(ord("S")))
{
    selected++;

    if (selected >= button_count)
        selected = 0;
}

// Select menu
if (keyboard_check_pressed(vk_enter) ||
    keyboard_check_pressed(vk_space))
{
    switch (selected)
    {
        case 0:
            // PLAY
            room_goto(rm_collect);
            break;

        case 1:
            // COMPENDIUM
			room_goto(rm_compendium);
            break;

        case 2:
            // QUIT
            game_end();
            break;
    }
}