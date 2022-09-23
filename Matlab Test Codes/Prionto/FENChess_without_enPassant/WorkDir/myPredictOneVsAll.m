function p = myPredictOneVsAll(all_theta, X)

m = size(X, 1);
num_labels = size(all_theta, 1);

p = zeros(size(X, 1), 1);


A = 1./(1+exp(-(X*all_theta')));
[v p] = max(A');
p=p';

end
