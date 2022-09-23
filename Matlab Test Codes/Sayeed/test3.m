path_pic = ['D:\Workspace\Term Project MATLAB\Sample Game\image (10).jpg'];
chess = imread(path_pic);

chess = im2double(chess);

R=chess(:,:,1);
G=chess(:,:,2);
B=chess(:,:,3);

new = [];
new(:,:,1) = R;
new(:,:,2) = G;
new(:,:,3) = B;

imshow(new);