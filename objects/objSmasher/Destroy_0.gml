global.nextStage=rmMenu;

instance_create_layer(x,y,"hud",objFadeTransitionRoom,{
	destiny: rmThanksForPlaying,
	transitionSpeed: .05
});