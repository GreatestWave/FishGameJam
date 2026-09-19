if (visible && is_in_water) {
    bob_time += 0.08;

    if (is_biting) {
        // Strong movement during bite
        y = water_y + sin(bob_time * 4) * 6;
    } else {
        // Gentle movement while waiting
        y = water_y + sin(bob_time) * 2;
    }
}