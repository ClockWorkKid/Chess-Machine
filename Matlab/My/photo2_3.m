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
    
    path = ['D:\Workspace\Term Project MATLAB\Sample Game\',char(file_name(i)),'.png'];
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
    Class_vals = [Class_vals , [R_med ; G_med ;  B_med]];
    
    
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
% clc
logistic_thres = 0.5;
chess = imread('D:\Workspace\Term Project MATLAB\Sample Game\image (6).jpg');
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

figure
subplot(1,2,1),imshow(chess);
subplot(1,2,2),imshow(reconstruction);
