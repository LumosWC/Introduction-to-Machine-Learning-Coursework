
%??????????????7291?raw file???X?Y matrix??

X = [ones(1,7291);traindata(:,2:257)'];
Y = traindata(:,1)';
W = zeros(1,257)';
%weight=perceptronlimit(X,Y,W);