% input samples
X1=[ones(1,10);rand(1,10);rand(1,10)];   % class '+1'
X2=[ones(1,10);rand(1,10)+1;rand(1,10)]; % class '-1'
X=[X1,X2];
 
% output class [-1,+1];
Y=[-ones(1,10),ones(1,10)];
 
% init weigth vector
W=[0 0 0]';
 

figure;hold on
plot(X1(2,:),X1(3,:),'b.')
plot(X2(2,:),X2(3,:),'r.')
 
plot(X(2,ytag<0),X(3,ytag<0),'bo')
plot(X(2,ytag>0),X(3,ytag>0),'ro')
legend('class -1','class +1','pred -1','pred +1')
