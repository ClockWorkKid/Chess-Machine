close all
clear all
clc

chess=imread('D:\Workspace\Term Project MATLAB\Sample Game\image (5).jpg');

%%
chess=im2double(chess);
R=chess(:,:,1);
G=chess(:,:,2);
B=chess(:,:,3);

figure;
subplot(1,3,1),imshow(R);
subplot(1,3,2),imshow(G);
subplot(1,3,3),imshow(B);

%%
r = 0.6 ;
g1 = 0.3 ;
g2 = 0.7 ;
b = 0.5 ;
R1 = im2bw(R,r);
G1 = im2bw(G,g1);
G11 = ~im2bw(G,g2);
B1 = im2bw(B,b);

figure;
subplot(2,2,1),imshow(R1);
subplot(2,2,2),imshow(G1);
subplot(2,2,3),imshow(G11);
subplot(2,2,4),imshow(B1);

%%

White = R1|B1 ;
Board = imfill(White,'holes');
Black = ~(R1&B1) & Board;

White2 = G1&Board;
Black2 = G11&Board;

figure;
subplot(2,3,1),imshow(White);
subplot(2,3,2),imshow(Black);
subplot(2,3,3),imshow(Board);
subplot(2,3,4),imshow(White2);
subplot(2,3,5),imshow(Black2);

%%
noise=0;
Board3 = imopen(Board,strel('disk',noise));
White3 = imopen(White,strel('disk',noise));
Black3 = imopen(Black2,strel('disk',noise));


G2 = zeros(size(G));
G2 = Board3 * (2^8) ;
R2 = White3 ;
B2 = Black3;

img2 = cat(3, R2, G2, B2);

subplot(2,3,6),imshow(img2);

%%
noiseBoard = 10 ;
r2 = 0.75;
b2 = 0.7;
RR = im2bw(R,r2);
BB = im2bw(B,b2);
BoardReal = imopen(imfill(RR+BB,'holes'),strel('disk',noiseBoard));

figure,imshow(BoardReal);

stats = regionprops(BoardReal,'BoundingBox','Extrema','Area');
stats.BoundingBox;

j=0;
for i =1:length(stats)
    hold on;
    if stats(i).Area > size(RR,1)*size(RR,2)/5
        h = rectangle('Position',stats(i).BoundingBox);
        set(h,'EdgeColor',[0.7,0,0]);
        j=i;
    end
    
end

hold off
stats(j).Extrema
stats(j).BoundingBox

%%
cropped = imresize(imcrop(img2,stats(j).BoundingBox),[640 640]);
figure,imshow(cropped),hold on;

for ii = 1:7
    line([ii*80 ii*80],[0 640]);
    line([0 640],[ii*80 ii*80]);
    hold on
end
    
hold off;

%%
whitePieces = imresize(imcrop(White2,stats(j).BoundingBox),[640 640]);
blackPieces = imresize(imcrop(Black2,stats(j).BoundingBox),[640 640]);
figure,subplot(2,1,1),imshow(whitePieces);
subplot(2,1,2),imshow(blackPieces);










    
