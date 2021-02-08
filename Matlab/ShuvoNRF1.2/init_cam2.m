function cam = init_cam2()
cam = webcam('Logitech HD Webcam C310');
 cam.Contrast = 32 ;
 cam.Exposure = -4;
 %cam.WhiteBalanceMode= 'auto';
 cam.Sharpness = 24;

cam.Brightness = 90;
%cam.Brightness = 90;
 cam.Resolution = '1280x960';
 cam.Saturation= 32;
 cam.Gain= 192;
 cam.ExposureMode= 'auto';
 cam.BacklightCompensation= 0;
end