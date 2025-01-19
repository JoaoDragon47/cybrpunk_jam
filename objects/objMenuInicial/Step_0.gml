#region INPUTS
var k_up = keyboard_check_pressed(ord("W"))
var k_down = keyboard_check_pressed(ord("S"))
var k_right = keyboard_check_pressed(ord("D"))
var k_left = keyboard_check_pressed(ord("A"))
var k_enter = keyboard_check_released(vk_enter) or keyboard_check_released(vk_space)
var k_escape = keyboard_check_pressed(vk_escape)
#endregion

var ds_grid = menuPages[page], ds_h = ds_grid_height(ds_grid);
var input = k_down - k_up;
	
if !inputting {
	
	if input != 0 {
		menuOption[page]+=input;
		
		//audio_play_sound(sndUIOption1,5,false);
		
		if menuOption[page] >= ds_h {menuOption[page] = 0}
		if menuOption[page] < 0 {menuOption[page] = ds_h-1}
	}
	
	if k_enter {
		switch (ds_grid[# 1, menuOption[page]]) {
			case MenuElementType.ScriptRunner:
				script_execute(ds_grid[# 2, menuOption[page]]);
				break;
			case MenuElementType.PageTransfer:
				var lastPage = page
				page = ds_grid[# 2, menuOption[page]];
				//audio_play_sound(sndUIPageBack,5,false,1,0,random_range(.9,1.15));
				if (page > lastPage) {
					menuOption[page] = 0;
				}
				break;
			case MenuElementType.Slider:
			case MenuElementType.Shift:
			case MenuElementType.Input:
			case MenuElementType.Toggle:
				//audio_play_sound(sndUIOption1,5,false,1,0,random_range(.9,1.15));
				inputting = !inputting;
				break;
			case MenuElementType.Warning:
				//audio_play_sound(sndUIPageBack,5,false,1,0,random_range(.9,1.15));
				inputting = !inputting;
				break;
		}
	}
	
	if k_escape {
		//audio_play_sound(sndUIPageBack,5,false,1,0,random_range(.9,1.15));
		
		switch page {
			case MenuPage.Credits:
				page = MenuPage.Main;
				break;
		}
	}
} else {
	if k_enter {
		switch ds_grid[# 1, menuOption[page]] {
			default:
				inputting = !inputting;
				break;
			case MenuElementType.Warning:
				if ds_grid[# 3, menuOption[page]] == 0 {
					script_execute(ds_grid[# 2, menuOption[page]]);
				} else {
					//audio_play_sound(sndUIOption1,5,false);
					inputting = !inputting;
				}
				break;
		}
	}
	
	if k_escape {
		//audio_play_sound(sndUIPageBack,5,false);
		
		inputting = !inputting;
	}
}
	
if inputting {
	input = k_right - k_left;
	if input != 0 {
		var current_value, current_options, current_array
		switch (ds_grid[# 1, menuOption[page]]) {
			case MenuElementType.Shift:
				current_value = ds_grid[# 3, menuOption[page]];
				current_array = ds_grid[# 4, menuOption[page]];
				
				current_value+=input;
				
				current_value = clamp(current_value, 0,array_length(current_array)-1);
			
				if ds_grid[# 3, menuOption[page]] != current_value {
					//audio_play_sound(sndUIOption1,5,false);
					script_execute(ds_grid[# 2, menuOption[page]], current_value);
				}
				
				ds_grid[# 3, menuOption[page]] = current_value;
				break;
				
			case MenuElementType.Slider:
				ds_grid[# 3, menuOption[page]] += (.1 * input);
				ds_grid[# 3, menuOption[page]] = clamp(ds_grid[# 3, menuOption[page]], 0, 1);
				
				//audio_play_sound(sndUIOption1,5,false);
				script_execute(ds_grid[# 2, menuOption[page]], ds_grid[# 3, menuOption[page]]);
				
				break;
					
			case MenuElementType.Toggle:
				current_value = ds_grid[# 3, menuOption[page]];
				current_array = ds_grid[# 4, menuOption[page]];
				
				current_value+=input;
				
				current_value = clamp(current_value, 0,array_length(current_array)-1);
			
				if ds_grid[# 3, menuOption[page]] != current_value {
					//audio_play_sound(sndUIOption1,5,false);
					script_execute(ds_grid[# 2, menuOption[page]], current_value);
				}
				
				ds_grid[# 3, menuOption[page]] = current_value;
				break;
			case MenuElementType.Warning:
				current_value = ds_grid[# 3, menuOption[page]];
				current_options = ds_grid[# 4, menuOption[page]];
					
				current_value+=input;
				current_value = clamp(current_value, 0, 1);
				
				if (current_value != ds_grid[# 3, menuOption[page]]) {
					//audio_play_sound(sndUIOption1,5,false);
				}
				
				ds_grid[# 3, menuOption[page]] = current_value;
				break;
		}
	}
}