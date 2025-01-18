if(target==noone){
	if(instance_exists(objPlayer)){
		target=objPlayer;
	}
}else{
	if(instance_exists(target)){
		x=lerp(x,target.x,.08);
		y=lerp(y,target.y,.08);
	}
	
	x=clamp(x,global.wCam/2,room_width-(global.wCam/2));
	y=clamp(y,global.hCam/2,room_height-(global.hCam/2));
	
	if(shakeTimer>0){
		shakeTimer--;
		
		x+=irandom_range(-shakeLen,shakeLen);
		y+=irandom_range(-shakeLen,shakeLen);
	}
	
	camera_set_view_pos(cam,x-(global.wCam/2),y-(global.hCam/2));
}