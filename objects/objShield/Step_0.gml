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
			throwDuration--;
			
			hspd=lengthdir_x(throwSpd,dir);
			
			if(throwDuration<=0){
				dir=-180;
				maxLen=true;
			}
		}else{
			dir=point_direction(x,y,target.x,target.y);
			hspd=lengthdir_x(throwSpd,dir);
			vspd=lengthdir_y(throwSpd,dir);
			
			y+=vspd;
			
			if(point_distance(x,y,target.x,target.y)<=16){
				maxLen=false;
				throwDuration=SEGUNDO*.8;
				state="idle";
			}
		}
		
		x+=hspd;
		break;
}