var _inst=other.target;
if(_inst.object_index==objPlayer){
	var _enemy=target;
	if(ds_list_find_index(playerHitted,_inst)==-1){
		ds_list_add(playerHitted,_inst);
		
		with(_inst){
			//hitLen=0;
			hitLen=_enemy.hitForce;
			hitDir=point_direction(_enemy.x,_enemy.y,x,y+1);
			
			actualHealth-=_enemy.damage;
			state=PlayerStateHitted;
		}
	}
}