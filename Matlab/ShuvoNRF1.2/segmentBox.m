function flagBox = segmentBox(Im, hueArray)
redThreshold=20;
greenThreshold=20;
blueThreshold=20;
dustRemove=2;

rgbDiff=30;

Im=im2double(Im);
[imageRow,imageColumn,~]=size(Im);


imR=squeeze(Im(:,:,1));
imG=squeeze(Im(:,:,2));
imB=squeeze(Im(:,:,3));

for i=1:imageRow
   for j=1:imageColumn
        if((abs(imR(i,j)-imG(i,j))<rgbDiff/255) && (abs(imR(i,j)-imB(i,j))...
                <rgbDiff/255)&& (abs(imB(i,j)-imG(i,j))<rgbDiff/255))
            imR(i,j)=0;
            imG(i,j)=0;
            imB(i,j)=0;
        end
    end
end
imshow(cat(3,imR,imG,imB));


imBinaryR= imbinarize(imR,redThreshold/255);
imBinaryG= imbinarize(imG,greenThreshold/255);
imBinaryB= imbinarize(imB,blueThreshold/255);

imBinary=(imBinaryR & imBinaryG & imBinaryB);
figure,imshow(imBinary);

imClean=imopen(imBinary,strel('disk',dustRemove));
imClean = imfill(imClean, 'holes');
imClean = imclearborder(imClean);

[labels, numLabels]=bwlabel(imClean);
disp(['Number of objects: ' num2str(numLabels)]);

rLabel=zeros(imageRow,imageColumn);
gLabel=zeros(imageRow,imageColumn);
bLabel=zeros(imageRow,imageColumn);

 for i=1:numLabels
     rLabel(labels==i) = median(imR(labels==i));
     gLabel(labels==i) = median(imG(labels==i));
     bLabel(labels==i) = median(imB(labels==i));
       
 end

imLabel = cat(3,rLabel,gLabel,bLabel);
figure,imshow(imLabel);
imghsv=rgb2hsv(imLabel);

F=imghsv(:,:,1);
F1=imghsv(:,:,2);
F2=imghsv(:,:,3);

median(F(labels==2))


hueArray = zeros(1,numLabels );
for i=1:numLabels
    median1 = median(F(labels==i)); 
    if median1==0
        median1=5/360;
    end
     F(labels==i) = median1;
     hueArray = median1
%      gLabel(labels==i) = median(imG(labels==i));
%      bLabel(labels==i) = median(imB(labels==i));
       
end

imghsv = cat(3, F , F1,F2);

Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
     &(imghsv(:,:,1)<=hueUpperLimit/360)));
 
 figure,imshow(Index);
impixelinfo(gcf);

stats = regionprops(Index,'Centroid');
centroidArray = stats;
flag = hueArray;

end