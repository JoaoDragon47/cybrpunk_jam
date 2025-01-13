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

spdCharge=6;
hspd=0;
vspd=0;
chargeCooldown=DELTA*1;
charge=0;
chargeDuration=DELTA*.8;
chargeTimerDuration=0;
restCooldown=DELTA*1.5;
restTimer=0;

viewRange=view_get_wport(view_enabled[0]);

enemyIdle=		ChargerStateIdle;
enemyWalk=		ChargerStateIdle;
enemyHitted=	ChargerStateHitted;

stateTimer=1;
state=enemyIdle;