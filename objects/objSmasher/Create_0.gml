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
attackCount=0;
attacks=3;

maxHealth=300;
actualHealth=maxHealth;

hspd=0;
vspd=0;

//SESSÃO VOLTADA PARA O 'DASH WITH A PUNCH TOWARDS PLAYER'
dashSpd=					10;			//FORÇA DO DASH

chargeDuration=				DELTA*.5;	//TEMPO PARA CARREGAR O DASH
charge=0;

dashWithPunchDuration=		DELTA*.8;	//DURAÇÃO DO 'DASH WITH A PUNCH TOWARDS PLAYER'
dashWithPunchTimer=0;
//////////////////////////////////////////////////////////

//SESSÃO VOLTADA PARA O 'PUNCH 3 CONSECUTIVE TIMES...'
punchs=0;
punchsMax=					3;			//MÁXIMO DE SOCOS
punchSpd=					12;			//FORÇA DO MURRO (VELOCIDADE A QUAL O SMASHER É "ARREMESSADO" EM DIREÇÃO AO PLAYER)
//////////////////////////////////////////////////////

jumpSpd=					12;
stopSpd=					4;
inAirSpd=					6;
xDest=0;
yDest=0;

tauntDuration=				DELTA*2.5;	//DURAÇÃO DO TAUNT
tauntTimer=tauntDuration;

viewRange=600;

enemyIdle=		SmasherStateTaunt;
enemyWalk=		SmasherStateTaunt;
dashState=		SmasherStateDashWithPunch;

stateTimer=1;
state=enemyIdle;