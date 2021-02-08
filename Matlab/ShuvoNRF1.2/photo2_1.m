clear all;
% cam = init_cam2();

%  I= snapshot(cam);
%  pause(1);
%  I= snapshot(cam);
%  imshow(I);
% I= imread('C:\Users\Shuvo\Google Drive\RoboticsTeam\SHUVO\NRF1.2\Sample.png');
 firstImage=imread('D:\Workspace\Term Project MATLAB\Sample Game\image (5).jpg');
  [chartCentroidArray,chartHueArray] = segmentation(imrotate(firstImage,270))
box1=imread('D:\Workspace\Term Project MATLAB\Sample Game\sample_WHITE.jpg');
box2=imread('D:\Workspace\Term Project MATLAB\Sample Game\sample_BLACK.jpg');
box3=imread('D:\Workspace\Term Project MATLAB\Sample Game\sample_RED.jpg');
box4=imread('D:\Workspace\Term Project MATLAB\Sample Game\sample_BLUE.jpg');

boxHueArray=zeros(4,1);

[~,boxHueArray(1,1)] = segmentation(cropNPad(box1));
[~,boxHueArray(2,1)] = segmentation(cropNPad(box2));
[~,boxHueArray(3,1)] = segmentation(cropNPad(box3));
[~,boxHueArray(4,1)] = segmentation(cropNPad(box4));

boxHueArray



% imwrite(I,'Sample5.png');
% I1=imcrop(I,[480 590 100 100]);
% imshow(I1);