% Access a Matrox(R) frame grabber attached to a Pulnix TMC-9700 camera, and
% acquire data using an NTSC format.  
% vidobj = videoinput('matrox',1,'M_NTSC_RGB');

% Open a live preview window.  Point camera onto a piece of colorful fabric.
% preview(vidobj);

% Capture one frame of data.
% fabric = getsnapshot(vidobj);
% imwrite(fabric,'fabric.png','png');

% Delete and clear associated variables.
% delete(vidobj)
% clear vidobj;
%%
fabric = imread('D:\Workspace\Term Project MATLAB\Sample Game\image (5).jpg');
figure(1), subplot(2,3,1), imshow(fabric), title('fabric');
%% Calculate Sample Colors in L*a*b* Color Space for Each Region
load regioncoordinates;

nColors = 6;
sample_regions = false([size(fabric,1) size(fabric,2) nColors]);

for count = 1:nColors
  sample_regions(:,:,count) = roipoly(fabric,region_coordinates(:,1,count),...
                                      region_coordinates(:,2,count));
  figure(2)
  subplot(2,3,count),imshow(sample_regions(:,:,count));
end


%% Convert your fabric RGB image into an L*a*b* image using rgb2lab .
%Calculate the mean 'a*' and 'b*' value for each area that you extracted 
% with roipoly. These values serve as your color markers in 'a*b*' space.
lab_fabric = rgb2lab(fabric);
a = lab_fabric(:,:,2);
b = lab_fabric(:,:,3);
color_markers = zeros([nColors, 2]);

for count = 1:nColors
  color_markers(count,1) = mean2(a(sample_regions(:,:,count)));
  color_markers(count,2) = mean2(b(sample_regions(:,:,count)));
end

fprintf('[%0.3f,%0.3f] \n',color_markers(2,1),color_markers(2,2));

%% Classify Each Pixel Using the Nearest Neighbor Rule
color_labels = 0:nColors-1;
a = double(a);
b = double(b);
distance = zeros([size(a), nColors]);

% Perform classification
for count = 1:nColors
  distance(:,:,count) = ( (a - color_markers(count,1)).^2 + ...
                      (b - color_markers(count,2)).^2 ).^0.5;
end

[~, label] = min(distance,[],3);
label = color_labels(label);
clear distance;

%% Display Results of Nearest Neighbor Classification

rgb_label = repmat(label,[1 1 3]);
segmented_images = zeros([size(fabric), nColors],'uint8');

for count = 1:nColors
  color = fabric;
  color(rgb_label ~= color_labels(count)) = 0;
  segmented_images(:,:,:,count) = color;
end 

figure(1)
subplot(2,3,2), imshow(segmented_images(:,:,:,2)), title('red objects');
subplot(2,3,3), imshow(segmented_images(:,:,:,3)), title('green objects');
subplot(2,3,4), imshow(segmented_images(:,:,:,4)), title('purple objects');
subplot(2,3,5), imshow(segmented_images(:,:,:,5)), title('magenta objects');
subplot(2,3,6), imshow(segmented_images(:,:,:,6)), title('yellow objects');

%%
%Display 'a*' and 'b*' Values of the Labeled Colors.

purple = [119/255 73/255 152/255];
plot_labels = {'k', 'r', 'g', purple, 'm', 'y'};

figure (3)
for count = 1:nColors
  plot(a(label==count-1),b(label==count-1),'.','MarkerEdgeColor', ...
       plot_labels{count}, 'MarkerFaceColor', plot_labels{count});
  hold on;
end
  
title('Scatterplot of the segmented pixels in ''a*b*'' space');
xlabel('''a*'' values');
ylabel('''b*'' values');

%%


