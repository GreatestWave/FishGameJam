rows = 4;
cols = 3;

selected_row = 0;
selected_col = 0;

menu = [
    ["common_fish",   "rock_fish",    "diva"],
    ["eye_fish",    "real_fish",   "robot_fish"],
    ["pig_fish",    "wester_fish",  "gold_fish"],
    ["sushi_fish",  "old_fish",  "bread_fish"]
];

if (!variable_global_exists("fish_compendium"))
{
    global.fish_compendium = [];
}

get_fish_by_id = function(_id)
{
    for (var i = 0; i < array_length(global.fish); i++)
    {
        if (global.fish[i].id == _id)
            return global.fish[i];
    }

    return undefined;
};

get_fish_caught_count = function(_fish_id)
{
    for (var i = 0; i < array_length(global.fish_compendium); i++)
    {
        if (global.fish_compendium[i].id == _fish_id)
        {
            return global.fish_compendium[i].caught_count;
        }
    }

    return 0;
};