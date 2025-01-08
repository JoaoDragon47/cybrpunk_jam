hspd=0;
vspd=0;
dir=0;

walkSpd=3;
spd=walkSpd;
density=1;

attackBaseDamage=10;
attackDamage=attackBaseDamage;

maxHealth=100;
actualHealth=maxHealth;

isOnFloor=false;
state=function(){return};

hitbox=instance_create_layer(x,y,"hitbox",objHitbox);
hitbox.target=self;