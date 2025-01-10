function EnemyStateIdle(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
}

function EnemyStateWalk(){
	if(!isOnFloor){
		vspd+=GRAVITY;
	}
	
	DetectCollision();
}

function EnemyStateHitted(){
	hitLen-=.05;
	hspd=lengthdir_x(hitLen,hitDir);
	//vspd=lengthdir_y(hitLen,hitDir);
	
	if(!isOnFloor){
		vspd+=GRAVITY*density;
	}
	
	DetectCollision();
	
	if(hitLen<=0){
		hspd=0;
		state=EnemyStateIdle;
	}
}