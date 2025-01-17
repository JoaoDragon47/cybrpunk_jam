function EnemyDetectMovement(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
}

function EnemyDetectPlayer(){
	if(instance_exists(objPlayer)){
		var _p=instance_nearest(x,y,objPlayer);
		if(point_distance(x,y,_p.x,_p.y)<=viewRange){
			spd=walkSpd*1.2;
			state=EnemyStateChasePlayer;
		}
	}
}

function EnemyDetectAttack(){
	if(point_distance(x,y,xDest,yDest)<=50){
		attackTimer=DELTA*.3;
		state=EnemyStateWaitAttack;
	}
}

function SniperDetectDodge(){
	if(point_distance(x,y,objPlayer.x,objPlayer.y)<dodgeRange and jumpAwayTimer<=0){
		dir=point_direction(objPlayer.x,y,x,y);
		
		if(!place_meeting((dir>90 ? bbox_left-jumpAwaySpd : bbox_right+jumpAwaySpd),bbox_bottom+1,objCollider)){
			dir-=180;
		}
		
		if(place_meeting((dir>90 ? bbox_left-jumpAwaySpd : bbox_right+jumpAwaySpd),y,objCollider)){
			dir-=180;
		}
		
		vspd=-jumpSpd;
		jumpAwayTimer=jumpAwayCooldown;
		state=SniperStateJumpAway;
	}
}

function SniperDetectAim(){
	if(point_distance(x,y,xDest,y)<attackRange){
		if(collision_line(x,bbox_bottom-((bbox_bottom-bbox_top)/2),objPlayer.x,bbox_bottom-((bbox_bottom-bbox_top)/2),objPlayer,false,true)){
			dir=point_direction(x,y,objPlayer.x,y);
			xDest=objPlayer.x;
			aimingTimer=DELTA*1;
			state=SniperStateAiming;
		}
	}else{
		state=SniperStateWalk;
	}
}

function ChargerDetectPlayerOnSamePlatform(){
	if(collision_line(x,bbox_bottom-((bbox_bottom-bbox_top)/2),objPlayer.x,bbox_bottom-((bbox_bottom-bbox_top)/2),objPlayer,false,true) and isOnFloor){
		dir=point_direction(x,y,objPlayer.x,y);
		hspd=0;
		charge=chargeCooldown;
		state=ChargerStateChargeDash;
	}else{
		if(objPlayer.bbox_bottom<bbox_top){
			if(place_meeting(x+lengthdir_x(32,dir),y,layer_tilemap_get_id("collision"))){
				if(isOnFloor){
					dir=point_direction(x,y,x+hspd,y);
					vspd=-6;
					state=ChargerJumpToPlatform;
				}
			}
		}
	}
}

function BatDetectPlayer(){
	var _distanceToPlayer=point_distance(x,bbox_bottom,objPlayer.x,bbox_bottom);
	if(_distanceToPlayer<=attackRange){
		if(_distanceToPlayer>safeRange){
			if(!collision_line(x,bbox_bottom,objPlayer.x,objPlayer.bbox_top,layer_tilemap_get_id("collision"),false,true)){
				dir=point_direction(x,y,objPlayer.x,y);
				vspd=spdDive;
				state=BatStateDiveDown;
			}
		}
	}
}