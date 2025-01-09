event_inherited();

jumpSpd=3.5;					//FORÇA DO PULO
pressJumpKey=-1;
holdJumpKey=-1;
jumpHoldSEGUNDOs=SEGUNDO*.25;
jumpTimer=0;
coyoteSEGUNDOs=SEGUNDO*.18;			//COYOTE TIMER
coyoteTimer=coyoteSEGUNDOs;
jumpMax=1;
jumpCount=0;

dashMax=1;
dashCount=0;
dashSpd=10;						//FORÇA DO DASH
dashKey=-1;
dashCooldown=SEGUNDO*0.2;			//TEMPO ENTRE UM DASH E OUTRO
/*
O TEMPO ESTÁ EM SEGUNDOS (O COOLDOWN DO DASH ACIMA É DE 0.2 SEGUNDOS)
*/
dashTimer=dashCooldown;
dashDuration=SEGUNDO*0.1;			//DURAÇÃO DO DASH
dashTimerDuration=dashDuration;

canAttack=true;
attackBaseDamage=10;			//DANO BASE DO ATAQUE
attackDamage=attackBaseDamage;
attackCharge=0;
minAttackCharge1=SEGUNDO*1;		//TEMPO DE CARGA PARA O LVL 1 DO ATAQUE
minAttackCharge2=SEGUNDO*3;		//TEMPO DE CARGA PARA O LVL 2 DO ATAQUE
hitForceBase=2;					//FORÇA DO IMPACTO (KNOCKBACK AO INIMIGO)
hitForce=hitForceBase;

shieldBaseDamage=10;
shieldDamage=shieldBaseDamage;
posAttackTimer=0;
minShieldCharge=SEGUNDO*1;		//TEMPO DE CARGA PARA ARREMESSAR O ESCUDO
shieldCharge=0;

isInAction=false;
state=PlayerStateIdle;

shield=instance_create_layer(x,y,"attacks",objShield);
shield.target=self;

debug=true;
if(debug) show_debug_overlay(true,true);