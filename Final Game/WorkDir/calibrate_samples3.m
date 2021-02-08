function [] = calibrate_samples3(I)

%{
usage
-----------
running the code opens the first image from where you have to take
samples. Once the image is open, see the instruction on the title
clicking starts a polygon, set as many points as you want, close the 
polygon by clicking on the initial point. Then you can move it around
or reshape it as you want. After selecting the necessary region
double click on the polygon to move on to the next sampling.
You can zoom on the figure window for better accuracy while selection
%}

X = [] ;
y = [] ;
Class_vals = [] ;
colorName = ["RED","BLUE","WHITE","BLACK"] ;
n = length(colorName) ;

I = im2double(I);

% Create Data Set
for i = 1:n
    
    imshow(I);
    text = ['Select color sample for ==> ',char(colorName(i))];
    title(text);
    BW = roipoly();
    
    croppedI = I .* BW ;
    
    croppedIR = croppedI(:,:,1);
    croppedIG = croppedI(:,:,2);
    croppedIB = croppedI(:,:,3);
    
    croppedIR = croppedIR(:);
    croppedIG = croppedIG(:);
    croppedIB = croppedIB(:);
    
    croppedI = [croppedIR, croppedIG, croppedIB]; %unrolled vector form
    croppedI( ~any(croppedI,2), : ) = [];  %get rid of zero rows
    
    m = length(croppedI) ;
    
    R_med = median(croppedI(:,1));
    G_med = median(croppedI(:,2));
    B_med = median(croppedI(:,3));
    
    
    X = [X ; [ones(m,1) , croppedI] ] ;
    y = [y ; ones(m,1)*i] ;
    Class_vals = [Class_vals , [R_med ; G_med ; B_med]];
    
    
end

% One vs all training
lambda = 0.1;
[all_theta] = myOneVsAll(X, y, n, lambda);

% Prediction Accuracy test
% pred = myPredictOneVsAll(all_theta, X);
% fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

imshow(I);
text = ['Select ==> BOARD REGION'];
title(text);
BW = roipoly();

save('calib_data_webcam.mat','all_theta','Class_vals','BW');
close

end





