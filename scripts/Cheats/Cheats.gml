///@description Comando para definir o cooldown entre um dash e outro do player.
///@param {Real} <Segundos> Tempo, em segundos.
function setCooldown(_cool=.2){
	with(objPlayer){
		dashCooldown=DELTA*_cool;
	}
	return $"Cooldown do dash ajustado para {_cool} segundos.";
}


///@description Comando para definir alguns status do player.
///@param {Real} <Vida> Vida máxima do jogador. (Ele irá regenerar tudo também)
///@param {Real} <AtaqueDano> Dano base de ataque do jogador.
///@param {Real} <EscudoDano> Dano base do escudo do jogador.
///@param {Real} <Velocidade> Velocidade de movimento do jogador.
///@param {Real} <Pulo> Força do pulo do jogador.
function setPlayerStats(_hp=100,_damage=10,_shieldDamage=10,_walk=3,_jump=2.5){
	with(objPlayer){
		maxHealth=_hp;
		actualHealth=maxHealth;
		attackBaseDamage=_damage;
		shieldBaseDamage=_shieldDamage;
		walkSpd=_walk;
		jumpSpd=_jump;
	}
	
	return $"Status novos: \n Vida: {_hp} \n Dano: {_damage} \n Speed: {_walk} \n Pulo: {_jump}"
}


///@description Comando para definir o tempo de carga dos ataques e arremesso do escudo.
///@param {Real} <AtaqueLvl1> Tempo, em segundos, que o jogador irá precisar para carregar o ataque de level 1.
///@param {Real} <AtaqueLvl2> Tempo, em segundos, que o jogador irá precisar para carregar o ataque de level 2.
///@param {Real} <EscudoLvl1> Tempo, em segundos, que o jogador irá precisar para carregar o escudo de level 1.
function setAttackCharge(_charge1=1.5,_charge2=3,_charge3=1.5){
	with(objPlayer){
		minAttackCharge1=_charge1*DELTA;
		minAttackCharge2=_charge2*DELTA;
		minShieldCharge=_charge3*DELTA;
	}
	
	return $"O tempo de carga para os seguintes ataque: \n ATAQUE LVL 1 - {_charge1} segundos. \n ATAQUE LVL 2 - {_charge2} segundos. \n ESCUDO LVL 1 - {_charge3}"
}


///@description Comando para definir quanto tempo o escudo ficará no estado de 'jogado'.
///@param {Real} <Segundos> Tempo, em segundos.
function setShieldDuration(_duration=.8){
	with(objShield){
		throwDurationCooldown=DELTA*_duration;
	}
	return $"O escudo agora será arremessado por {_duration} segundos.";
}