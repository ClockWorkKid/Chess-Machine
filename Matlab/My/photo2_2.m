close all
clear all
clc

print_index = 1 ;
data = [];
file_name = ["sample_RED","sample_BLUE","sample_WHITE","sample_BLACK"];
for i = 1:4
    
    %LOAD IMAGE
    
    path = ['D:\Workspace\Term Project MATLAB\Sample Game\',char(file_name(i)),'.jpg'];
    image = imread(path);
    
    %Threshold_Layers
    R_min = double(min(min(image(:,:,1))));
    R_max = double(max(max(image(:,:,1))));
    R_med = double(median(median(image(:,:,1))));
    
    G_min = double(min(min(image(:,:,2))));
    G_max = double(max(max(image(:,:,2))));
    G_med = double(median(median(image(:,:,2))));
    
    
    B_min = double(min(min(image(:,:,3))));
    B_max = double(max(max(image(:,:,3))));
    B_med = double(median(median(image(:,:,3))));
    
    data = [data;[R_med G_med B_med]];
    
    %Thresholded Image
    Image_NEW = ones(size(image));
    Image_NEW(:,:,1) = Image_NEW(:,:,1)* R_med ;
    Image_NEW(:,:,2) = Image_NEW(:,:,2)* G_med ;
    Image_NEW(:,:,3) = Image_NEW(:,:,3)* B_med ;
    Image_NEW = uint8(Image_NEW);
    
    
    subplot(2,4,print_index),imshow(image);
    print_index = print_index + 1 ;
    subplot(2,4,print_index),imshow(Image_NEW);
    print_index = print_index + 1 ;
    
    
end

data



