hspd=-1;
vspd=-1;
dir=-1;
#macro GRAVITY .24
#macro FRAME game_get_speed(gamespeed_fps)

walkSpd=3;
spd=walkSpd;
density=1;

right=-1;
left=-1;

jumpSpd=5.2;
pressJumpKey=-1;
holdJumpKey=-1;
jumpHoldFrames=FRAME*.01;
jumpTimer=jumpHoldFrames;
coyoteFrames=FRAME*.15;
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

isOnFloor=false;
state=PlayerStateIdle;