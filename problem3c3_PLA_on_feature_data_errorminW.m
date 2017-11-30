featurestrain = load('features.train');
featurestest = load('features.test');

n_train = 7291;                 %n = number of training data
dplusone = 3;             %featured data dimension is 2

%put the featured training data into the right matrix (X,Y) form
X_train = [ones(1,n_train);featurestrain(:,2:dplusone)'];
Y_train = featurestrain(:,1)';


%figure;hold on
%title ('2-D Featured Digit Scatter : Blue(2) Red(8)');
%xlabel('Intensity');
%ylabel('Symmetry');

for i = 1:n_train
    
    if Y_train(i) == 2                    %digit two(2)   is classified as +1, rep by blue dots
        %plot(X_train(2,i),X_train(3,i),'bo');
        Y1_train(i) = 1;
        X1_train(:,i) = X_train(:,i);           %X1 is used to store only the X-columns of 2 and 8 
        
    end
    if Y_train(i) == 8
       % plot(X_train(2,i),X_train(3,i),'ro');   %digit eight(8) is classified as -1, rep by red dots
        Y1_train(i) = -1;
        X1_train(:,i) = X_train(:,i); 
    end
    
    if (Y_train(i) ~= 2) && (Y_train(i) ~= 8)   %all the rest of digits are rep by green dots
       % plot(X_train(2,i),X_train(3,i),'g.');
        Y1_train(i)=0;
        X1_train(:,i) = [0 0 0]';         %X1 is used to store only the X-columns of 2 and 8, and just a column of zeros for non-2&8
    end
end

Y1_train( :, all(~Y1_train,1) ) = [];           %These two lines are for erasing the columns in the matrix with all zeros
X1_train( :, all(~X1_train,1) ) = [];

X_pi = inv((X1_train*X1_train'))*X1_train;
W_init = X_pi*Y1_train';

maxupdate = 200;                            %The maximun number of updates we wanna investigate
trainerror = zeros(1,maxupdate);            %Reverse the same amount of empty vector space for the error of each No.update

i=0;
for update = 1:maxupdate
    W = W_init;
    i=i+1;                   
    [singleweight,e]=perceptronlimit(X1_train,Y1_train,W,update);
    %classerror=trainingerror;
    allweight(:,i)=singleweight;
    trainerror(i)=e;
end

%plot the training classification error
m = 1:maxupdate;
figure;
plot(m,trainerror);
title('3c3-Training Data - 2D Features - minSquaredError-original');
xlabel('Number of Updates');
ylabel('Classificaiton Error in Training');

%plot the test classification error
n_test = 2007;
X_test = [ones(1,n_test);featurestest(:,2:dplusone)'];
Y_test = featurestest(:,1)';

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
title('3c3-Testing Data - 2D Features - minSquaredError-original');
xlabel('Number of Updates');
ylabel('Classificaiton Error in Testing');
