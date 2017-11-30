function [w_pocket,errorvector] = perceptron_modified(X,Y,w_init,update)
errorvector = zeros(1,update);
w_pocket = w_init;
pocketerror = 1;

for iteration = 1 : update%Since digit data are not linearly separable, so we have to limit the number of updates
    i = iteration;
      %pocketerror = sum(sign(w_pocket'*X)~=Y)/size(X,2);
      %pocketerror = 1;
  for ii = 1 : size(X,2)                                     %cycle through training set
      %pocketerror = sum(sign(w_pocket'*X)~=Y)/size(X,2);
        
        if sign(w_pocket'*X(:,ii)) ~= Y(ii)                       %wrong decision spotted
                  w_hand = w_pocket + X(:,ii) * Y(ii);                    %calculate the error if w would be updated
                  %handerror = sum(sign(w_hand'*X)~=Y)/size(X,2);
%---------------------------------------------------------------------------------------
                  errorcount = 0;                 
                  for p = 1 : size(X,2)  
                             
                             if sign(w_hand'*X(:,p))~=Y(p)
                                       errorcount = errorcount + 1;
                             end
                             
                  end
                  
                  
                  handerror = errorcount/size(X,2);
%----------------------------------------------------------------------------------------
        
                  if handerror < pocketerror
                      
                        w_pocket = w_pocket + X(:,ii) * Y(ii);  %update w
                      
                        pocketerror = handerror;
                  end
                 
             errorvector(i)=pocketerror;
       
        end
        
  end   
end
minerror = errorvector(update);