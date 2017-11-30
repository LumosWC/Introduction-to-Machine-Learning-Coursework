rawtrain = load('zip.train');
rawtest = load('zip.test');


n_train = 7291;                 %n = number of training data
dplusone = 257;             %featured data dimension is 256

%put the featured training data into the right matrix (X,Y) form
X_train = [ones(1,n_train);rawtrain(:,2:dplusone)'];
Y_train = rawtrain(:,1)';

W = zeros(1,dplusone)';  %initialise the weight vector


for i = 1:n_train
    
    if Y_train(i) == 2                    %digit two(2)   is classified as +1
        
        Y1_train(i) = 1;
        X1_train(:,i) = X_train(:,i);           %X1 is used to store only the X-columns of 2 and 8 
        
    end
    if Y_train(i) == 8
           %digit eight(8) is classified as -1
        Y1_train(i) = -1;
        X1_train(:,i) = X_train(:,i); 
    end
    
    if (Y_train(i) ~= 2) && (Y_train(i) ~= 8)   %all the rest of digits are rep by green dots
        
        Y1_train(i)=0;
        X1_train(:,i) = zeros(1,dplusone)';         %X1 is used to store only the X-columns of 2 and 8, and just a column of zeros for non-2&8
    end
end

Y1_train( :, all(~Y1_train,1) ) = [];           %These two lines are for erasing the columns in the matrix with all zeros
X1_train( :, all(~X1_train,1) ) = [];

maxupdate = 200;                            %The maximun number of updates we wanna investigate
trainerror = zeros(1,maxupdate);            %Reverse the same amount of empty vector space for the error of each No.update

i=0;
for update = 1:maxupdate
    i=i+1;                   
    [singleweight,e]=perceptronlimit(X1_train,Y1_train,W,update);
    %classerror=trainingerror;
    allweight(:,i)=singleweight;
    trainerror(i)=e;
end
%-------------NO USE----Only to plot the separator-------------------------
%realweight = [weight(2) weight(3)];
%threshold = weight(1);
%plotpc (realweight,threshold);
%---------------------------------------------------------------------------

%plot the training classification error
m = 1:maxupdate;
figure;
plot(m,trainerror);
title('3c2-Training Data - Raw-Original PLA');
xlabel('Number of Updates');
ylabel('Classificaiton Error in Training');

%plot the test classification error
n_test = 2007;
X_test = [ones(1,n_test);rawtest(:,2:dplusone)'];
Y_test = rawtest(:,1)';

for i = 1:n_test
    
    if Y_test(i) == 2                    %digit two(2)   is classified as +1, rep by blue dots
        Y1_test(i) = 1;
        X1_test(:,i) = X_test(:,i);           %X1 is used to store only the X-columns of 2 and 8 
        
    end
    if Y_test(i) == 8
         %digit eight(8) is classified as -1, rep by red dots
        Y1_test(i) = -1;
        X1_test(:,i) = X_test(:,i); 
    end
    
    if (Y_test(i) ~= 2) && (Y_test(i) ~= 8)   %all the rest of digits are rep by green dots
        Y1_test(i)=0;
        X1_test(:,i) = zeros(1,dplusone)';         %X1 is used to store only the X-columns of 2 and 8, and just a column of zeros for non-2&8
    end
end

Y1_test( :, all(~Y1_test,1) ) = [];           %These two lines are for erasing the columns in the matrix with all zeros
X1_test( :, all(~X1_test,1) ) = [];

for update = 1:maxupdate
    errortime = 0;
    weight = allweight(:,update);
    for p = 1 : 364                          %364: No. of 2 and 8 in the test data set (given)
        if sign(weight'*X1_test(:,p))~=Y1_test(p)
           errortime = errortime + 1;
        end
    end
    testerror(update) = errortime/364;
end

figure;
u = 1:maxupdate;
plot(u,testerror);
title('3c2-Testing Data - Raw-Original PLA');
xlabel('Number of Updates');
ylabel('Classificaiton Error in Testing');