event_inherited();
draw_align(fa_middle,fa_left);
//draw_text(bbox_right+2,y-(sprite_height/2),string_delete(script_get_name(state),1,11));
//draw_text(bbox_right+2,y-(sprite_height/2),dir)
if(attackCharge>0){
	draw_healthbar(x-12,bbox_top-14,x+12,bbox_top-6,(attackCharge/minAttackCharge2)*100,c_dkgray,c_green,c_red,0,true,true);
	draw_set_color(c_yellow);
	draw_line_width(x-(12*minAttackCharge1/minAttackCharge2),bbox_top-15,x-(12*minAttackCharge1/minAttackCharge2),bbox_top-7,1);
	draw_set_color(c_red);
	draw_line_width(x+12,bbox_top-15,x+12,bbox_top-7,1);
}
if(shieldCharge>0){
	draw_healthbar(x-12,bbox_top-14,x+12,bbox_top-6,(shieldCharge/(minShieldCharge+10))*100,c_dkgray,c_green,c_red,0,true,true);
}
//if(shield.defend){
//	draw_align(fa_bottom,fa_center);
//	draw_text(x,bbox_top-24,"Defesa ON");
//}

draw_reset();