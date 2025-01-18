view_enabled=true;
view_visible[0]=true;
cam=view_camera[0];

camera_set_view_target(cam,self);
surface_resize(application_surface,global.wCam*scaleResolution,global.hCam*scaleResolution);