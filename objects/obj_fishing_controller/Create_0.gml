state = "select";

selected_bait = 0;

current_bait = undefined;
current_fish = undefined;

cast_timer = 0;
waiting_timer = 0;

bite_timer = 0;
bite_window = 1;

reel_start_x = 0;
reel_start_y = 0;

mash_count = 0;
mash_target = 0;
mash_timer = 0;
mash_duration = 3;

result_text = "";

bobber_instance = noone;

// Position of the rod tip
rod_x = 233;
rod_y = 176;

// Position where the bobber lands
bobber_target_x = 300;
bobber_target_y = 200;

// Casting animation
cast_timer = 0;
cast_duration = 0.7;
cast_arc_height = 70;

if (!variable_global_exists("fish_compendium")) {
    global.fish_compendium = [];
}

if (!variable_global_exists("fishing_score")) {
    global.fishing_score = 0;
}

if (!variable_global_exists("bait_inventory")) {
    global.bait_inventory = [];
}

get_bait_rarity = function(_bait_id) {
    switch (_bait_id) {
        case "worm":
            return 0;

        case "rock":
            return 0;

        case "glasses":
            return 1;
			
		case "BBag":
            return 1;
			
		case "spider":
            return 0;
		
		case "bread":
            return 1;
			
		case "book":
            return 1;
		
		case "bottle":
            return 3;
			
		case "poster":
            return 2;

        case "battery":
            return 2;

        case "coin":
            return 3;
			
		case "realworm":
            return 3;
			
		case "wok":
            return 2;
    }

    return 0;
};

get_fish_by_id = function(_id)
{
    for (var i = 0; i < array_length(global.fish); i++)
    {
        if (global.fish[i].id == _id)
            return global.fish[i];
    }

    return undefined;
};

get_fish_from_bait = function(_bait_id)
{
    switch (_bait_id)
    {
        case "worm":
			return get_fish_by_id("common_fish");
			
        case "spider":
            return get_fish_by_id("common_fish");

        case "rock":
            return get_fish_by_id("rock_fish");

        case "BBag":
            return get_fish_by_id("diva");

        case "glasses":
            return get_fish_by_id("eye_fish");

        case "realworm":
            return get_fish_by_id("real_fish");

        case "battery":
            return get_fish_by_id("robot_fish");

        case "coin":
            return get_fish_by_id("pig_fish");

        case "poster":
            return get_fish_by_id("wester_fish");

        case "bottle":
            return get_fish_by_id("gold_fish");

        case "wok":
            return get_fish_by_id("sushi_fish");

        case "book":
            return get_fish_by_id("old_fish");

        case "bread":
            return get_fish_by_id("bread_fish");
    }

    return get_fish_by_id("unendified");
};

register_caught_fish = function(_fish)
{
    global.fishing_score += _fish.points;

    for (var i = 0; i < array_length(global.fish_compendium); i++)
    {
        if (global.fish_compendium[i].id == _fish.id)
        {
            global.fish_compendium[i].caught_count++;
            return;
        }
    }

    var new_entry = {
        id: _fish.id,
        caught_count: 1
    };

    array_push(global.fish_compendium, new_entry);
};

draw_set_font(fnt_text);