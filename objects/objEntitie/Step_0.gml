if(is_keyboard_used_debug_overlay() and is_mouse_over_debug_overlay()) exit

if(stopPlayer) exit;

if(actualHealth<=0) instance_destroy();

script_execute(state);