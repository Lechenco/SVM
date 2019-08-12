function [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, p)
%GETTRAINTESTDATA Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('p', 'var'); p = 0.8; end
    
    [train, test] = separateTrainAndTest(Y, p);
    Xtrain = X(train, :);
    Ytrain = Y(train);
    Xtest = X(test, :);
    Ytest = Y(test);
    
end

