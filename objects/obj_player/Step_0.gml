var move_x = keyboard_check(ord("D")) - keyboard_check(ord("A"));
var move_y = keyboard_check(ord("S")) - keyboard_check(ord("W"));

//Normalisation
if (move_x != 0 || move_y != 0) {
    var direction_length = point_distance(0, 0, move_x, move_y);

    move_x /= direction_length;
    move_y /= direction_length;
}

// Camera follows the player
var camera = view_camera[0];

var camera_width = camera_get_view_width(camera);
var camera_height = camera_get_view_height(camera);

var camera_x = x - camera_width / 2;
var camera_y = y - camera_height / 2;

camera_set_view_pos(
    camera,
    camera_x,
    camera_y
);

//Speed calculations
var hspeed_value = move_x * move_speed;
var vspeed_value = move_y * move_speed;

//Horizontal movement
if (!place_meeting(x + hspeed_value, y, obj_wall)) {
    x += hspeed_value;
}

//Vertical movement
if (!place_meeting(x, y + vspeed_value, obj_wall)) {
    y += vspeed_value;
}

//Items finder
nearby_item = instance_nearest(x, y, obj_item);

if (nearby_item != noone) {
    var distance = point_distance(
        x,
        y,
        nearby_item.x,
        nearby_item.y
    );

    if (distance > interaction_distance) {
        nearby_item = noone;
    }
}

//Item pickup
if (nearby_item != noone && keyboard_check_pressed(ord("E"))) {

    // Create inventory entry
    var picked_item = {
        id: nearby_item.item_id,
        name: nearby_item.item_name,
        sprite: nearby_item.sprite_index
    };

    // Add item to inventory
    array_push(inventory, picked_item);

    // Remove item from the room
    instance_destroy(nearby_item);

    nearby_item = noone;
}


//Timer
if (!collection_finished) {
    collection_time -= 1 / game_get_speed(gamespeed_fps);

    if (collection_time <= 0) {
        collection_time = 0;
        collection_finished = true;

        //Save inventory between rooms 
        global.bait_inventory = inventory;

        room_goto(rm_fishing);
    }
}

//Sequence movement
if (keyboard_check(ord("A")))
	facing_left = true;
else if (keyboard_check(ord("D")))
	facing_left = false;

function player_set_sequence(_sequence)
{
    current_sequence = _sequence;

    if (player_sequence != -1)
    {
        layer_sequence_destroy(player_sequence);
    }

    player_sequence = layer_sequence_create("Sequences", x, y, current_sequence);
    var scale = abs(image_xscale * 2);
    if (facing_left)
    {
        scale = -scale;
    }

    layer_sequence_xscale(player_sequence, scale);
    layer_sequence_yscale(player_sequence, image_yscale * 2);
}

if (move_x != 0 || move_y != 0)
{
    if (current_sequence != seq_player_walk)
    {
        player_set_sequence(seq_player_walk);
    }
}
else
{
    if (current_sequence != seq_player_idle)
    {
        player_set_sequence(seq_player_idle);
    }
}

// Keep Sequence attached to player
layer_sequence_x(player_sequence, x);
layer_sequence_y(player_sequence, y);