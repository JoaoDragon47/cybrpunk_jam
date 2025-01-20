function PlayerStateIdle(){
	sprite_index=sprPlayerIdle;
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	PlayerDetectAttackCharge();
	PlayerDetectShieldCharge();
}

function PlayerStateWalk(){
	sprite_index=sprPlayerWalk;
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
	sprite_index=sprPlayerJump;
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	PlayerDetectAttackCharge();
}

function PlayerStateFall(){
	sprite_index=sprPlayerJump;
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	PlayerDetectAttackCharge();
}

function PlayerStateDash(){
	sprite_index=sprPlayerDash;
	coyoteTimer=coyoteFrames;
	dashTimerDuration--;
	hspd=lengthdir_x(dashSpd,dir);
	vspd=0;
	
	instance_create_layer(x,y,layer,objTrail,{
		sprite_index: other.sprite_index,
		image_index: other.image_index,
		image_xscale: other.image_xscale,
		image_yscale: other.image_yscale
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
	if(hspd!=0) {
		sprite_index=sprPlayerWalk;
		dir=point_direction(x,y,x+hspd,y);
	}else{
		sprite_index=sprPlayerIdle;
	}
	
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	
	if(!InputsFunctions.HoldAttack()){
		image_index=0;
		PlayerChooseAttack();
	}
}

function PlayerStateChargeAttackOnAir(){
	isInAction=true;
	attackCharge++;
	attackCharge=clamp(attackCharge,0,minAttackCharge2);
	if(hspd!=0) dir=point_direction(x,y,x+hspd,y);
	
	PlayerDetectMovement();
	PlayerDetectDashKey();
	
	if(place_meeting(x,bbox_bottom+1,layer_tilemap_get_id("collision"))){
		sprite_index=sprPlayerIdle;
		state=PlayerStateChargeAttack;
	}
	
	if(!InputsFunctions.HoldAttack()){
		image_index=0;
		PlayerChooseAttack();
	}
}

function PlayerStateBasicAttack(){
	sprite_index=sprPlayerAttack;
	PlayerDetectMovement();
	
	PlayerDetectJumpKey();
	
	PlayerAttackEnd();
}

function PlayerStateChargedAttack1(){
	sprite_index=sprPlayerAttack;
	PlayerDetectMovement();
	
	PlayerDetectJumpKey();
	
	PlayerAttackEnd();
}

function PlayerStateChargedAttack2(){
	sprite_index=sprPlayerAttack;
	PlayerDetectMovement();
	
	PlayerDetectJumpKey();
	
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
		//sprite_index=sprPlayerThrowShield;
		if(shieldCharge>=minShieldCharge){
			shield.state="throw";
		}
		shieldCharge=0;
		isInAction=false;
		state=PlayerStateIdle;
	}
}

function PlayerStateDefendShield(){
	sprite_index=sprPlayerShieldOn;
	shield.defend=true;
	spd=walkSpd/2;
	PlayerDetectMovement();
	
	PlayerDetectDashKey();
	PlayerDetectJumpKey();
	
	
	if(InputsFunctions.HoldShield()){
		shieldCharge++;
		isInAction=true;
	}else{
		//sprite_index=sprPlayerThrowShield;
		if(shieldCharge>=minShieldCharge){
			shield.state="throw";
		}
		shieldCharge=0;
		spd=walkSpd;
		isInAction=false;
		shield.defend=false;
		
		state=PlayerStateIdle;
	}
}

#endregion