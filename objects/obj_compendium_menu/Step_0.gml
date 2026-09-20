// LEFT
if (keyboard_check_pressed(ord("A")))
{
    selected_col--;
    if (selected_col < 0)
        selected_col = cols - 1;
}

// RIGHT
if (keyboard_check_pressed(ord("D")))
{
    selected_col++;
    if (selected_col >= cols)
        selected_col = 0;
}

// UP
if (keyboard_check_pressed(ord("W")))
{
    selected_row--;
    if (selected_row < 0)
        selected_row = rows - 1;
}

// DOWN
if (keyboard_check_pressed(ord("S")))
{
    selected_row++;
    if (selected_row >= rows)
        selected_row = 0;
}