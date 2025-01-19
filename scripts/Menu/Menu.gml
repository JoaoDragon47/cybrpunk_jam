/// Insta: @jlgamedesign
/// Site: https://linktr.ee/luruska
//
function createMenuPage(){
	///@arg ["NOME", FirstElement, script_to_run...],
	///@arg ["NOME", SecondElement, script_to_run...],
	
	var args, i = 0;
	repeat(argument_count) {
		args[i] = argument[i];
		i++;
	}
	
	var dsGrid = ds_grid_create(5, array_length(args));
	
	i = 0;
	repeat(argument_count) {
		var arr = args[i];
		var arrLen = array_length(arr);
		
		var xx = 0;
		repeat(arrLen) {
			dsGrid[# xx, i] = arr[xx];
			xx++;
		}
		
		i++;
	}
	
	return dsGrid;
}

function drawMenu() {
	
	//VARIÁVEIS
	var ds_grid = menuPages[page], ds_h = ds_grid_height(ds_grid);
	var gw = display_get_gui_width(), gh = display_get_gui_height();
	var mx = device_mouse_x_to_gui(0), my = device_mouse_y_to_gui(0);
	var xbuff = 16*hudScale, ybuff = 48*hudScale;
	var xinicial = (gw/4), yinicial = (gh/2) - (((ds_h-1)/2) * ybuff);
	var c = firstColorOptions;

	//FUNDO
	c = c_black;
	draw_set_alpha(.85);
	draw_rectangle_color(0,0,gw,gh,c,c,c,c,false);
	draw_set_alpha(1);
	
	//LADO ESQUERDO
	draw_set_valign(fa_middle);
	draw_set_halign(fa_right);
	draw_set_font(fntGame);

	//DESENHAR PÁGINA ANTERIOR
	switch page {
		case MenuPage.Credits:
			var dsGridMain = menuPages[MenuPage.Main], dsGridMainH = ds_grid_height(dsGridMain)
			var xTextMain = xinicial - xbuff, yTextMain, xOffTextMain
			yinicial = (gh/2) - (((dsGridMainH-1)/2) * ybuff)
			var yy = 0; repeat(dsGridMainH) {
				yTextMain = yinicial+(ybuff*yy)
				var alfa = .4; c = firstColorOptions
				xOffTextMain = 0
			
				if (menuOption[MenuPage.Main] == yy) {
					c = inputColorOptions
					xOffTextMain = -xbuff
					alfa = 1
				}
			
				draw_text_transformed_color(xTextMain+xOffTextMain,yTextMain,dsGridMain[# 0, yy],hudScale,hudScale,0,c,c,c,c,alfa)
			
				yy++
			}
		
			xinicial = gw/2; yinicial = (gh/2) - (((ds_h-1)/2) * ybuff)
			break;
		
	}

	var lx_txt = xinicial - xbuff, ly_txt, xoff;
	var yy = 0; repeat(ds_h) {
		ly_txt = yinicial+(yy*ybuff);
		c = firstColorOptions;
		xoff = 0;
	
		if menuOption[page] == yy {
			c=inputColorOptions;
			xoff = -(xbuff);
		}
		var xAreaTxt = lx_txt-(string_width(ds_grid[# 0,yy])*hudScale)+xoff;
		var yAreaTxt = ly_txt-(string_height(ds_grid[# 0,yy])*.5*hudScale);
		//draw_rectangle(xAreaTxt,yAreaTxt,lx_txt,yAreaTxt+(string_height(ds_grid[# 0,yy])*hudScale),false);
		//if (point_in_rectangle(mx,my,xAreaTxt,yAreaTxt,lx_txt,yAreaTxt+(string_height(ds_grid[# 0,yy])*hudScale))) {
		//	if (menuOption[page] != yy) {
		//		menuOption[page] = yy;
				
		//		audio_play_sound(sndUIOption1,5,false);
		//	}
			
		//	if (mouse_check_button_pressed(mb_left)) {
		//		switch (ds_grid[# 1, menuOption[page]]) {
		//			case MenuElementType.ScriptRunner:
		//				//audio_play_sound(sndUIAccept,5,false,1,0,random_range(.9,1.15));
		//				script_execute(ds_grid[# 2, menuOption[page]]);
		//				break;
		//			case MenuElementType.PageTransfer:
		//				var lastPage = page
		//				page = ds_grid[# 2, menuOption[page]];
		//				audio_play_sound(sndUIPageBack,5,false,1,0,random_range(.9,1.15));
		//				if (page > lastPage) {
		//					menuOption[page] = 0;
		//				}
		//				break;
		//			case MenuElementType.Slider:
		//			case MenuElementType.Shift:
		//			case MenuElementType.Input:
		//			case MenuElementType.Toggle:
		//				audio_play_sound(sndUIOption1,5,false,1,0,random_range(.9,1.15));
		//				inputting = !inputting;
		//				break;
		//			case MenuElementType.Warning:
		//				audio_play_sound(sndUIPageBack,5,false,1,0,random_range(.9,1.15));
		//				inputting = !inputting;
		//				break;
		//		}
		//	}
		//}
		draw_text_transformed_color(lx_txt+xoff, ly_txt, ds_grid[# 0, yy],hudScale,hudScale,0,c,c,c,c,1);
		yy++;
	}
	
	//DIVISÓRIA
	switch page {
		case MenuPage.Credits:
			c = firstColorOptions;
			draw_line_width_color(xinicial,yinicial-ybuff,xinicial,ly_txt+ybuff,2*hudScale,c,c);
			break;
	}
	
	//LADO DIREITO
	draw_set_halign(fa_left);
	
	var rx_txt = xinicial + xbuff, ry_txt;
	yy = 0; repeat(ds_h) {
		ry_txt = yinicial+(yy*ybuff);
		c = firstColorOptions;
		var currentValue, currentOptions, buff_text, currentArray;
		var str_value;
		var c1 = c, c2 = c1;
		switch (ds_grid[# 1, yy]) {
			case MenuElementType.Shift:
				currentValue = ds_grid[# 3, yy];
				currentArray = ds_grid[# 4, yy];
				var l_shift = "<< ";
				var r_shift = " >>";
				
				if (currentValue == 0) {l_shift = ""}
				if (currentValue == array_length(currentArray)-1) {r_shift = ""}
				
				if (inputting and yy == menuOption[page]) {c = inputColorOptions}
				draw_text_transformed_color(rx_txt,ry_txt,l_shift+currentArray[currentValue]+r_shift,hudScale,hudScale,0,c,c,c,c,1);
				break;
			
			case MenuElementType.Slider:
				var len = 64*hudScale;
				currentValue = ds_grid[# 3, yy];
				currentArray = ds_grid[# 4, yy];
				var circle_pos = (currentValue - currentArray[0]) / ((currentArray[array_length(currentArray)-1] - currentArray[0]));
				c = firstColorOptions;
				
				draw_line_width_color(rx_txt, ry_txt, rx_txt+len, ry_txt, 2*hudScale, c,c);
				
				if (inputting and yy == menuOption[page]) {c = inputColorOptions}
				draw_circle_color(rx_txt + (circle_pos*len),ry_txt, 4*hudScale, c,c,false);
				draw_text_transformed_color(rx_txt + (len*1.2), ry_txt,string(floor(circle_pos*100))+"%",hudScale,hudScale,0,c,c,c,c,1);
				break;
			
			case MenuElementType.Toggle:
				var buff = 64*hudScale;
				currentValue = ds_grid[# 3, yy];
				currentArray = ds_grid[# 4, yy];
				c = firstColorOptions;
				
				if (inputting and yy == menuOption[page]) {c = inputColorOptions}
				if currentValue == 0 {
					c1 = c;
					c2 = c_dkgray;
				} else {
					c1 = c_dkgray;
					c2 = c;
				}
				
				draw_text_transformed_color(rx_txt, ry_txt,currentArray[0],hudScale,hudScale,0,c1,c1,c1,c1,1);
				draw_text_transformed_color(rx_txt+buff, ry_txt,currentArray[1],hudScale,hudScale,0,c2,c2,c2,c2,1);
				
				break;
			
			case MenuElementType.Input:
				currentValue = ds_grid[# 3, yy];
				
				switch (currentValue) {
					case vk_up: str_value = "seta_cima"; break;
					case vk_down: str_value = "seta_baixo"; break;
					case vk_right: str_value = "seta_direita"; break;
					case vk_left: str_value = "seta_esquerda"; break;
					case vk_shift:
					case vk_lshift: str_value = "Shift"; break;
					case vk_control:
					case vk_lcontrol: str_value = "Ctrl"; break;
					case vk_space: str_value = "espaco"; break;
					case vk_backspace: str_value = "Backspace"; break;
					case vk_add: str_value = "+"; break;
					case vk_subtract: str_value = "-"; break;
					case vk_multiply: str_value = "*"; break;
					case vk_divide: str_value = "/"; break;
					case vk_alt:
					case vk_lalt: str_value = "Alt"; break;
					case vk_delete: str_value = "Delete"; break;
					case vk_end: str_value = "End"; break;
					case vk_home: str_value = "Home"; break;
					case vk_tab: str_value = "Tab"; break;
					case vk_pagedown: str_value = "Page Down"; break;
					case vk_pageup: str_value = "Page Up"; break;
					case vk_decimal: str_value = ","; break;
					case vk_numpad0: str_value = "Num 0"; break;
					case vk_numpad1: str_value = "Num 1"; break;
					case vk_numpad2: str_value = "Num 2"; break;
					case vk_numpad3: str_value = "Num 3"; break;
					case vk_numpad4: str_value = "Num 4"; break;
					case vk_numpad5: str_value = "Num 5"; break;
					case vk_numpad6: str_value = "Num 6"; break;
					case vk_numpad7: str_value = "Num 7"; break;
					case vk_numpad8: str_value = "Num 8"; break;
					case vk_numpad9: str_value = "Num 9"; break;
					default: str_value = chr(currentValue); break;
				}
				
				c = firstColorOptions;
				draw_text_transformed_color(rx_txt,ry_txt,str_value,hudScale,hudScale,0,c,c,c,c,1);
				
				if (inputting and yy == menuOption[page]) {
					c = c_black;
					draw_set_alpha(.5);
					draw_rectangle_color(0,0,gw,gh,c,c,c,c,false);
					draw_set_alpha(1);
					
					c = c_white;
					draw_set_halign(fa_center);
					draw_text_transformed_color(gw/2,gh/2,"Insira uma nova tecla",hudScale,hudScale,0,c,c,c,c,1);
					draw_text_transformed_color(gw/2,gh/2+ybuff,"> "+ string(str_value) + " <",hudScale,hudScale,0,c,c,c,c,1);
					draw_set_halign(fa_left);
				}
				
				break;
			case MenuElementType.Warning:
				if inputting {
					currentValue = ds_grid[# 3, yy];
					currentOptions = ds_grid[# 4, yy];
					buff_text = 64*hudScale; c = firstColorOptions;
					c1 = c; c2 = c1;
					var wquad = 400*hudScale, hquad = 240*hudScale;
					var xquad = gw/2 - wquad/2, yquad = gh/2 - hquad/2;
					
					if currentValue == 0 {
						c1 = inputColorOptions; c2 = c;
					} else {
						c1 = c; c2 = inputColorOptions;
					}
					
					draw_set_color(firstColorOptions);
					draw_set_alpha(.6);
					draw_rectangle(0,0,gw,gh,false);
					draw_set_alpha(1);
					draw_set_color(c_black);
					draw_rectangle(xquad,yquad,xquad+wquad,yquad+hquad,false);
				
					var ytxt = yquad+hquad-buff_text;
					draw_set_halign(fa_center);
					draw_text_transformed_color(gw/2,gh/2,"Want leave?",hudScale,hudScale,0,c,c,c,c,1);
					draw_text_transformed_color(gw/2-buff_text,ytxt,currentOptions[0],hudScale,hudScale,0,c1,c1,c1,c1,1);
					draw_text_transformed_color(gw/2+buff_text,ytxt,currentOptions[1],hudScale,hudScale,0,c2,c2,c2,c2,1);
				}
				break;
		}
		
		yy++;
	}
	
	//RESET
	draw_set_valign(-1);draw_set_halign(-1);
	draw_set_font(-1);
}

function setFullscreenMode() {
	window_set_fullscreen(!window_get_fullscreen())
}

function startGame() {
	instance_create_layer(0,0,"fade",objFadeTransitionRoom,{
		destiny : stage1,
		transitionSpeed : .05
	})
}

function resumeGame() {
	global.pause = false;
	stopPlayer = global.pause;
	instance_destroy();
}

function exitGame() {
	game_end()
}

function changeGameVolume() {
	var value = argument[0]
	
	switch menuOption[page] {
		default: audio_master_gain(value) break;
	}
}

//function changeGameResolution() {
//	var value = argument[0]
//	resolutionValue = value
//	var size
//	switch value {
//		default: size = 384; break;
//		case 1: size = 768; break;
//		case 2: size = 1536; break;
//	}
//	view_set_wport(view_camera[0],size);
//	view_set_hport(view_camera[0],size);
//	display_set_gui_size(size,size);
//	window_set_size(size,size);
//	hudScale = view_get_wport(view_camera[0])/GUI_WIDTH
//}