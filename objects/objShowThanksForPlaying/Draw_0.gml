draw_sprite_ext(Pixel,0,0,0,room_width,room_height,0,c_black,1);

draw_align(fa_middle,fa_center);
draw_set_font(fntGame);
draw_set_alpha(alpha);

draw_text_transformed(room_width/2,room_height/2,"You Beat The Game!",2,2,0);

draw_align(fa_top,fa_center);

draw_text_transformed(room_width/2,room_height/2+(64*hudScale),
	"Daniel 'Guarah' - Game Designer\nBabs - Artist\n'Luska' - Programmer"
	,1,1,0);

draw_reset();