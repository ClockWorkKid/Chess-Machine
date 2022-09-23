function [J, grad] = myCostFunction(theta, X, y, lambda)


[m n] = size(X);

g =  (1.0 + exp(-(X*theta))).^(-1);

J = -(1/m)*(y'*log(g) + (1-y)'*log(1-g)) + lambda/(2*m) *([0;theta(2:n)]'*[0;theta(2:n)]);

grad = 1/m*(X'*(g-y)) + lambda/m * [0;theta(2:n)];

grad = grad(:);

end
