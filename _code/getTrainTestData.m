function [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, trainId)
%GETTRAINTESTDATA return the train and test data
% arrays.
% 
% [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, trainId)
% 
% PARAMETERS:
%     X - NxM-size characteristics Matrix.
%
%     Y - N-size labeled intance array.
%
%     trainId - N-size logical array index, separating
%     train Data (True) and test Data (False).
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
    
%     [train, test] = separateTrainAndTest(Y, p);
    Xtrain = X(trainId, :);
    Ytrain = Y(trainId);
    Xtest = X(~trainId, :);
    Ytest = Y(~trainId);
    
end

