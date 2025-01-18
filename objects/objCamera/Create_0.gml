target=noone;

wResolution=960;
hResolution=540;
scaleResolution=2;
global.wCam=wResolution div scaleResolution;
global.hCam=hResolution div scaleResolution;
window_set_size(global.wCam*scaleResolution,global.hCam*scaleResolution);
window_center()
surface_resize(application_surface,global.wCam*scaleResolution,global.hCam*scaleResolution);

dir=0;
cam=-1;

//SCREEN SHAKE
shakeLen=5;
shakeDuration=DELTA*.8;
shakeTimer=0;