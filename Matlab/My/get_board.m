function [board] = get_board(photo)
% Reconstruct Image
% photo is photo no later to be replaced by camera input
% photo = 2 ;

load('calib_data.mat');

logistic_thres = 0.5;
path_pic = ['image (',char(num2str(photo)),').jpg'];
chess = imread(path_pic);
chess = im2double(chess);

R=chess(:,:,1);
G=chess(:,:,2);
B=chess(:,:,3);
img_size = size(R);

R = R(:) ;
G = G(:) ;
B = B(:) ;

pixels = [ones(size(R)) , R , G , B] ;
colors = 1./(1+exp(-(pixels*all_theta'))) > logistic_thres; %logistic regression prediction
construct = colors*Class_vals' ;

R = construct(:,1);
G = construct(:,2);
B = construct(:,3);

R = reshape(R,img_size);
G = reshape(G,img_size);
B = reshape(B,img_size);

% figure
% subplot(3,1,1),imshow(R);
% subplot(3,1,2),imshow(G);
% subplot(3,1,3),imshow(B);

reconstruction = [] ;
reconstruction(:,:,1) = R;
reconstruction(:,:,2) = G;
reconstruction(:,:,3) = B;

% figure
% subplot(1,2,1),imshow(chess);
% subplot(1,2,2),imshow(reconstruction);

% Extract Four Color Layers
noise = 2;

RED = reshape(colors(:,1),img_size);
BLUE = reshape(colors(:,2),img_size);
WHITE = reshape(colors(:,3),img_size);
BLACK = reshape(colors(:,4),img_size);

RED = imopen(RED,strel('disk',noise));
RED = ~imopen(~RED,strel('disk',noise));
BLUE = imopen(BLUE,strel('disk',noise));
BLUE = ~imopen(~BLUE,strel('disk',noise));
WHITE = imopen(WHITE,strel('disk',noise));
BLACK = imopen(BLACK,strel('disk',noise));

% figure;
% subplot(2,2,1),imshow(RED);
% subplot(2,2,2),imshow(BLUE);
% subplot(2,2,3),imshow(WHITE);
% subplot(2,2,4),imshow(BLACK);

% Extract Board
% Kamla code
noise = 13 ;

Board1 = imfill(RED + BLUE,'holes');
Board1 = imopen(Board1,strel('disk',noise));
Board1 = ~imopen(~Board1,strel('disk',noise));
%Board2 = imopen(imfill(WHITE + ~BLACK,'holes'),strel('disk',noise));
% figure;
% subplot(2,1,1),imshow(Board1);
% subplot(2,1,2),imshow(Board2);


% Detect Board

stats = regionprops(Board1,'BoundingBox','Extrema','Area');
i = 1 ; %comment this one out for uncommenting the section below
% figure,imshow(Board1);
%
% for i =1:length(stats)
%     hold on;
%     h = rectangle('Position',stats(i).BoundingBox);
%     set(h,'EdgeColor',[0.7,0,0]);
% end
%
% hold off

% Grid System
cropped = imresize(imcrop(reconstruction,stats(i).BoundingBox),[640 640]);
whitePieces = imresize(imcrop(WHITE,stats(i).BoundingBox),[640 640]);
blackPieces = imresize(imcrop(BLACK,stats(i).BoundingBox),[640 640]);
blackPieces= imopen(blackPieces,strel('disk',noise));

%{
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
%}

% Identifying objects

tolerance = 0.9 ;

detect_white = regionprops(whitePieces,'BoundingBox','Centroid','Area');
detect_black = regionprops(blackPieces,'BoundingBox','Centroid','Area');

figure, imshow(cropped),hold on;

areas = detect_white.Area;
piece_size = median(areas);
lower_limit = piece_size - piece_size*tolerance ;
upper_limit = piece_size + piece_size*tolerance ;

whitePiss = length(detect_white);
blackPiss = length(detect_black);

w=0;
b=0;

board = zeros(8,8);

for i =1:whitePiss
    hold on;
    if(lower_limit < detect_white(i).Area && detect_white(i).Area < upper_limit)
        xpix = detect_white(i).Centroid(1)/80 ;
        ypix = detect_white(i).Centroid(2)/80 ;
        board(ceil(xpix),ceil(ypix)) = 1 ;
        h = rectangle('Position',detect_white(i).BoundingBox);
        set(h,'EdgeColor',[1,1,1]);
        w = w+1;
    end
end

for i =1:blackPiss
    hold on;
    if(lower_limit < detect_black(i).Area && detect_black(i).Area < upper_limit)
        xpix = detect_black(i).Centroid(1)/80 ;
        ypix = detect_black(i).Centroid(2)/80 ;
        board(ceil(xpix),ceil(ypix)) = 2 ;
        h = rectangle('Position',detect_black(i).BoundingBox);
        set(h,'EdgeColor',[0,0,0]);
        b = b+1;
    end
end
w;
b;
board = board';
hold off
end