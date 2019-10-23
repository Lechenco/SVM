function [modelsOAA] = trainOAAModels(Xtrain, Ytrain, numberClasses,...
                        kernel, verbose)
%TRAINOAAMODELS Summary of this function goes here
%   Detailed explanation goes here

    modelsOAA = cell(numberClasses, 1);
    k = 1;
    for i = 1:numberClasses
        trainIdx = ismember(Ytrain, i);
        y = Ytrain;
        y(~trainIdx) = -1;
        modelsOAA{k} = fitSVM(Xtrain, y, kernel, verbose);
        k = k+1;
    end
end

