%% Initialize
close all
clear all
clc

X = [] ;
y = [] ;
Class_vals = [] ;
file_name = ["sample_RED","sample_BLUE","sample_WHITE","sample_BLACK"] ;
n = length(file_name) ;

%% Create Data Set
for i = 1:n
    
    path = ['D:\matlab2\image_process\codes\',char(file_name(i)),'.jpg'];
    image = im2double(imread(path));
    
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
       
    R = R(:) ;
    G = G(:) ;
    B = B(:) ;
    m0 = length(R) ;
    
    R_med = median(R);
    G_med = median(G);
    B_med = median(B);
    
    
    X = [X ; [ones(m0,1) , R , G , B] ] ;
    y = [y ; ones(m0,1)*i] ;
    Class_vals = [Class_vals , [R_med ; G_med ; B_med]];
    
    
end
%Class_vals

%% One vs all training
%clc
lambda = 0.1;
[all_theta] = myOneVsAll(X, y, n, lambda);

%% Prediction Accuracy
%clc
%pred = myPredictOneVsAll(all_theta, X);
%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

%% Reconstruct Image
clc

photo =20 ;
logistic_thres = 0.5;
path_pic = ['D:\matlab2\image_process\codes\image (',char(num2str(photo)),').jpg'];
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
noise = 13;

Board1 = imfill(RED + BLUE,'holes');
Board1 = imopen(Board1,strel('disk',noise));
%Board1 = ~imopen(~Board1,strel('disk',noise));
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

tolerance = .9;

detect_white = regionprops(whitePieces,'BoundingBox','Centroid','Area');
detect_black = regionprops(blackPieces,'BoundingBox','Centroid','Area');

figure, imshow(cropped),hold on;

areas = detect_white.Area;
piece_size = median(areas);
lower_limit = piece_size - piece_size*tolerance ;
upper_limit = piece_size + piece_size*tolerance ;

whitePiece = length(detect_white);
blackPiss = length(detect_black);

w=0;
b=0;

for i =1:whitePiece
    hold on;
    if(lower_limit < detect_white(i).Area && detect_white(i).Area < upper_limit)
    h = rectangle('Position',detect_white(i).BoundingBox);
    set(h,'EdgeColor',[1,1,1]);
    w = w+1;
    end
end

for i =1:blackPiss
    hold on;
    if(lower_limit < detect_black(i).Area && detect_black(i).Area < upper_limit)
    h = rectangle('Position',detect_black(i).BoundingBox);
    set(h,'EdgeColor',[0,0,0]);
    b = b+1;
    end
end
w,b
hold off

%%





