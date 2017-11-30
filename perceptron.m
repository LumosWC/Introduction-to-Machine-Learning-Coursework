function [w] = perceptron(X,Y,w_init)

t=0;                            %initialist the number of iterations                
p=1;                            %dummy variable(for getting out of the loop)
w = w_init; 
while(p~=t)                     %stopping criterion, stops if t doesnt update, that means no points are missclassified anymore
  p=t;
  for n = 1 : size(X,2)         %cycle through training set
    if sign(w'*X(:,n)) ~= Y(n)  %wrong decision?
      w = w + X(:,n) * Y(n);    %then add (or subtract) this point to w
      t=t+1;
    end
  end
end
numberofupdate = t;