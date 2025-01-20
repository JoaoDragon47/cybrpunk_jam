if(audio_is_playing(sndStageMusic)) audio_stop_sound(sndStageMusic);

enum BiomonsTypes{
	Health,MovementSpeed,JumpSpeed,
	SwordDamage,ShieldDamageFront,ShieldDamageBack,
	ShieldDamageReduce,
	Height
}

global.PlayerStats={
	vida: 100,
	dashSpd: 7,
	jumpSpd: 5,
	swordDamage: 10,
	shieldDamageFront: 10,
	shieldDamageBack: 10,
	shieldReduceDamage: 5
}

biomonSlotTypeActual=0;

biomonsTypesName=[
	"Health","Dash Speed","Jump Force","Sword Damage","Shield Forward Damage","Shield Return Damage","Defense"
]
biomonsMax=2;
biomonsSelected=0;
biomonSlots=ds_map_create();

/*
Montagem de um biomon abaixo:

["texto_exibido", valor_a_aumentar, nome_da_variavel, valor_a_diminuir, nome_da_variavel]

*/


dsGridBiomonHealth=createMenuPage(
	["Health +50\nSword Damage -5",					50,		"vida",					-5,		"swordDamage"],
	["Health +100\nDefense -10",					100,	"vida",					-10,	"shieldReduceDamage"]
)

dsGridBiomonDashSpeed=createMenuPage(
	["Dash +0.2\nJump Force -0.1",					0.2,	"dashSpd",				-0.1,	"jumpSpd"],
	["Dash +0.5\nShield Return Damage -5",			0.5,	"dashSpd",				-5,		"shieldDamageBack"]
)

dsGridBiomonJump=createMenuPage(
	["Jump Force +0.4\nDefense -5",					0.4,	"jumpSpd",				-5,		"shieldReduceDamage"],
	["Jump Force +0.8\nDash -0.3",					0.8,	"jumpSpd",				-0.3,	"dashSpd"]
)

dsGridBiomonSwordDamage=createMenuPage(
	["Sword Damage +5\nDash -0.3",					5,		"swordDamage",			-0.3,	"dashSpd"],
	["Sword Damage +7\nJump Force -0.1",			7,		"swordDamage",			-0.1,	"jumpSpd"]
)

dsGridBiomonShieldDamageFront=createMenuPage(
	["Shield Forward Damage +5\nJump Force -0.2",	5,		"shieldDamageFront",	-0.2,	"jumpSpd"],
	["Shield Forward Damage +7\nDash -0.3",			7,		"shieldDamageFront",	-0.3,	"dashSpd"]
)

dsGridBiomonShieldDamageBack=createMenuPage(
	["Shield Return Damage +5\nSword Damage -3",	5,		"shieldDamageBack",		-3,		"swordDamage"],
	["Shield Return Damage +7\nDash -0.4",			7,		"shieldDamageBack",		-0.4,	"dashSpd"]
)

dsGridBiomonShieldDamageReduce=createMenuPage(
	["Defense +2\nSword Damage -1",					2,		"shieldReduceDamage",	-1,		"swordDamage"],
	["Defense +5\nShield Forward Damage -5",		5,		"shieldReduceDamage",	-5,		"shieldDamageFront"]
)

biomonsArray=[
	dsGridBiomonHealth,
	dsGridBiomonDashSpeed,
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