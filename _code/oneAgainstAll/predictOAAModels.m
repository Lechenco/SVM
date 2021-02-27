function [predictLabel] = predictOAAModels(modelsOAA, Xtest)
%PREDICTOAAMODELS Summary of this function goes here
%   Detailed explanation goes here

    predictLabels = [];
    predictScore = [];
    for k = 1:length(modelsOAA)
        [label, score] = predict(modelsOAA{k}, Xtest);
        predictLabels = [predictLabels label];
        predictScore = [predictScore score(:,2)];
    end  
    [~, i] = max(predictScore, [], 2);

    predictLabel = zeros(length(Xtest), 1);
    for j = 1:length(predictLabel)
        predictLabel(j) = predictLabels(j, i(j));
        
        if predictLabel(j) ~= -1
        disp(predictScore(j, i(j)))
        end
    end
end

