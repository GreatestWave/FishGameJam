// Prevent duplicate audio managers
if (instance_number(obj_audio_manager) > 1) {
    instance_destroy();
    exit;
}

// Keep this object between rooms
persistent = true;

// Start looping music
music_instance = audio_play_sound(
    snd_music,
    0,
    true
);

// Music volume: 0 to 1
audio_sound_gain(
    music_instance,
    0.4,
    0
);