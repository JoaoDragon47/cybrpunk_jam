var _player=other.target;
if(_player.object_index==objPlayer){
	if(_player.shield.defend){
		_player.actualHealth-=(damage-_player.shieldReduceDamage);
	}else{
		_player.actualHealth-=damage;
	}
	instance_destroy();
}