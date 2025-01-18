if (!roomTransited) {
	alpha += transitionSpeed;
} else {
	alpha -= transitionSpeed;
}

if (alpha >= 1 and !roomTransited) {
	room_goto(destiny)
}

if (roomTransited and alpha <= 0) {
	instance_destroy()
}