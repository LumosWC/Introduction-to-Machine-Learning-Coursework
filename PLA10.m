% input samples
X1=[ones(1,5);rand(1,5);rand(1,5)];   % class '+1'
X2=[ones(1,5);rand(1,5)+1;rand(1,5)]; % class '-1'
X=[X1,X2];
 
% output class [-1,+1];
Y=[-ones(1,5),ones(1,5)];

% plot original linear separable data
figure;hold on 
plot(X1(2,:),X1(3,:),'b.')
plot(X2(2,:),X2(3,:),'r.')

 
% init weigth vector
W=[0 0 0]';
 
% call perceptron
%[weight,error]=perceptron_modified(X,Y,W,100);
weight=perceptron(X,Y,W);
% predict

ytag=weight'*X;
 
 
% plot separation line
realweight = [weight(2),weight(3)];
threshold = weight(1);
plotpc(realweight,threshold);  %plotpc(W,B) takes these inputs, W:S-by-R weight matrix (R must be 3 or less),B:S-by-1 bias vector
title('3a-size=10');

% plot prediction over origianl data
%plot(X(2,ytag<0),X(3,ytag<0),'bo')
%plot(X(2,ytag>0),X(3,ytag>0),'ro')
%legend('class -1','class +1','pred -1','pred +1')