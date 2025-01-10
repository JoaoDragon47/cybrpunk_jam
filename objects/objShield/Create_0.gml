target=noone;

hspd=0;
vspd=0;
dir=-1;
throwSpd=8;
throwDuration=DELTA*.5;
damage=10;

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
				
				_enemy.target.actualHealth-=target.shieldBaseDamage;
			}
			i++;
		}
	}
	ds_list_destroy(_enemysList);
}