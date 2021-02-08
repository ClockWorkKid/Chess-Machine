clear all
close all
clc

r = 0.5 ;                           
g = 0.5 ;
b = 0.5 ;
noise = 10;

img = imread('D:\Workspace\Term Project MATLAB\Sample Game\image (1).jpg');

R = img(:,:,1);
G = img(:,:,2);
B = img(:,:,3);

R = im2bw(R,r);                     
G = im2bw(G,g);
B = im2bw(B,b);

D = R&B ;

E = imcomplement(R) & imcomplement(B) ;
F = R|B ;
F = imfill(F,'holes');
E = E & F ;

D = imopen(D,strel('disk',noise));
E = imopen(E,strel('disk',noise));


g = zeros(size(G));
g = ((g & imcomplement(E)) | D)*(2^8) ;
r = (R & imcomplement(E)) | D ;
b = (B & imcomplement(E)) | D ;

img2 = cat(3, r, g, b);
figure,subplot(121), imshow(img), subplot(122),imshow(img2) ;





