function [w,trainingerror] = perceptronlimit(X,Y,w_init,update)

w = w_init;
for iteration = 1 : update       %Since digit data are not linearly separable, so we have to limit the number of updates
  for ii = 1 : size(X,2)         %cycle through training set
    if sign(w'*X(:,ii)) ~= Y(ii) %wrong decision spotted
      w = w + X(:,ii) * Y(ii);   %update w
    end
  end   
end
trainingerror=sum(sign(w'*X)~=Y)/size(X,2);