function EnemyStateChooseState(){
	nextState=choose(EnemyStateIdle,EnemyStateWalk);
	stateTimer=random_range(DELTA*2,DELTA*6);
	
	switch(nextState){
		case EnemyStateIdle:
			state=EnemyStateIdle;
			break;
		case EnemyStateWalk:
			xDest=xHome+irandom_range(-homeRange,homeRange);
			spd=walkSpd;
			
			state=EnemyStateWalk;
			break;
	}
}

function EnemyStateIdle(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	
	EnemyDetectPlayer();
}

function EnemyStateWalk(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	dir=point_direction(x,y,xDest,y);
	hspd=lengthdir_x(spd,dir);
	
	DetectCollision();
	
	if(point_distance(x,y,xDest,y)<=spd*1.5){
		x=xDest;
		hspd=0;
		
		state=EnemyStateIdle;
	}
	
	EnemyDetectPlayer();
}

#region SNIPER

function SniperStateIdle(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	
	xDest=objPlayer.x;
	if(point_distance(x,y,xDest,y)<viewRange){
		if(isReloading){
			state=SniperStateReloading;
		}else{
			SniperDetectAim();
			SniperDetectDodge();
		}
	}else{
		state=SniperStateWalk;
	}
}

function SniperStateWalk(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	//GET CLOSER TO PLAYER
	xDest=objPlayer.x;
	dir=point_direction(x,y,xDest,y);
	hspd=lengthdir_x(spd,dir);
	
	if(!place_meeting((dir>90 ? bbox_left : bbox_right)+hspd,y+1,objCollider)){
		spd=walkSpd;
		hspd=0;
		state=SniperStateIdle;
	}
	
	DetectCollision();
	
	if(point_distance(x,y,xDest,y)<attackRange){
		hspd=0;
		
		state=SniperStateIdle;
	}
}

function SniperStateReloading(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	
	reloadTimer--;
	if(reloadTimer<=0){
		isReloading=false;
		state=SniperStateIdle;
	}
}

function SniperStateJumpAway(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	hspd=lengthdir_x(jumpAwaySpd,dir);
	
	DetectCollision();
	
	if(isOnFloor){
		if(vspd>=0){
			hspd=0;
			dir=point_direction(objPlayer.x,y,x,y);
			xDest=objPlayer.x+lengthdir_x(viewRange*.5,dir);
			state=SniperStateRunAway;
		}
	}
}

function SniperStateRunAway(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	dir=point_direction(objPlayer.x,y,x,y);
	hspd=lengthdir_x(spd,dir);
	
	if(!place_meeting((dir>90 ? bbox_left : bbox_right)+hspd,y+1,objCollider)){
		spd=walkSpd;
		hspd=0;
		state=SniperStateIdle;
	}
	
	if(place_meeting((dir>90 ? bbox_left-jumpAwaySpd : bbox_right+jumpAwaySpd),y,objCollider)){
		spd=walkSpd;
		hspd=0;
		state=SniperStateIdle;
	}
	
	DetectCollision();
	
	SniperDetectDodge();
	
	if(point_distance(x,y,objPlayer.x,y)>=viewRange*.5){
		spd=walkSpd;
		hspd=0;
		state=SniperStateIdle;
	}
}

function SniperStateAiming(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	
	aimingTimer--;
	SniperDetectDodge();
	
	if(aimingTimer<=0){
		isReloading=true;
		reloadTimer=DELTA*1.5;
		enemyAttack();
		state=SniperStateReloading;
	}
}

function SniperStateHitted(){
	hitLen-=.05;
	hspd=lengthdir_x(hitLen,hitDir);
	//vspd=lengthdir_y(hitLen,hitDir);
	
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	DetectCollision();
	
	if(hitLen<=0){
		hspd=0;
		state=SniperStateIdle;
	}
}

#endregion

#region CHARGER

function ChargerStateIdle(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	
	if(point_distance(x,y,objPlayer.x,objPlayer.y)<=viewRange){
		state=ChargerStateRunToPlayer;
	}
}

function ChargerStateRunToPlayer(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	dir=point_direction(x,y,objPlayer.x,y);
	hspd=lengthdir_x(spd,dir);
	
	DetectCollision();
	
	ChargerDetectPlayerOnSamePlatform();
}

function ChargerStateChargeDash(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	charge--;
	if(charge<=0){
		chargeTimerDuration=chargeDuration;
		state=ChargerStateDash;
	}
}

function ChargerStateDash(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	hspd=lengthdir_x(spdCharge,dir);
	
	DetectCollision();
	
	if(place_meeting(x,y,objPlayer) and !hittedPlayer){
		if(objPlayer.shield.defend){
			chargeTimerDuration=0;
		}else{
			objPlayer.actualHealth-=damage;
			hittedPlayer=true;
		}
	}
	
	chargeTimerDuration--
	if(chargeTimerDuration<=0 or hspd==0){
		hspd=0;
		restTimer=restCooldown;
		hittedPlayer=false;
		state=ChargerStateRest;
	}
}

function ChargerStateRest(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
	restTimer--;
	if(restTimer<=0){
		state=ChargerStateIdle;
	}
}

function ChargerStateHitted(){
	hitLen-=.05;
	hspd=lengthdir_x(hitLen,hitDir);
	//vspd=lengthdir_y(hitLen,hitDir);
	
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	DetectCollision();
	
	if(hitLen<=0){
		hspd=0;
		state=ChargerStateIdle;
	}
}

#endregion

#region BAT

function BatStateOnCeil(){
	if(!isOnFloor){
		vspd-=GRAVITY;
	}
	
	DetectCollision();
	BatDetectPlayer();
}

function BatStateDiveDown(){
	if(!isOnFloor){
		vspd-=GRAVITY;
	}
	
	hspd=lengthdir_x(spdHorizontalDive,dir);
	
	DetectCollision();
	
	if(place_meeting(x,y,objPlayer) and !hittedPlayer){
		hittedPlayer=true;
		if(place_meeting(x,y,objShield) and objPlayer.shield.defend){
			vspd=0;
		}else{
			objPlayer.actualHealth-=damage;
		}
	}
	
	if(place_meeting(x,bbox_bottom+1,objCollider) or vspd<0){
		vspd=0;
		state=BatStateDiveUp;
	}
}

function BatStateDiveUp(){
	if(!isOnFloor){
		vspd-=GRAVITY;
	}
	
	hspd=lengthdir_x(spdHorizontalDive,dir);
	
	DetectCollision();
	
	if(place_meeting(x,y,objPlayer) and !hittedPlayer){
		hittedPlayer=true;
		if(place_meeting(x,y,objShield) and objPlayer.shield.defend){
			exit;
		}else{
			objPlayer.actualHealth-=damage;
		}
	}
	
	if(place_meeting(x,bbox_top-1,objCeil)){
		hspd=0;
		hittedPlayer=false;
		state=BatStateOnCeil;
	}
}

#endregion

function EnemyStateChasePlayer(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	xDest=objPlayer.x;
	yDest=objPlayer.y;
	dir=point_direction(x,y,xDest,y);
	hspd=lengthdir_x(spd,dir);
	
	DetectCollision();
	
	EnemyDetectPlayer();
	
	EnemyDetectAttack();
}

function EnemyStateHitted(){
	hitLen-=.05;
	hspd=lengthdir_x(hitLen,hitDir);
	//vspd=lengthdir_y(hitLen,hitDir);
	
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	DetectCollision();
	
	if(hitLen<=0){
		hspd=0;
		state=EnemyStateIdle;
	}
}

function EnemyStateWaitAttack(){
	attackTimer--;
	
	if(attackTimer<=0){
		var _dirAtk=dir==180 ? -1 : 1;
		var _hit=instance_create_layer(x,y,"attacks",objHitboxEnemyAttack,{
			image_xscale: _dirAtk
		});
		_hit.target=self;
		hitForce=hitForceBase;
		damage=attackBaseDamage;
		
		state=EnemyStateAttack;
	}
}

function EnemyStateAttack(){
	hspd=0;
	
	if(EndAnimation()){
		state=EnemyStateIdle;
	}
}