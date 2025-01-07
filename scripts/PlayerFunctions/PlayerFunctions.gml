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
	hspd=(InputsFunctions.HoldRight()-InputsFunctions.HoldLeft());
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
		jumpCount=0;
		coyoteTimer=coyoteFrames;
	}else{
		if(coyoteTimer>0) {coyoteTimer--}
		if(coyoteTimer<=0 and jumpCount==0){jumpCount=1}
	}
	
	if(InputsFunctions.PressJump() and (jumpCount<jumpMax and (jumpCount==0 ? coyoteTimer>0 : true))){
		jumpCount++;
		coyoteTimer=coyoteFrames;
		jumpTimer=jumpHoldFrames;
	}
		
	if(!InputsFunctions.HoldJump()) jumpTimer=0;
		
	if(jumpTimer>0){
		jumpTimer--;
		
		vspd=-jumpSpd;
	}
}

function PlayerDetectDashKey(){
	if(canDash and isOnFloor){
		if(InputsFunctions.PressDash()){
			dashTimer=dashCooldown;
			dashTimerDuration=dashDuration;
			canDash=false;
			state=PlayerStateDash;
		}
	}
}

function PlayerDetectAttack(){
	if(InputsFunctions.PressAttack()){
		
	}
}