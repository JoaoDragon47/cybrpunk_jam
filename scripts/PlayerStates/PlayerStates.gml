function PlayerStateIdle(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	PlayerDetectAttackCharge();
	PlayerDetectShieldCharge();
}

function PlayerStateWalk(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	PlayerDetectAttackCharge();
	PlayerDetectShieldCharge();
}

function PlayerStateHitted(){
	hitLen-=.05;
	hspd=lengthdir_x(hitLen,hitDir);
	
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	DetectCollision();
	
	if(hitLen<=0){
		hspd=0;
		state=PlayerStateIdle;
	}
}

#region AÇÕES PADRÕES

function PlayerStateJump(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
}

function PlayerStateFall(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
}

function PlayerStateDash(){
	coyoteTimer=coyoteFrames;
	dashTimerDuration--;
	hspd=lengthdir_x(dashSpd,dir);
	vspd=0;
	
	instance_create_layer(x,y,layer,objTrail,{
		sprite_index: other.sprite_index,
		image_index: other.image_index
	})
	
	DetectCollision();
	
	if(dashTimerDuration<=0){
		state=PlayerStateIdle;
	}
}

#endregion

#region ATAQUES

function PlayerStateChargeAttack(){
	isInAction=true;
	attackCharge++;
	attackCharge=clamp(attackCharge,0,minAttackCharge2);
	if(hspd!=0) dir=point_direction(x,y,x+hspd,y);
	
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	
	if(!InputsFunctions.HoldAttack()){
		PlayerChooseAttack();
	}
}

function PlayerStateBasicAttack(){
	PlayerDetectMovement();
	
	PlayerAttackEnd();
}

function PlayerStateChargedAttack1(){
	PlayerDetectMovement();
	
	PlayerAttackEnd();
}

function PlayerStateChargedAttack2(){
	PlayerDetectMovement();
	
	PlayerAttackEnd();
}

function PlayerStateChargeShield(){
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	
	if(InputsFunctions.HoldShield()){
		shieldCharge++;
		isInAction=true;
	}else{
		if(shieldCharge>=minShieldCharge){
			shield.state="throw";
		}
		shieldCharge=0;
		isInAction=false;
		state=PlayerStateIdle;
	}
}

function PlayerStateDefendShield(){
	shield.defend=true;
	spd=walkSpd/2;
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	
	if(!InputsFunctions.HoldShield()){
		spd=walkSpd;
		isInAction=false;
		shield.defend=false;
		
		state=PlayerStateIdle;
	}
}

#endregion