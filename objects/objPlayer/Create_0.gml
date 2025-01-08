event_inherited();

jumpSpd=3.5;
pressJumpKey=-1;
holdJumpKey=-1;
jumpHoldFrames=FRAME*.25;
jumpTimer=0;
coyoteFrames=FRAME*.18;
coyoteTimer=coyoteFrames;
jumpMax=1;
jumpCount=0;

dashSpd=10;
dashKey=-1;
canDash=true;
dashCooldown=FRAME*.2;
dashTimer=dashCooldown;
dashDuration=FRAME*.1;
dashTimerDuration=dashDuration;

canAttack=true;
attackBaseDamage=10;
attackDamage=attackBaseDamage;
attackCharge=0;
minAttackCharge1=FRAME*1;
minAttackCharge2=FRAME*3;
hitForceBase=2;
hitForce=hitForceBase;

shieldBaseDamage=10;
shieldDamage=shieldBaseDamage;

isInAction=false;
state=PlayerStateIdle;