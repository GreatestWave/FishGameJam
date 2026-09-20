var target_width = 32;

image_xscale = target_width / sprite_width;
image_yscale = image_xscale;
image_alpha = 0;

move_speed = 3;
nearby_item = noone;
interaction_distance = 40;
inventory = [];
collection_time = 30;
collection_finished = false;

current_sequence = seq_player_idle;
facing_left = false;

if (!in_sequence) {
	player_sequence = layer_sequence_create("Sequences", x, y, current_sequence);
	layer_sequence_x(player_sequence, x);
	layer_sequence_y(player_sequence, y);
	layer_sequence_xscale(player_sequence, image_xscale * 2);
	layer_sequence_yscale(player_sequence, image_yscale * 2);
}