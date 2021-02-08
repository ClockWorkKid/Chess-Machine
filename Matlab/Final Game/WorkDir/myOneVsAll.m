function [all_theta] = myOneVsAll(X, y, num_labels, lambda)


m = size(X, 1);
n = size(X, 2);

all_theta = [] ;

    initial_theta = zeros(n , 1);

    for k = 1 : num_labels 
        options = optimset('GradObj', 'on', 'MaxIter', 50);
        
        theta = myfmincg (@(t)(myCostFunction(t, X, (y == k), lambda)), ...
                initial_theta, options);
        all_theta = [ all_theta ; theta' ] ;
    end
       

end
