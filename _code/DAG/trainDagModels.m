function [models] = trainDagModels(Xtrain, Ytrain, numberClasses, ...
                    kernel, verbose)
%TRAINDAGMODELS Summary of this function goes here
%   Detailed explanation goes here
    
    models = cell(numberClasses);
    for i = 1:numberClasses-1
        for j = i+1:numberClasses
            trainIdx = ismember(Ytrain, [i j]);
            y = Ytrain(trainIdx);
            y(y==i) = -1; y(y==j) = 1;
            x = Xtrain(trainIdx, :);
            models{i, j} = fitSVM(x, y, kernel, verbose);
        end
    end
end

