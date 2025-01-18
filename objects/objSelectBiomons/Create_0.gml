enum BiomonsTypes{
	Health,MovementSpeed,JumpSpeed,
	SwordDamage,ShieldDamageFront,ShieldDamageBack,
	ShieldDamageReduce,
	Height
}

global.PlayerStats={
	vida: 100,
	walkSpd: 4,
	jumpSpd: 5,
	swordDamage: 10,
	shieldDamageFront: 10,
	shieldDamageBack: 10,
	shieldReduceDamage: 5
}

biomonSlotTypeActual=0;

biomonsSelected=0;
biomonSlots=ds_map_create();

//biomonSlot1=false;
//biomonSlot2=false;
//biomonSlot3=false;

dsGridBiomonHealth=createMenuPage(
	["Vida=100",100,"vida",-1],
	["Vida=100",100,"vida",-1]
)

dsGridBiomonSpeed=createMenuPage(
	["Speed=3",3,"walkSpd",-1],
	["Speed=10",10,"walkSpd",-1]
)

dsGridBiomonJump=createMenuPage(
	["JumpSpeed=5",5,"jumpSpd",-1],
	["JumpSpeed=8",8,"jumpSpd",-1]
)

dsGridBiomonSwordDamage=createMenuPage(
	["SwD1",50,"swordDamage",-1],
	["SwD2",100,"swordDamage",-1]
)

dsGridBiomonShieldDamageFront=createMenuPage(
	["ShDF1",50,"shieldDamageFront",-1],
	["ShDF2",100,"shieldDamageFront",-1]
)

dsGridBiomonShieldDamageBack=createMenuPage(
	["ShDB1",20,"shieldDamageBack",-1],
	["ShDB2",100,"shieldDamageBack",-1]
)

dsGridBiomonShieldDamageReduce=createMenuPage(
	["ShDR1",100,"shieldReduceDamage",-1],
	["ShDR2",100,"shieldReduceDamage",-1]
)

biomonsArray=[
	dsGridBiomonHealth,
	dsGridBiomonSpeed,
	dsGridBiomonJump,
	dsGridBiomonSwordDamage,
	dsGridBiomonShieldDamageFront,
	dsGridBiomonShieldDamageBack,
	dsGridBiomonShieldDamageReduce
]

arrayOptions=[];
option=BiomonsTypes.Health;
var i=0;repeat(BiomonsTypes.Height){
	array_push(arrayOptions,-1);
	i++;
}

//instance_deactivate_object(objPlayer.hitbox);
//instance_deactivate_object(objPlayer);