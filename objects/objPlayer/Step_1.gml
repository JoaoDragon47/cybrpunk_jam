right=keyboard_check(ord("D")) or keyboard_check(vk_right);
left=keyboard_check(ord("A")) or keyboard_check(vk_left);
pressJumpKey=keyboard_check_pressed(vk_space);
holdJumpKey=keyboard_check(vk_space);
dashKey=keyboard_check_pressed(vk_shift);

if(dashTimer>0){
	dashTimer--;
	if(dashTimer<=0){
		canDash=true;
	}
}