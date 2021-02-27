function [Xtrain, Xtest, Ytrain, Ytest] = prepareAndSplitData(X, Y, classesStr, pTrain, slice)
%PREPAREANDSPLITDATA Summary of this function goes here
%   Detailed explanation goes here

    idxTrain = [];
    idxTest = [];
    numberClasses = length(classesStr);
    for j = 1:numberClasses
       aux = find(Y == j);
       nSamples = length(aux);
       nTrain = int32(nSamples*pTrain);

       rng(1);
       aux = aux(randperm(nSamples)); %randomize samples

       %if classesStr(j) == "(N"
           aux = aux(1:slice);
           nSamples = length(aux);
           nTrain = int32(nSamples*pTrain);
       %end
       idxTrain = [idxTrain; aux(1:nTrain)];
       idxTest = [idxTest; aux(nTrain +1:end)]; 
    end
    Ytrain = Y(idxTrain);
    Xtrain = X(idxTrain, :);
    Ytest = Y(idxTest);
    Xtest = X(idxTest, :);
end

