if(defend){
	show_debug_message("defesa em");
}else{
	show_debug_message("tem defesa não");
}

switch(state){
	case "idle":
		if(target!=noone){
			x=target.x;
			y=target.y;
			dir=target.dir;
	
			if(target.dir>90)image_xscale=-1;
			else image_xscale=1
		}
		break;
	case "throw":
		if(!maxLen){
			throwDurationTimer--;
			
			checkEnemy();
			
			hspd=lengthdir_x(throwSpd,dir);
			
			if(throwDurationTimer<=0){
				ds_list_clear(enemysHitted);
				dir=-180;
				maxLen=true;
			}
		}else{
			dir=point_direction(x,y,target.x,target.y);
			hspd=lengthdir_x(throwSpd,dir);
			vspd=lengthdir_y(throwSpd,dir);
			
			y+=vspd;
			
			if(point_distance(x,y,target.x,target.y)<=16){
				ds_list_clear(enemysHitted);
				maxLen=false;
				throwDurationTimer=throwDurationCooldown;
				state="idle";
			}
		}
		
		x+=hspd;
		break;
}