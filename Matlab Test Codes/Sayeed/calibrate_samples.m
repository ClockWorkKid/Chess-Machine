function [all_theta,Class_vals] = calibrate_samples()
X = [] ;
y = [] ;
Class_vals = [] ;
file_name = ["sample_RED","sample_BLUE","sample_WHITE","sample_BLACK"] ;
n = length(file_name) ;

% Create Data Set
for i = 1:n
    
    path = [char(file_name(i)),'.png'];
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

% One vs all training
lambda = 0.1;
[all_theta] = myOneVsAll(X, y, n, lambda);

% Prediction Accuracy test
%pred = myPredictOneVsAll(all_theta, X);
%fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

save('calib_data.mat','all_theta','Class_vals');

end





