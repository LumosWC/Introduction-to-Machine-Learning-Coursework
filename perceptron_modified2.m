function[w_pocket,errorvector] = perceptron_modified2(X,Y,w_hand,update)
%Pocket Algorithm with output of the Weight in pocket and the error vector
%containing all the error against No.Update


                    
pocketerror = Inf;              %set the initial pocket error to infinity,
errorvector = zeros (1,update); %reserve space for error vector


for n = 1:update
    
    handerror = 0;
 %--------------   
    for i = 1:size(X,2)
       if sign(w_hand'*X(:,i))~=Y(i)
            w_hand = w_hand + X(:,i)*Y(i);
            handerror = handerror + 1;
        end
    end
    
    if  pocketerror > handerror
                pocketerror = handerror;
                w_pocket = w_hand;
    end
    
    errorvector (n) = pocketerror;
end


    errorvector = (errorvector/size(X,2))*100;
end
    