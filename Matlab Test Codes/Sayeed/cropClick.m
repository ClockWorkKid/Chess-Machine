function croppedImage = cropClick(I);
figure;
imshow(I);

croppedImage= im2double(I);
[r c] = ginput; %[r c] = ginput(4);

BW = roipoly(croppedImage,r,c);

[R C] = size(BW);

for i = 1:R
     for j= 1:C
         if BW(i,j) == 0
             croppedImage(i,j,1) = 0;
             croppedImage(i,j,2) = 0;
             croppedImage(i,j,3) = 0;
         end
     end
end
end