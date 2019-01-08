function [Center, Indicator, iter, SS_error] = kmeans(X, K, maxIter)

Center = zeros(K, size(X,2));
Indicator = zeros(size(X,1),1);
R = randperm(size(X,1));
iter = 0;
Center = X(R(1:K), :);
temp = zeros(K, size(X,2));
SS_error = 0;
while 1
    fprintf('Iter : %d\n', iter+1);
    SqrDist = ml_sqrDist(transpose(X), transpose(Center));
    [dist, minIndex] = min(SqrDist,[],2);
    Indicator = minIndex;
    temp = Center;
    for i=1:K
        xi = X(Indicator==i,:);
        ck = size(xi,1);
        if ck ~= 0
            Center(i, :) = (1/ck) * sum(xi);
        end
    end
    
    if temp == Center
        break
    end
    
    iter = iter + 1;
    if iter >= maxIter
        %iter = iter - 1;
        break;
    end
end
for i=1:size(X,1)
    a = norm(X(i, :) - Center(Indicator(i),:));
    SS_error = SS_error + a^2;
end
end
