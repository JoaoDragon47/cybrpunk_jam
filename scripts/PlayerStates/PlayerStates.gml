function PlayerStateIdle(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
}

function PlayerStateWalk(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
}

function PlayerStateDash(){
	dashTimerDuration--;
	hspd=lengthdir_x(dashSpd,dir);
	
	instance_create_layer(x,y,layer,objTrail,{
		sprite_index: other.sprite_index
	})
	
	PlayerDetectCollision();
	
	if(dashTimerDuration<=0){
		state=PlayerStateIdle;
	}
}