// Inherit the parent event
event_inherited();

hitForceBase=1.5;
hitForce=hitForceBase;
hitLen=0;
hitDir=0;
attackBaseDamage=10;
damage=attackBaseDamage;
attackTimer=DELTA*.5;
hittedPlayer=false;

spdHorizontalDive=4;
spdDive=16;
attackRange=170;
safeRange=50;

enemyIdle=		BatStateDiveUp;
enemyWalk=		BatStateOnCeil;
enemyHitted=	BatStateDiveUp;

stateTimer=1;
state=enemyIdle;