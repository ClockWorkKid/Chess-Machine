clear all
close all
clc

I = imread('D:\Workspace\Term Project MATLAB\Sample Game\image (5).jpg');
I = im2double(I);

BW = roipoly(I);

croppedI = I .* BW ;

clear BW;

croppedIR = croppedI(:,:,1);
croppedIG = croppedI(:,:,2);
croppedIB = croppedI(:,:,3);

croppedIR = croppedIR(:);
croppedIG = croppedIG(:);
croppedIB = croppedIB(:);

croppedI = [croppedIR, croppedIG, croppedIB];

clear croppedIR;
clear croppedIG;
clear croppedIB;

croppedI( ~any(croppedI,2), : ) = [];  %get rid of zero rows


