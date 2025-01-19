if(!transited){
	transited=true;
	global.nextStage=destiny;
	var _destiny=destiny;
	instance_create_layer(x,y,"hud",objFadeTransitionRoom,{
		destiny: rmStageCompleted,
		transitionSpeed: .05
	});
}