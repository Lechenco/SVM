function [predictLabel] = predictOAOModels(modelsOAO, Xtest)
%PREDICTOAOMODELS Summary of this function goes here
%   Detailed explanation goes here

    predictLabel = [];
    for k = 1:length(modelsOAO)
        [label, ~] = predict(modelsOAO{k}, Xtest);
        predictLabel = [predictLabel label];
    end

    predictLabel = mode(predictLabel,2);  
end

