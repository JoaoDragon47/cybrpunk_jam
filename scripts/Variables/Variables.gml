randomize();

#region MACROS

#macro GRAVITY .24
#macro DELTA game_get_speed(gamespeed_fps)

#endregion

#region GLOBALVARS
globalvar Inputs;
Inputs={
	right:		ord("D"),
	left:		ord("A"),
	jump:		vk_space,
	dash:		vk_shift,
	attack:		mb_left,
	shield:		mb_right
}

globalvar InputsFunctions;
InputsFunctions={
	HoldRight:			function(){return keyboard_check(Inputs.right)},
	HoldLeft:			function(){return keyboard_check(Inputs.left)},
	HoldJump:			function(){return keyboard_check(Inputs.jump)},
	HoldDash:			function(){return keyboard_check(Inputs.dash)},
	HoldAttack:			function(){return mouse_check_button(Inputs.attack)},
	HoldShield:			function(){return mouse_check_button(Inputs.shield)},
	PressRight:			function(){return keyboard_check_pressed(Inputs.right)},
	PressLeft:			function(){return keyboard_check_pressed(Inputs.left)},
	PressJump:			function(){return keyboard_check_pressed(Inputs.jump)},
	PressDash:			function(){return keyboard_check_pressed(Inputs.dash)},
	PressAttack:		function(){return mouse_check_button_pressed(Inputs.attack)},
	PressShield:		function(){return mouse_check_button_pressed(Inputs.shield)},
	ReleasedRight:		function(){return keyboard_check_released(Inputs.right)},
	ReleasedLeft:		function(){return keyboard_check_released(Inputs.left)},
	ReleasedJump:		function(){return keyboard_check_released(Inputs.jump)},
	ReleasedDash:		function(){return keyboard_check_released(Inputs.dash)},
	ReleasedAttack:		function(){return mouse_check_button_released(Inputs.attack)},
	ReleasedShield:		function(){return mouse_check_button_released(Inputs.shield)}
}

globalvar hudScale;
hudScale=1;

globalvar stopPlayer;
stopPlayer=true;

#endregion