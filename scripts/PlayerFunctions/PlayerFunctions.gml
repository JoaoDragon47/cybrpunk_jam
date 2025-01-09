function DetectCollision(){
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
	hspd=(InputsFunctions.HoldRight()-InputsFunctions.HoldLeft())*spd;
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	PlayerDetectState();
	
	DetectCollision();
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
	}
}

function PlayerDetectJumpKey(){
	if(isOnFloor){
		jumpCount=0;
		coyoteTimer=coyoteSEGUNDOs;
	}else{
		if(coyoteTimer>0) {coyoteTimer--}
		if(coyoteTimer<=0 and jumpCount==0){jumpCount=1}
	}
	
	if(InputsFunctions.PressJump() and (jumpCount<jumpMax and (jumpCount==0 ? coyoteTimer>0 : true))){
		jumpCount++;
		coyoteTimer=coyoteSEGUNDOs;
		jumpTimer=jumpHoldSEGUNDOs;
		
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
		//canDash=false;
		state=PlayerStateDash;
	}
}

function PlayerDetectAttack(){
	if(isOnFloor){
		if(InputsFunctions.PressAttack()){
			attackCharge=0;
			isInAction=true;
			state=PlayerStateChargeAttack;
		}
	}
}

function PlayerDetectShieldCharge(){
	if(posAttackTimer>0){
		posAttackTimer--;
		
		if(InputsFunctions.HoldShield()){
			state=PlayerStateChargeShield;
		}
	}
}

function PlayerChooseAttack(){
	var _dirAtk=dir==180 ? -1 : 1;
	if(attackCharge<minAttackCharge1){
		//ATAQUE PADRÃO
		var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
			image_xscale: _dirAtk
		});
		_hit.target=self;
		hitForce=hitForceBase;
		damage=attackBaseDamage;
		
		state=PlayerStateBasicAttack;
	}else{
		if(attackCharge>=minAttackCharge2){
			//ATAQUE CARREGADO 2
			var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
				image_blend: c_red,
				image_xscale: _dirAtk*2,
				image_yscale: 2
			});
			_hit.target=self;
			hitForce=hitForceBase*3;
			damage=attackBaseDamage*3;
			
			state=PlayerStateChargedAttack2;
		}else{
			//ATAQUE CARREGADO 1
			var _hit=instance_create_layer(x,y,"attacks",objHitboxAttack,{
				image_blend: c_yellow,
				image_xscale: _dirAtk
			});
			_hit.target=self;
			hitForce=hitForceBase*1.5;
			damage=attackBaseDamage*1.5;
			
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
		
		posAttackTimer=SEGUNDO*.5;
		
		state=PlayerStateIdle;
	}
}