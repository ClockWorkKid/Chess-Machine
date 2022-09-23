function cam = init_webcam()
cam = webcam('USB Video Device');
cam.Resolution = '1280x960';
cam.BacklightCompensation= 0;
cam.Contrast = 32 ;

cam.WhiteBalanceMode= 'manual';
cam.WhiteBalance = 5530;
cam.ExposureMode= 'manual';
cam.Exposure = -4;
cam.Sharpness = 24;

cam.Brightness = 90;

cam.Saturation= 32;
cam.Gain= 1;


cam
end

