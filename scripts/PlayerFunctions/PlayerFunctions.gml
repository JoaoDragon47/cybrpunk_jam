function DetectCollision(){
	if(place_meeting(x+hspd,y,layer_tilemap_get_id("collision"))){
		while(!place_meeting(x+sign(hspd),y,layer_tilemap_get_id("collision"))){
			x+=sign(hspd);
		}
		hspd=0
	}
	x+=hspd;
	
	isOnFloor=place_meeting(x,y+1,layer_tilemap_get_id("collision"));
	if(place_meeting(x,y+vspd,layer_tilemap_get_id("collision"))){
		while(!place_meeting(x,y+sign(vspd),layer_tilemap_get_id("collision"))){
			y+=sign(vspd);
		}
		vspd=0
	}
	y+=vspd;
}

function PlayerDetectMovement(){
	hspd=(InputsFunctions.HoldRight()-InputsFunctions.HoldLeft())*spd;
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	PlayerDetectState();
	
	DetectCollision();
	
	image_xscale=lengthdir_x(1,dir);
}

function PlayerDetectState(){
	if(!isInAction){
		if(jumpTimer<=0){
			if(isOnFloor){
				if(hspd!=0){
					dir=point_direction(x,y,x+hspd,y);
					state=PlayerStateWalk;
				}else{
					state=PlayerStateIdle;
				}
			}else{
				if(hspd!=0){
					dir=point_direction(x,y,x+hspd,y);
				}
				state=PlayerStateFall;
			}
		}else{
			if(hspd!=0){
				dir=point_direction(x,y,x+hspd,y);
			}
			state=PlayerStateJump;
		}
	}else{
		if(hspd!=0){
			dir=point_direction(x,y,x+hspd,y);
		}
	}
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
		isInAction=false;
		attackCharge=0;
		shieldCharge=0;
		
		spd=walkSpd;
		shield.defend=false;
		
		state=PlayerStateJump;
	}
		
	if(!InputsFunctions.HoldJump()) jumpTimer=0;
		
	if(jumpTimer>0){
		jumpTimer--;
		
		vspd=-jumpSpd;
	}
}

function PlayerDetectDashKey(){
	if(isOnFloor){
		dashCount=0;
	}
	
	if(InputsFunctions.PressDash() and dashCount<dashMax and dashTimer<=0){
		dashCount++;
		dashTimer=dashCooldown;
		dashTimerDuration=dashDuration;
		isInAction=false;
		attackCharge=0;
		shieldCharge=0;
		
		sprite_index=sprPlayerDash;
		state=PlayerStateDash;
	}
}

function PlayerDetectAttackCharge(){
	attackTimer--;
	if(attackTimer<=0){
		if(isOnFloor){
			if(InputsFunctions.PressAttack()){
				attackTimer=attackCooldown;
				attackCharge=0;
				isInAction=true;
				state=PlayerStateChargeAttack;
			}
		}else{
			if(InputsFunctions.PressAttack()){
				attackTimer=attackCooldown;
				attackCharge=0;
				isInAction=true;
				state=PlayerStateChargeAttackOnAir;
			}
		}
	}
}

function PlayerDetectShieldCharge(){
	if(posAttackTimer>0){
		posAttackTimer--;
		
		if(InputsFunctions.HoldShield()){
			state=PlayerStateChargeShield;
		}
	}else if(InputsFunctions.HoldShield()){
		isInAction=true;
		state=PlayerStateDefendShield;
	}
}

function PlayerChooseAttack(){
	var _dirAtk=dir==180 ? -1 : 1;
	if(attackCharge<minAttackCharge1){
		//ATAQUE PADRÃO
		var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
			image_xscale: _dirAtk*other.scaleHitboxAtk0
		});
		_hit.target=self;
		hitForce=hitForceBase*multiplierAtkLvl0;
		damage=attackBaseDamage*multiplierAtkLvl0;
		
		state=PlayerStateBasicAttack;
	}else{
		if(attackCharge>=minAttackCharge2){
			//ATAQUE CARREGADO 2
			var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
				image_blend: c_red,
				image_xscale: _dirAtk*other.scaleHitboxAtk2,
				image_yscale: other.scaleHitboxAtk2
			});
			_hit.target=self;
			hitForce=hitForceBase*multiplierAtkLvl2;
			damage=attackBaseDamage*multiplierAtkLvl2;
			
			state=PlayerStateChargedAttack2;
		}else{
			//ATAQUE CARREGADO 1
			var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
				image_blend: c_yellow,
				image_xscale: _dirAtk*other.scaleHitboxAtk1
			});
			_hit.target=self;
			hitForce=hitForceBase*multiplierAtkLvl1;
			damage=attackBaseDamage*multiplierAtkLvl1;
			
			state=PlayerStateChargedAttack1;
		}
	}
	
	image_index=0;
	attackCharge=0;
}

function PlayerAttackEnd(){
	if(EndAnimation()){
		image_index=0;
		isInAction=false;
		
		posAttackTimer=DELTA*.5;
		
		state=PlayerStateIdle;
	}
}