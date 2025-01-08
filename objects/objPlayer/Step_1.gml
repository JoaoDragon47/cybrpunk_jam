if(dashTimer>0){
	dashTimer--;
	if(dashTimer<=0){
		canDash=true;
	}
}

if(keyboard_check_pressed(ord("V"))) state=PlayerStateIdle;
if(keyboard_check_pressed(ord("R"))) game_restart()