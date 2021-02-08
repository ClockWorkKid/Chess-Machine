function [centroidArray,hueArray] = segmentation(Im) 
redThreshold=0;
greenThreshold=0;
blueThreshold=0;
dustRemove=4;
% redHighLimit = 360;
% redLowLimit = 350;
moreSaturation=.9;
moreBrightness=1;
rgbDiff=25;


% redFlag= false; 
% if strcmp(color,'red')
%     redFlag= true;
%     hueLowerLimit=1;
%     hueUpperLimit=10;
%     
%  elseif strcmp(color,'blue')
%      hueLowerLimit=175;
%      hueUpperLimit=245;
%  elseif strcmp(color,'green')
%      hueLowerLimit=75;
%      hueUpperLimit=165;
%  elseif strcmp(color,'orange')
%      hueLowerLimit=11;
%      hueUpperLimit=51;
%  elseif strcmp(color,'yellow')
%      hueLowerLimit=52;
%      hueUpperLimit=74;
%      
% end


%red hue 1-10 1-14
%blue hue 215-245 175-245
%green hue 75-140 61-165 75-165
%yellow hue 45-60 52-74
%orange/brown hue       15-51

Im=im2double(Im);
%%%%%
Im = rgb2hsv(Im);
colorSaturated=Im(:,:,2)*moreSaturation;
Hue= Im(:,:,1) ;

brightness= Im(:,:,3)*moreBrightness;

Im = cat(3,Hue,colorSaturated, brightness );
Im = hsv2rgb(Im);

%%%%%


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

figure,imshow(cat(3,imR,imG,imB));

% colorSaturated=Index(:,:,2)*moreSaturation;
% color(:,:,2)=colorSaturated;
% 
% brightness= Index(:,:,3)*moreBrightness;
% color(:,:,3)=brightness;



imBinaryR= imbinarize(imR,redThreshold/255);
imBinaryG= imbinarize(imG,greenThreshold/255);
imBinaryB= imbinarize(imB,blueThreshold/255);

% imBinaryR= imbinarize(imR,graythresh(imR));
% imBinaryG= imbinarize(imG,graythresh(imG));
% imBinaryB= imbinarize(imB,graythresh(imB));
% 
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






median(F(labels==2));


hueArray = zeros(numLabels,1 );
for i=1:numLabels
    median1 = median(F(labels==i)); 
    if median1==0
        median1=5/360;
    end
     F(labels==i) = median1;
     hueArray(i) = median1;
%      gLabel(labels==i) = median(imG(labels==i));
%      bLabel(labels==i) = median(imB(labels==i));
       
end

imghsv = cat(3, F , F1,F2);
% F=imghsv(:,:,1);
% F1=imghsv(:,:,2);
% F2=imghsv(:,:,3);
% for i=1:imageRow
%     for j=1:imageColumn
%         if((F(i,j)<=2) || (F(i,j)>=358/360))
%             F(i,j)=5/360;
%         end
%     end
% end
% 
% imghsv = cat(3,F,F1,F2);
%pick color

 
% if redFlag==true 
%     Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
%      &(imghsv(:,:,1)<=hueUpperLimit/360))...
%      |((imghsv(:,:,1)<=redHighLimit/360)&(imghsv(:,:,1)>=redLowLimit/360)));
% else


stats=zeros(numLabels,2);
for i=1:numLabels
% Index=(((imghsv(:,:,1)>=hueLowerLimit/360)...
%      &(imghsv(:,:,1)<=hueUpperLimit/360)));
% end
Index = (imghsv(:,:,1)== hueArray(i));
 
 
% 
% Index=repmat((imghsv(:,:,1)>hueLowerLimit/360)...
%     &(imghsv(:,:,1)<hueUpperLimit/360),[1 1 3]);   
% color=imghsv.*Index;

% %Saturate it

% colorSaturated=Index(:,:,2)*moreSaturation;
% color(:,:,2)=colorSaturated;
% 
% brightness= Index(:,:,3)*moreBrightness;
% color(:,:,3)=brightness;

% %put it back
%newHsv=imghsv;
%Index(:,:,2)=color;
%newHsv(Index)=color(Index);

%figure,imshow(Index);
impixelinfo(gcf);


%figure,imshow(Index);
centroidData = regionprops(Index,'Centroid');
stats(i,1)=centroidData.Centroid(1);
stats(i,2)=centroidData.Centroid(2);
end
centroidArray = stats;

% for i=1:length(stats)
% stats(i).Centroid
% end
end


