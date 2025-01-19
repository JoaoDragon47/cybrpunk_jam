if(!transited){
	transited=true;
	var _destiny=destiny;
	instance_create_layer(x,y,"hud",objFadeTransitionRoom,{
		destiny: _destiny,
		transitionSpeed: .05
	});
}