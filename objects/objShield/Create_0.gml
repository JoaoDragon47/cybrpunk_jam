target=noone;

hspd=0;
vspd=0;
dir=-1;
throwSpd=8;
throwDurationCooldown=DELTA*.5;
throwDurationTimer=throwDurationCooldown;
damage=10;
defend=false;

maxLen=false;

state="idle";

enemysHitted=ds_list_create();
checkEnemy=function(){
	var _enemysList=ds_list_create();
	if(collision_rectangle_list(bbox_left,bbox_top,bbox_right,bbox_bottom,objHitbox,true,true,_enemysList,false)){
		var _enemysNumber=ds_list_size(_enemysList);
		var i=0;repeat(_enemysNumber){
			var _enemy=ds_list_find_value(_enemysList,i);
			//if(_enemy.object_index!=objPlayer)
			if(ds_list_find_index(enemysHitted,_enemy)==-1){
				ds_list_add(enemysHitted,_enemy);
				
				if(maxLen){
					_enemy.target.actualHealth-=target.shieldBaseDamageBack;
				}else{
					_enemy.target.actualHealth-=target.shieldBaseDamageFront;
				}
				
				throwDurationTimer=0;
			}
			i++;
		}
	}
	ds_list_destroy(_enemysList);
}