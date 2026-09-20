// Makes random results different after every game launch
randomize();

// Size of one spawn cell
grid_size = 32;

// Distance from room borders
spawn_margin = 48;

// Number of items on the level
minimum_items = 8;
maximum_items = 14;

// Maximum number of attempts to find a free position
maximum_attempts = 200;

// Item definitions
item_types = [
    {
        id: "worm",
        name: "Worm",
        sprite: spr_worm,
        weight: 30
    },
	{
        id: "spider",
        name: "Spider",
        sprite: spr_spider,
        weight: 30
    },
	{
        id: "rock",
        name: "Rock",
        sprite: spr_rock,
        weight: 20
    },
	{
        id: "bread",
        name: "Bread",
        sprite: spr_bread,
        weight: 20
    },
	{
        id: "book",
        name: "Book",
        sprite: spr_book,
        weight: 20
    },
	{
        id: "bottle",
        name: "Treasure map",
        sprite: spr_bottle,
        weight: 5
    },
	{
        id: "glasses",
        name: "Glasses",
        sprite: spr_glasses,
        weight: 15
    },
	{
        id: "BBag",
        name: "Cosmetical Bag",
        sprite: spr_BBag,
        weight: 15
    },
	{
        id: "realworm",
        name: "Worm?",
        sprite: spr_realworm,
        weight: 5
    },
	{
        id: "coin",
        name: "Coin",
        sprite: spr_coin,
        weight: 5
    },
	{
        id: "wok",
        name: "Box and chopsticks",
        sprite: spr_wok,
        weight: 15
    },
	{
        id: "poster",
        name: "Wanted poster",
        sprite: spr_poster,
        weight: 10
    },
	{
        id: "battery",
        name: "Battery",
        sprite: spr_battery,
        weight: 15
    },
];

choose_random_item = function() {
    var total_weight = 0;

    // Calculate total weight
    for (var i = 0; i < array_length(item_types); i++) {
        total_weight += item_types[i].weight;
    }

    // Random number within total weight
    var random_roll = random(total_weight);
    var current_weight = 0;

    // Find selected item
    for (var i = 0; i < array_length(item_types); i++) {
        current_weight += item_types[i].weight;

        if (random_roll < current_weight) {
            return item_types[i];
        }
    }

    // Fallback
    return item_types[0];
};

is_spawn_position_free = function(_x, _y) {
    var check_radius = 10;

    // Don't spawn inside walls
    if (collision_circle(
        _x,
        _y,
        check_radius,
        obj_wall,
        false,
        true
    ) != noone) {
        return false;
    }

    // Don't spawn on the player
    if (collision_circle(
        _x,
        _y,
        check_radius,
        obj_player,
        false,
        true
    ) != noone) {
        return false;
    }

    // Don't spawn on another item
    if (collision_circle(
        _x,
        _y,
        check_radius,
        obj_item,
        false,
        true
    ) != noone) {
        return false;
    }

    return true;
};

spawn_items = function() {
    var target_amount = irandom_range(
        minimum_items,
        maximum_items
    );

    var spawned_amount = 0;
    var attempts = 0;

    while (
        spawned_amount < target_amount
        && attempts < maximum_attempts
    ) {
        attempts++;

        // Random grid coordinates
        var grid_x = irandom_range(
            ceil(spawn_margin / grid_size),
            floor((room_width - spawn_margin) / grid_size)
        );

        var grid_y = irandom_range(
            ceil(spawn_margin / grid_size),
            floor((room_height - spawn_margin) / grid_size)
        );

        // Convert grid coordinates into room coordinates
        var spawn_x = grid_x * grid_size
                    + grid_size / 2;

        var spawn_y = grid_y * grid_size
                    + grid_size / 2;

        // Create item only if the position is free
        if (is_spawn_position_free(spawn_x, spawn_y)) {
            var selected_item = choose_random_item();

            var new_item = instance_create_layer(
                spawn_x,
                spawn_y,
                "Items",
                obj_item
            );

            new_item.item_id = selected_item.id;
            new_item.item_name = selected_item.name;
            new_item.sprite_index = selected_item.sprite;

			var target_width  = 48;
			var target_height = 48;

			var item_w = sprite_get_width(new_item.sprite_index);
			var item_h = sprite_get_height(new_item.sprite_index);

		
			var item_scale = min(
			    target_width / item_w,
			    target_height / item_h
);

new_item.image_xscale = item_scale;
new_item.image_yscale = item_scale;

            spawned_amount++;
        }
    }

    show_debug_message(
        "Spawned items: "
        + string(spawned_amount)
        + " / "
        + string(target_amount)
    );
};

// Generate items
spawn_items();



