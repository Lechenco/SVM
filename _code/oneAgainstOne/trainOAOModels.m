function [modelsOAO] = trainOAOModels(Xtrain, Ytrain, numberClasses, ...
                    kernel, verbose)
%TRAINOAOMODELS Summary of this function goes here
%   Detailed explanation goes here

    modelsOAO = cell(numberClasses * (numberClasses -1) / 2, 1);
    k = 1;
    for i = 1:numberClasses-1
          for j = i+1:numberClasses
                trainIdx = ismember(Ytrain, [i j]);
                y = Ytrain(trainIdx);
                x = Xtrain(trainIdx, :);
                modelsOAO{k} = fitSVM(x, y, kernel, verbose);
                k = k+1;
          end
    end
end

