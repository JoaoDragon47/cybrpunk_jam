var gw=display_get_gui_width(),gh=display_get_gui_height();
var mx=device_mouse_x_to_gui(0),my=device_mouse_y_to_gui(0);
var grid=biomonsArray[option],hGrid=ds_grid_height(grid);

draw_set_font(fntGame);

draw_sprite_ext(Pixel,0,0,0,gw,gh,0,c_black,1);

var _wList=192*hudScale;
var _hList=gh;
draw_line_width(_wList,0,_wList,_hList,4);

var _wMarginList=32*hudScale,_hMarginList=64*hudScale;
var _wBiomonItemListArea=_wList-(2*_wMarginList),_hBiomonItemListArea=48*hudScale;
var _bufferBiomonItemList=16*hudScale;
var xOff=0,_color=c_white,_alpha=1;
var i=0;repeat(BiomonsTypes.Height){
	var _xBiomonType=_wMarginList;
	var _yBiomonType=_hMarginList+(_hBiomonItemListArea*i)+(_bufferBiomonItemList*i);
	xOff=0;_color=c_gray;_alpha=1;
	
	if(option==i){
		xOff=16*hudScale;
		_color=c_gray;
		_alpha=.6;
	}
	
	if(point_in_rectangle(mx,my,_xBiomonType+xOff,_yBiomonType,_xBiomonType+xOff+_wBiomonItemListArea,_yBiomonType+_hBiomonItemListArea)){
		if(mouse_check_button_pressed(mb_left)){
			option=i;
		}
	}
	
	draw_sprite_ext(Pixel,0,_xBiomonType+xOff,_yBiomonType,_wBiomonItemListArea,_hBiomonItemListArea,0,_color,_alpha);
	
	i++;
}

var _xCenterSlot=((gw-_wList)/2)+_wList;
var _wBiomonSlot=96*hudScale,_hBiomonSlot=128*hudScale;
var _bufferBiomonSlot=32*hudScale;
var _xBiomonSlotInitial=_xCenterSlot-((hGrid/2)*_wBiomonSlot)-(((hGrid-1)/2)*_bufferBiomonSlot),_yBiomonSlotInitial=(gh/2)-(_hBiomonSlot/2);
i=0;repeat(hGrid){
	var _xBiomonSlot=_xBiomonSlotInitial+(_wBiomonSlot*i)+(_bufferBiomonSlot*i);
	var _yBiomonSlot=_yBiomonSlotInitial;
	_color=c_gray;_alpha=1;
	
	if(arrayOptions[option]==i){
		_alpha=.6;
	}
	
	if(point_in_rectangle(mx,my,_xBiomonSlot,_yBiomonSlot,_xBiomonSlot+_wBiomonSlot,_yBiomonSlot+_hBiomonSlot)){
		_alpha=.6;
		if(mouse_check_button_pressed(mb_left)){
			if(arrayOptions[option]!=i){
				if(biomonsSelected<3){
					arrayOptions[option]=i;
					if(ds_map_find_value(biomonSlots,$"Slot{string(option)}")==undefined){
						biomonsSelected++;
						ds_map_add(biomonSlots,$"Slot{string(option)}",option);
					}
				}else{
					if(ds_map_find_value(biomonSlots,$"Slot{string(option)}")!=undefined){
						arrayOptions[option]=i;
					}
				}
			}else{
				arrayOptions[option]=-1;
				if(ds_map_find_value(biomonSlots,$"Slot{string(option)}")!=undefined){
					biomonsSelected--;
					ds_map_delete(biomonSlots,$"Slot{string(option)}");
				}
			}
		}
	}
	
	draw_sprite_ext(Pixel,0,_xBiomonSlot,_yBiomonSlot,_wBiomonSlot,_hBiomonSlot,0,_color,_alpha);
	draw_set_valign(fa_middle);draw_set_halign(fa_center);
	draw_text(_xBiomonSlot+(_wBiomonSlot/2),_yBiomonSlot+(_hBiomonSlot/2),grid[# 0,i]);
	
	
	i++;
}

var _wReadyButton=64*hudScale,_hReadyButton=32*hudScale;
var _xReadyButton=_xCenterSlot-(_wReadyButton/2),_yReadyButton=gh-_hMarginList-_hReadyButton;
_alpha=1;

if(biomonsSelected>=3){
	if(point_in_rectangle(mx,my,_xReadyButton,_yReadyButton,_xReadyButton+_wReadyButton,_yReadyButton+_hReadyButton)){
		_alpha=.6;
		if(mouse_check_button_pressed(mb_left)){
			var _biomon=ds_map_find_first(biomonSlots);
			i=0;repeat(ds_map_size(biomonSlots)){
				var _index=ds_map_find_value(biomonSlots,_biomon);
				var _grid=biomonsArray[_index];
				var _slot=arrayOptions[_index];
				var _variableName=_grid[# 2,_slot];
				var _value=_grid[# 1,_slot];
				
				struct_set(global.PlayerStats,_variableName,_value)
				
				_biomon=ds_map_find_next(biomonSlots,_biomon);
				i++;
			}
			
			//instance_create_layer(35,1968,"entities",objPlayer);
			//instance_activate_object(objPlayer);
			with(objPlayer){
				maxHealth=global.PlayerStats.vida;
				actualHealth=maxHealth;
				
				walkSpd=global.PlayerStats.walkSpd;
				spd=walkSpd;
				
				jumpSpd=global.PlayerStats.jumpSpd;	
				
				shieldBaseDamageFront=global.PlayerStats.shieldDamageFront;
				shieldBaseDamageBack=global.PlayerStats.shieldDamageBack;
				
				attackBaseDamage=global.PlayerStats.swordDamage;
			}
			
			stopPlayer=false;
			
			instance_destroy();
		}
	}
}

draw_set_valign(fa_middle);draw_set_halign(fa_center);
draw_sprite_ext(Pixel,0,_xReadyButton,_yReadyButton,_wReadyButton,_hReadyButton,0,c_gray,_alpha);
draw_text(_xReadyButton+(_wReadyButton/2),_yReadyButton+(_hReadyButton/2),"Ready!");

draw_set_valign(-1);draw_set_halign(-1);
draw_set_font(-1);