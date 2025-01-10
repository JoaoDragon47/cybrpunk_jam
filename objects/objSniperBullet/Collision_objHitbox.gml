var _player=other.target;
if(_player.object_index==objPlayer){
	_player.actualHealth-=damage;
	instance_destroy();
}