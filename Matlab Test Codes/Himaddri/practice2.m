close all
clear all
clc
chess=imread('1.jpg');
[r c b]=size(chess);
chess=im2double(chess);
R=chess(:,:,1);
G=chess(:,:,2);
B=chess(:,:,3);
bi=R+B;
%subplot(3,1,1);
imshow(bi);
fill=imfill(bi,'holes');
crop=imcrop(fill,[350 40 630 630]);
a=imresize(crop,[720 720]);
%imshow(fill);
%subplot(3,1,2);
%imshow(a);
impixelinfo