function [board] = get_board2(photo)

%{
usage
-----------
command window on the right, figure window on the left
>> i = 1 ;
>> get_board2(i),i=i+1;
>> //scroll up and redo the last line again and again
%}

clc
load('calib_data.mat');
% Reconstruct Image

logistic_thres = 0.5;
noise = 5 ;
tolerance = 0.6 ;
path_pic = ['image (',char(num2str(photo)),').jpg'];
board = zeros(8,8);

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

% Extract color layers and board

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

% Identifying objects

detect_white = regionprops(whitePieces,'BoundingBox','Centroid','Area');
detect_black = regionprops(blackPieces,'BoundingBox','Centroid','Area');

areas = detect_white.Area;
piece_size = median(areas);
lower_limit = piece_size - piece_size*tolerance ;
upper_limit = piece_size + piece_size*tolerance ;

whitePiss = length(detect_white);
blackPiss = length(detect_black);

w=0;
b=0;

%
imshow(cropped),hold on;
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

board = board';
board = fliplr(flipud(board));
hold off
close
%

end



