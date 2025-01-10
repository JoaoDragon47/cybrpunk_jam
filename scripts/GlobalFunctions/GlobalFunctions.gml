function EndAnimation() {
	/// @description animation_end(sprite_index,image_index, rate)
	/// @param {real} <sprite_index> The index of the sprite being animated
	/// @param {real} <image_index> The current frame value
	/// @param {real} <rate> -See Below-
	///		The rate of change in frames per step if not
	///		using built in image_index/image_speed.
	///		Don't use if you don't think you need this. You probably don't.
	
	//returns true if the animation will loop this step.
	
	//Script courtesy of PixellatedPope & Minty Python from GameMaker subreddit discord
	//https://www.reddit.com/r/gamemaker/wiki/discord
	
	var _sprite = sprite_index;
	var _image = image_index;
	if(argument_count > 0) _sprite = argument[0];
	if(argument_count > 1) _image = argument[1];
	var _type = sprite_get_speed_type(sprite_index);
	var _spd = sprite_get_speed(sprite_index)*image_speed;
	if (_type == spritespeed_framespersecond)
		_spd = _spd/game_get_speed(gamespeed_fps);
		if(argument_count > 2) _spd = argument[2];
		return _image + _spd >= sprite_get_number(_sprite);
}

function setCooldown(_cool=.2){
	with(objPlayer){
		dashCooldown=DELTA*_cool;
	}
	return $"Cooldown do dash ajustado para {_cool} segundos.";
}

function setPlayerStats(_hp=100,_damage=10,_walk=3,_jump=2.5){
	with(objPlayer){
		maxHealth=_hp;
		actualHealth=maxHealth;
		attackBaseDamage=_damage;
		walkSpd=_walk;
		jumpSpd=_jump;
	}
	
	return $"Status novos: \n Vida: {_hp} \n Dano: {_damage} \n Speed: {_walk} \n Pulo: {_jump}"
}

function setAttackCharge(_charge1=1.5,_charge2=3,_charge3=1.5){
	with(objPlayer){
		minAttackCharge1=_charge1*DELTA;
		minAttackCharge2=_charge2*DELTA;
		minShieldCharge=_charge3*DELTA;
	}
	
	return $"O tempo de carga para os seguintes ataque: \n ATAQUE LVL 1 - {_charge1} segundos. \n ATAQUE LVL 2 - {_charge2} segundos. \n ESCUDO LVL 1 - {_charge3}"
}