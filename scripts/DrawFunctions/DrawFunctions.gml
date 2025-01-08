function draw_align(_v=fa_top,_h=fa_left){
	draw_set_valign(_v);
	draw_set_halign(_h);
}

function draw_reset(){
	draw_set_valign(-1);
	draw_set_halign(-1);
	draw_set_font(-1);
	draw_set_color(c_white);
	draw_set_alpha(1);
}