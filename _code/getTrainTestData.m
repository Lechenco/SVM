function [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, p)
%GETTRAINTESTDATA return the train and test data
% arrays.
% 
% [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, p)
% 
% PARAMETERS:
%     X - NxM characteristics Matrix.
%
%     Y - N labeled intance array.
%
%     p [OPTIONAL] - Double number for the 
%     proportion between test and train (default: 0.8).
%
% RETURN:
%     Xtrain - (N*p)xM matrix with the training characteristics.
% 
%     Xtest - N*(1-p)xM matrix with the testing characteristics
%     
%     Ytrain - N*p array with the training labels.
%     
%     Ytest - N*(1-p) array with the testing labels.
    
    if ~exist('p', 'var'); p = 0.8; end
    
    [train, test] = separateTrainAndTest(Y, p);
    Xtrain = X(train, :);
    Ytrain = Y(train);
    Xtest = X(test, :);
    Ytest = Y(test);
    
end

