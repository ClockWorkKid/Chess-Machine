clear all;
% cam = init_cam2();

%  I= snapshot(cam);
%  pause(1);
%  I= snapshot(cam);
%  imshow(I);
% I= imread('C:\Users\Shuvo\Google Drive\RoboticsTeam\SHUVO\NRF1.2\Sample.png');
 firstImage=imread('Sample.png');
  [chartCentroidArray,chartHueArray] = segmentation(imrotate(firstImage,270))
box1=imread('Sample1.png');
box2=imread('Sample2.png');
box3=imread('Sample3.png');
box4=imread('Sample4.png');

boxHueArray=zeros(4,1);

[~,boxHueArray(1,1)] = segmentation(cropNPad(box1));
[~,boxHueArray(2,1)] = segmentation(cropNPad(box2));
[~,boxHueArray(3,1)] = segmentation(cropNPad(box3));
[~,boxHueArray(4,1)] = segmentation(cropNPad(box4));

boxHueArray



% imwrite(I,'Sample5.png');
% I1=imcrop(I,[480 590 100 100]);
% imshow(I1);