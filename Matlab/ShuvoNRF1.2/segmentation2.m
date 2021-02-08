function centroidArray = segmentation2(Im,color) 
redThreshold=20;
greenThreshold=20;
blueThreshold=20;
dustRemove=2;
redHighLimit = 360;
redLowLimit = 350;
%moreSaturation=2;
rgbDiff=20;


redFlag= false; 
if strcmp(color,'red')
    redFlag= true;
    hueLowerLimit=1;
    hueUpperLimit=10;
 elseif strcmp(color,'red1')
    hueLowerLimit=350;
    hueUpperLimit=360;
    
 elseif strcmp(color,'blue')
     hueLowerLimit=175;
     hueUpperLimit=245;
 elseif strcmp(color,'green')
     hueLowerLimit=75;
     hueUpperLimit=165;
 elseif strcmp(color,'orange')
     hueLowerLimit=11;
     hueUpperLimit=51;
 elseif strcmp(color,'yellow')
     hueLowerLimit=52;
     hueUpperLimit=74;
     
end


%red hue 1-10 1-14
%blue hue 215-245 175-245
%green hue 75-140 61-165 75-165
%yellow hue 45-60 52-74
%orange/brown hue       15-51

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

% imBinaryR= imbinarize(imR,graythresh(imR));
% imBinaryG= imbinarize(imG,graythresh(imG));
% imBinaryB= imbinarize(imB,graythresh(imB));
% 
imBinary=(imBinaryR & imBinaryG & imBinaryB);
figure,imshow(imBinary);
% 
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


% F=imghsv(:,:,1);
% F1=imghsv(:,:,2);
% F2=imghsv(:,:,3);
% for i=1:imageRow
%     for j=1:imageColumn
%         if((F(i,j)<=2/360) || (F(i,j)>=358/360))
%             F(i,j)=5/360;
%         end
%     end
% end
% 
% imghsv = cat(3,F,F1,F2);
%pick color

 
if redFlag==true 
    Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
     &(imghsv(:,:,1)<=hueUpperLimit/360)))...
   | ((imghsv(:,:,1)<=redHighLimit/360)&(imghsv(:,:,1)>=redLowLimit/360));
else
Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
     &(imghsv(:,:,1)<=hueUpperLimit/360)));
end
%  
 
% 
% Index=repmat((imghsv(:,:,1)>hueLowerLimit/360)...
%     &(imghsv(:,:,1)<hueUpperLimit/360),[1 1 3]);   
% color=imghsv.*Index;

% %Saturate it

%colorSaturated=color(:,:,2)*moreSaturation;
%color(:,:,2)=colorSaturated;

% %put it back
%newHsv=imghsv; 
%newHsv(Index)=color(Index);

figure,imshow(Index);
impixelinfo(gcf);

stats = regionprops(Index,'Centroid');
centroidArray = stats;

% for i=1:length(stats)
% stats(i).Centroid
% end
end


