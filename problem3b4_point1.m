
for z =1:100
overallweight = zeros(3,9);

for n = 100:50:500
                  %set the amount of train data set
trainingdata = n;

X=[ones(1,trainingdata);rand(2,trainingdata)];   % scatter points in the unit-square randomly

%corrspond each X to Y-------------------------------
Y = zeros(1,trainingdata);

for i = 1:trainingdata
    if X(3,i)-X(2,i) >= 0.1+0.1
        Y(i) = 1;
        %plot(X(2,i),X(3,i),'bo');
    end
    if X(3,i)-X(2,i) < 0.1
        Y(i) = -1;
        %plot(X(2,i),X(3,i),'ro');
    end
    if(X(3,i)-X(2,i)<0.1+0.1)&&(X(3,i)-X(2,i)>0.1)
        Y(i)=0;
        X(:,i)=zeros(1,3)';
    end    
    
end 
%-------------------------------------------------------

%perceptron starts----------------------------------------
Y( :, all(~Y,1) ) = [];          %These two lines are for erasing the columns in the matrix with all zeros
X( :, all(~X,1) ) = [];

W=[0 0 0]';
weight=perceptron(X,Y,W);
overallweight(:,trainingdata/50-1) = weight;

%-----------------------------------------------------------

%plot the separation line
%realweight = [weight(2) weight(3)];
%threshold = weight(1);
%plotpc (realweight,threshold);

%for m = 1:9
%    realweight = [overallweight(2,m) overallweight(3,m)];
%    threshold = overallweight(1,m);
%    plotpc (realweight,threshold);
%end
end

%creating 1000 test points

X_test=[ones(1,1000);rand(2,1000)];   % scatter points in the unit-square randomly

%corrspond each X to Y-------------------------------
Y_test = zeros(1,1000);


for i = 1:1000
    if X_test(3,i)-X_test(2,i) >= 0.1+0.1
        Y_test(i) = 1;
        %plot(X_test(2,i),X_test(3,i),'b.');
    end
    if X_test(3,i)-X_test(2,i) < 0.1
        Y_test(i) = -1;
        %plot(X_test(2,i),X_test(3,i),'r.');
    end
     if (X_test(3,i)-X_test(2,i) < 0.1+0.1)&& (X_test(3,i)-X_test(2,i) > 0.1)
        Y_test(i)=0;
        X_test(:,i) = zeros(1,3)';
    end
end

Y_test( :, all(~Y_test,1) ) = [];           %These two lines are for erasing the columns in the matrix with all zeros
X_test( :, all(~X_test,1) ) = [];

for trainsize = 100:50:500
    errortime = 0;
    weight = overallweight(:,trainsize/50-1);
    for p = 1 : size(X_test,2)                          %364: No. of 2 and 8 in the test data set (given)
        if sign(weight'*X_test(:,p))~=Y_test(p)
           errortime = errortime + 1;
        end
    end
    testerror(trainsize/50-1) = (errortime/1000)*100;
end
totalerror(z,:)=testerror;
end

%trainsize = 100:50:500;
%figure;hold on
%plot( trainsize,testerror);
%xlabel('Number of Training Data');
%ylabel('Test Classification Error');
%title('Test Error against Number of Training Data');

sortederror=sort(totalerror,'descend');
for h = 1:9
top5(h) = mean(sortederror(1:5,h));
bot5(h) = mean(sortederror(96:100,h));
confidence(h) = mean(sortederror(6:95,h));
end

figure;hold on
m = 100:50:500;
plot (m,top5);
plot (m,bot5);
plot (m,confidence);
legend ('Best 5%','Worst 5%','90% confidence interval');
xlabel('Number of Training Points');
ylabel('Test Error (%)');
title('3b4-Test Error against Number of Training Points-Sep=0.1')