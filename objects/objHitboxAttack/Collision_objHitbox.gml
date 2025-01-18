var _inst=other.target;
if(object_get_parent(_inst.object_index)==objEnemy){
	var _player=target;
	if(ds_list_find_index(enemysHitted,_inst)==-1){
		ds_list_add(enemysHitted,_inst);
		
		with(_inst){
			//hitLen=0;
			hitLen=_player.hitForce;
			hitDir=point_direction(_player.x,_player.y,x,y+1);
			
			actualHealth-=_player.damage;
			//if(object_index==objCharger){
			//	if(state!=ChargerStateDash){
			//		state=enemyHitted;
			//	}
			//}else if(object_index!=objSmasher){
			//	state=enemyHitted;
			//}
		}
	}
}