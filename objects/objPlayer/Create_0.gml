event_inherited();

maxHealth=variable_global_exists("PlayerStats") ? global.PlayerStats.vida : 100;
actualHealth=maxHealth;

walkSpd=variable_global_exists("PlayerStats") ? global.PlayerStats.walkSpd : 4;
spd=walkSpd;

jumpSpd=variable_global_exists("PlayerStats") ? global.PlayerStats.jumpSpd : 5;					//FORÇA DO PULO
pressJumpKey=-1;
holdJumpKey=-1;
jumpHoldFrames=DELTA*.25;
jumpTimer=0;
coyoteFrames=DELTA*.10;			//COYOTE TIMER
coyoteTimer=coyoteFrames;
jumpMax=1;
jumpCount=0;

dashMax=1;
dashCount=0;
dashSpd=7;						//FORÇA DO DASH
dashKey=-1;
dashCooldown=DELTA*0.8;			//TEMPO ENTRE UM DASH E OUTRO
/*
O TEMPO ESTÁ EM SEGUNDOS (O COOLDOWN DO DASH ACIMA É DE 0.2 SEGUNDOS)
*/
dashTimer=dashCooldown;
dashDuration=DELTA*0.3;			//DURAÇÃO DO DASH
dashTimerDuration=dashDuration;

attackCooldown=DELTA*.2;		//COOLDOWN DE UM ATAQUE PRO OUTRO
attackTimer=attackCooldown;
canAttack=true;
attackBaseDamage=variable_global_exists("PlayerStats") ? global.PlayerStats.swordDamage : 20;			//DANO BASE DO ATAQUE
attackDamage=attackBaseDamage;
attackCharge=0;
minAttackCharge1=DELTA*0.5;		//TEMPO DE CARGA PARA O LVL 1 DO ATAQUE
minAttackCharge2=DELTA*1.2;		//TEMPO DE CARGA PARA O LVL 2 DO ATAQUE
hitForceBase=1.5;					//FORÇA DO IMPACTO (KNOCKBACK AO INIMIGO)
hitForce=hitForceBase;
hitLen=0;
hitDir=0;

//SESSÃO PARA AS HITBOXS DE ATAQUE
scaleHitboxAtk0=		1;		//ESCALA DA HITBOX DO ATAQUE NO LEVEL 0
scaleHitboxAtk1=		1;		//ESCALA DA HITBOX DO ATAQUE NO LEVEL 1
scaleHitboxAtk2=		2;		//ESCALA DA HITBOX DO ATAQUE NO LEVEL 2
multiplierAtkLvl0=		1;		//MULTIPLICADOR DE DANO DO ATAQUE NO LEVEL 0
multiplierAtkLvl1=		3;		//MULTIPLICADOR DE DANO DO ATAQUE NO LEVEL 1
multiplierAtkLvl2=		7;		//MULTIPLICADOR DE DANO DO ATAQUE NO LEVEL 2
//////////////////////////////////

shieldBaseDamageFront=variable_global_exists("PlayerStats") ? global.PlayerStats.shieldDamageFront : 10;
shieldBaseDamageBack=variable_global_exists("PlayerStats") ? global.PlayerStats.shieldDamageBack : 10;
shieldDamage=shieldBaseDamageFront;
posAttackTimer=0;
minShieldCharge=DELTA*1;		//TEMPO DE CARGA PARA ARREMESSAR O ESCUDO
shieldCharge=0;

isInAction=false;
state=PlayerStateIdle;

shield=instance_create_layer(x,y,"attacks",objShield);
shield.target=self;

debug=true;
if(debug) show_debug_overlay(true,true);

mask_index=sprPlayerIdle;