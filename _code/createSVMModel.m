function [SVMModel, trainId] = createSVMModel(X, Y, ...
     kernel, pTrain, verbose)
%CREATESVMMODEL Summary of this function goes here
%   Detailed explanation goes here
    
    if ~exist('pTrain', 'var'); pTrain = 0.8; end
    if ~exist('slice', 'var'); slice = -1; end
    if ~exist('verbose', 'var'); verbose = 0; end

    % Train and Predict
    trainId = separateTrainAndTest(Y, pTrain);
    [Xtrain, Xpredict, Ytrain, Ypredict] = getTrainTestData(X, Y, trainId);
    SVMModel = fitSVM(Xtrain, Ytrain, kernel, verbose);
end

