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
jumpKey=-1;

dashSpd=10;
dashKey=-1;
canDash=true;
dashCooldown=FRAME*.2;
dashTimer=dashCooldown;
dashDuration=FRAME*.1;
dashTimerDuration=dashDuration;

isOnFloor=false;
state=PlayerStateIdle;