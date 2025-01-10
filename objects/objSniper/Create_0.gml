// Inherit the parent event
event_inherited();

hitForceBase=1.5;
hitForce=hitForceBase;
hitLen=0;
hitDir=0;
attackBaseDamage=10;
damage=attackBaseDamage;
attackTimer=DELTA*.5;

hspd=0;
xDest=x;
yDest=y;
xHome=x;
homeRange=200;
viewRange=500;
attackRange=250;
dodgeRange=60;
isReloading=false;
reloadTimer=0;

jumpSpd=4;
jumpAwaySpd=5;
jumpAwayCooldown=DELTA*1;
jumpAwayTimer=0;

enemyIdle=SniperStateIdle;
enemyWalk=SniperStateWalk;
enemyHitted=SniperStateHitted;

stateTimer=1;
state=enemyIdle;

enemyAttack=function(){
	var _bullet=instance_create_layer(x,bbox_bottom-((bbox_bottom-bbox_top)/2),"hitbox",objSniperBullet,{
		speed: 5,
		direction: other.dir
	});
	_bullet.alarm[0]=DELTA*3;
	_bullet.damage=attackBaseDamage;
}