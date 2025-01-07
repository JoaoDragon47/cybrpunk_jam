function PlayerDetectCollision(){
	if(place_meeting(x+hspd,y,objCollider)){
		while(!place_meeting(x+sign(hspd),y,objCollider)){
			x+=sign(hspd);
		}
		hspd=0
	}
	x+=hspd;
	
	isOnFloor=place_meeting(x,y+1,objCollider);
	if(place_meeting(x,y+vspd,objCollider)){
		while(!place_meeting(x,y+sign(vspd),objCollider)){
			y+=sign(vspd);
		}
		vspd=0
	}
	y+=vspd;
}

function PlayerDetectMovement(){
	hspd=(right-left);
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	if(hspd!=0){
		dir=point_direction(x,y,x+hspd,y);
		spd=walkSpd;
		
		state=PlayerStateWalk;
	}else{
		spd=0;
		
		state=PlayerStateIdle;
	}
	
	hspd=lengthdir_x(spd,dir);
	
	PlayerDetectCollision();
}

function PlayerDetectJumpKey(){
	if(isOnFloor){
		if(jumpKey){
			vspd=-jumpSpd;
		}
	}
}

function PlayerDetectDashKey(){
	if(canDash and isOnFloor){
		if(dashKey){
			dashTimer=dashCooldown;
			dashTimerDuration=dashDuration;
			canDash=false;
			state=PlayerStateDash;
		}
	}
}