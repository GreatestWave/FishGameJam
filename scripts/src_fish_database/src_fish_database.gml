// scr_fish_database

global.fish = [
    {
        id: "common_fish",
				name: "Common Fish",
				description: "Well it's a fish, an avarage Joe from the fish world",
				sprite: spr_commonfish,
				rarity: 0,
				points: 10
    },

    {
        id: "rock_fish",
                name: "Rock fish",
                description: "I wonder what's their music taste is",
                sprite: spr_rockfish,
                rarity: 0,
                points: 20
    },

    {
		id: "diva",
				name: "Diva",
                description: "It's looks at me funny",
                sprite: spr_beauty_fish,
                rarity: 1,
                points: 30
    },
	
	{	
		id: "eye_fish",
				name: "Fisheye",
                description: "Woah, you're looking for something?",
                sprite: spr_eyefish,
                rarity: 1,
                points: 40
	},
	
	{	
		id: "real_fish",
				name: "Fish?",
                description: "What the hell is this?",
                sprite: spr_realfish,
                rarity: 3,
                points: 100
	},
	
	{	
		id: "robot_fish",
				name: "Robot fish",
                description: "Is this even a fish?",
                sprite: spr_robot,
                rarity: 2,
                points: 60
	},
	
	{	
		id: "pig_fish",
				name: "Phishie bank",
                description: "Wow this means I'm rich now?!",
                sprite: spr_pigfish,
                rarity: 3,
                points: 200
	},
	
	{	
		id: "wester_fish",
				name: "Gill Fishstwood",
                description: "Is that the legendary aquatic desperado?! Better toss it into the water before noon",
                sprite: spr_westernfish,
                rarity: 3,
                points: 100
	},
	
	{	
		id: "gold_fish",
				name: "Gold fish",
                description: "What a beauty, it shines so bright",
                sprite: spr_goldenfish,
                rarity: 3,
                points: 200
	},
	
	{	
		id: "sushi_fish",
				name: "Sushi fish",
                description: "Now that is one gourmet fish",
                sprite: spr_sushi,
                rarity: 2,
                points: 50
	},
	
	{	
		id: "old_fish",
				name: "Ol'fish",
                description: "Are fish retirnment houses a real thing?",
                sprite: spr_oldfish,
                rarity: 1,
                points: 50
	},
	
	{	
		id: "bread_fish",
				name: "Bread fish",
                description: "Damn it all soaked, look delicious tho",
                sprite: spr_breadfish,
                rarity: 1,
                points: 40
	},
	
	{	
		id: "unendified",
				name: "???",
		        description: "I don't really know how I hooked this",
		        sprite: spr_realfish,
		        rarity: 0,
		        points: 5
	}
];

get_fish_by_id = function(_id)
{
    for (var i = 0; i < array_length(global.fish); i++)
    {
        if (global.fish[i].id == _id)
        {
            return global.fish[i];
        }
    }

    return undefined;
};