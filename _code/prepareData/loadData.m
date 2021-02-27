function [Xtrain, Xtest, Ytrain, Ytest] = loadData(svmData, labels, classesStr)
%LOADDATA Summary of this function goes here
%   Detailed explanation goes here

    data = svmData;
    characteristics = [1:20]; %[1:10 17:20]; % Characteristics columns
    pTrain = 0.7;
    slice = 200;

    % Preparar classes
    dataIdx = separateClassesFromData(labels, classesStr);
    data = data(dataIdx, :);
    labels = labels(dataIdx);

    classes = ecodeClasses(labels, classesStr);
    
    Y = classes;
    X = data(:, characteristics);
    [Xtrain, Xtest, Ytrain, Ytest] = prepareAndSplitData(X, Y, classesStr, pTrain, slice);
end

