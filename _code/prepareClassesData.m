function [Xtrain, Ytrain, Xtest, Ytest] = prepareClassesData(svmData,...
                characteristics, slice, pTrain, numberClasses)
%PREPARECLASSESDATA Summary of this function goes here
%   Detailed explanation goes here

    Y = svmData(:, end);
    X = svmData(:, characteristics);
    idxTrain = [];
    idxTest = [];
    for j = 1:numberClasses
       aux = find(Y == j);
       aux = aux(randperm(length(aux)));
       aux = aux(1:slice);
       idxTrain = [idxTrain; aux(1:slice*pTrain)];
       idxTest = [idxTest; aux(slice*pTrain +1:end)]; 
    end
    Ytrain = Y(idxTrain);
    Xtrain = X(idxTrain, :);
    Ytest = Y(idxTest);
    Xtest = X(idxTest, :);
end

