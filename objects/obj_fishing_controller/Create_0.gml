

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

get_fish_from_bait = function(_bait_id) {
    switch (_bait_id) {
        case "worm":
            return {
				id: "common_fish",
                name: "Common Fish",
                description: "Well it's a fish, an avarage Joe from the fish world",
                sprite: spr_commonfish,
                rarity: 0,
                points: 10
            };
		case "spider":
            return {
				id: "common_fish",
                name: "Common Fish",
                description: "Well it's a fish, an avarage Joe from the fish world",
                sprite: spr_commonfish,
                rarity: 0,
                points: 10
            };
		case "rock":
            return {
				id: "rock_fish",
                name: "Rock fish",
                description: "I wonder what's their music taste is",
                sprite: spr_rockfish,
                rarity: 0,
                points: 20
            };
		case "BBag":
            return {
                name: "Diva",
				id: "diva",
                description: "It's looks at me funny",
                sprite: spr_beauty_fish,
                rarity: 1,
                points: 30
            };
		case "glasses":
            return {
                name: "Fisheye",
				id: "eye_fish",
                description: "Woah, you're looking for something?",
                sprite: spr_eyefish,
                rarity: 1,
                points: 40
            };
		case "realworm":
            return {
                name: "Fish?",
				id: "real_fish",
                description: "What the hell is this?",
                sprite: spr_realfish,
                rarity: 3,
                points: 100
            };
		case "battery":
            return {
                name: "Robot fish",
				id: "robot_fish",
                description: "Is this even a fish?",
                sprite: spr_robot,
                rarity: 2,
                points: 60
            };
		case "coin":
            return {
                name: "Phishie bank",
				id: "pig_fish",
                description: "Wow this means I'm rich now?!",
                sprite: spr_pigfish,
                rarity: 3,
                points: 200
            };
		case "poster":
            return {
                name: "Gill Fishstwood",
				id: "wester_fish",
                description: "Is that the legendary aquatic desperado?! Better toss it into the water before noon",
                sprite: spr_westernfish,
                rarity: 3,
                points: 100
            };
		case "bottle":
            return {
                name: "Gold fish",
				id: "gold_fish",
                description: "What a beauty, it shines so bright",
                sprite: spr_goldenfish,
                rarity: 3,
                points: 200
            };
		case "wok":
            return {
                name: "Sushi fish",
				id: "sushi_fish",
                description: "Now that is one gourmet fish",
                sprite: spr_sushi,
                rarity: 2,
                points: 50
            };
		case "book":
            return {
                name: "Ol'fish",
				id: "old_fish",
                description: "Are fish retirnment houses a real thing?",
                sprite: spr_oldfish,
                rarity: 1,
                points: 50
            };
		case "bread":
            return {
                name: "Bread fish",
				id: "bread_fish",
                description: "Damn it all soaked, look delicious tho",
                sprite: spr_breadfish,
                rarity: 1,
                points: 40
            };
    }

    return {
        name: "???",
        description: "I don't really know how I hooked this",
        sprite: spr_realfish,
        rarity: 0,
        points: 5
    };
};
register_caught_fish = function(_fish) {
    // Check whether this fish is already unlocked
    for (
        var i = 0;
        i < array_length(global.fish_compendium);
        i++
    ) {
        if (global.fish_compendium[i].id == _fish.id) {
            global.fish_compendium[i].caught_count++;
            return;
        }
    }

    // This is the first catch of this fish
    var new_entry = {
        id: _fish.id,
        name: _fish.name,
        description: _fish.description,
        sprite: _fish.sprite,
        rarity: _fish.rarity,
        points: _fish.points,
        caught_count: 1
    };

    array_push(
        global.fish_compendium,
        new_entry
    );
};