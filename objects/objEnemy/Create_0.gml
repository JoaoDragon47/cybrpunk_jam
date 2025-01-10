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

jumpSpd=4;
enemyIdle=EnemyStateIdle;
enemyWalk=EnemyStateWalk;

stateTimer=1;
state=enemyIdle;