clear all
close all
clc
load('calib_data.mat');

%% Reconstruct Image

logistic_thres = 0.5;
noise = 7 ;
tolerance = 0.6 ;
path_pic = 'D:\Workspace\Term Project MATLAB\pic.jpg';

chess = imread(path_pic);
chess = im2double(chess);
R = chess(:,:,1) ;
G = chess(:,:,2) ;
B = chess(:,:,3) ;
img_size = size(R) ;

R = R(:) ;
G = G(:) ;
B = B(:) ;

pixels = [ones(size(R)) , R , G , B] ; % unrolled rgb matrix
colors = 1./(1+exp(-(pixels*all_theta'))) > logistic_thres ; % logistic regression prediction


construct = colors*Class_vals' ;
R = construct(:,1);
G = construct(:,2);
B = construct(:,3);

R = reshape(R,img_size);
G = reshape(G,img_size);
B = reshape(B,img_size);

figure
subplot(3,1,1),imshow(R);
subplot(3,1,2),imshow(G);
subplot(3,1,3),imshow(B);

reconstruction = [] ;
reconstruction(:,:,1) = R.*BW;
reconstruction(:,:,2) = G.*BW;
reconstruction(:,:,3) = B.*BW;

figure
subplot(1,2,1),imshow(chess);
subplot(1,2,2),imshow(reconstruction);


%% Extract color layers and board

WHITE = reshape(colors(:,3),img_size);
BLACK = reshape(colors(:,4),img_size);

WHITE = imopen(WHITE,strel('disk',noise));
WHITE = ~imopen(~WHITE,strel('disk',noise));
BLACK = imopen(BLACK,strel('disk',noise));
BLACK = ~imopen(~BLACK,strel('disk',noise));

stats = regionprops(BW,'BoundingBox','Extrema','Area');

cropped = imresize(imcrop(chess,stats.BoundingBox),[640 640]);
whitePieces = imresize(imcrop(WHITE,stats.BoundingBox),[640 640]);
blackPieces = imresize(imcrop(BLACK,stats.BoundingBox),[640 640]);
%{
whitePieces = imopen(whitePieces,strel('disk',noise));
whitePieces = ~imopen(~whitePieces,strel('disk',noise));
blackPieces = imopen(blackPieces,strel('disk',noise));
blackPieces = ~imopen(~blackPieces,strel('disk',noise));
%}

subplot(1,3,1),imshow(cropped),hold on;
for ii = 1:7
    line([ii*80 ii*80],[0 640]);
    line([0 640],[ii*80 ii*80]);
    hold on
end
hold off;

subplot(1,3,2),imshow(whitePieces),hold on;
for ii = 1:7
    line([ii*80 ii*80],[0 640]);
    line([0 640],[ii*80 ii*80]);
    hold on
end
hold off;

subplot(1,3,3),imshow(blackPieces),hold on;
for ii = 1:7
    line([ii*80 ii*80],[0 640]);
    line([0 640],[ii*80 ii*80]);
    hold on
end
hold off;


%% Identifying objects

detect_white = regionprops(whitePieces,'BoundingBox','Centroid','Area');
detect_black = regionprops(blackPieces,'BoundingBox','Centroid','Area');

board = zeros(8,8);

areas = detect_white.Area;
piece_size = median(areas);
lower_limit = piece_size - piece_size*tolerance ;
upper_limit = piece_size + piece_size*tolerance ;

whitePiss = length(detect_white);
blackPiss = length(detect_black);

w=0;
b=0;
%
figure, imshow(cropped),hold on;
for i =1:whitePiss
    hold on;
    if(lower_limit < detect_white(i).Area && detect_white(i).Area < upper_limit)
        xpix = detect_white(i).Centroid(1)/80 ;
        ypix = detect_white(i).Centroid(2)/80 ;
        if(board(ceil(xpix),ceil(ypix)) == 0 && detect_white(i).BoundingBox(3)<80 && detect_white(i).BoundingBox(4)<80)
            board(ceil(xpix),ceil(ypix)) = 1 ;
            h = rectangle('Position',detect_white(i).BoundingBox);
            set(h,'EdgeColor',[1,1,1]);
            w = w+1;
        end
    end
end

for i =1:blackPiss
    hold on;
    if(lower_limit < detect_black(i).Area && detect_black(i).Area < upper_limit)
        xpix = detect_black(i).Centroid(1)/80 ;
        ypix = detect_black(i).Centroid(2)/80 ;
        if(board(ceil(xpix),ceil(ypix)) == 0 && detect_black(i).BoundingBox(3)<80 && detect_black(i).BoundingBox(4)<80)
            board(ceil(xpix),ceil(ypix)) = 2 ;
            h = rectangle('Position',detect_black(i).BoundingBox);
            set(h,'EdgeColor',[0,0,0]);
            b = b+1;
        end
    end
end

pieceInfo = ['White : ',num2str(w),'   Black : ',num2str(b)] ;
title(pieceInfo) ;

board = board'
hold off
%





