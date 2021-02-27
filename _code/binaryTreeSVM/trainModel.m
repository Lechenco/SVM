function [model, y0Idx, y1Idx] = trainModel(Xtrain, Ytrain, choosenClasses, kernel, verbose)
%TRAINMODEL Summary of this function goes here
%   Detailed explanation goes here
    
    p = @(x) (1 ./ (1 + exp(-x)) - 0.5);
    treshold = 0.1;
    
    trainIdx = ismember(Ytrain, choosenClasses);
    y = Ytrain(trainIdx);
    x = Xtrain(trainIdx, :);
    
    disp([length(find(y == choosenClasses(1))) length(find(y == choosenClasses(2)))])
    
    % Train model
    model = fitSVM(x, y, kernel, verbose);
    
    remainingData = predict(model, Xtrain(~trainIdx, :));
    
    y0Idx = Ytrain == choosenClasses(1);
    aux = remainingData == choosenClasses(1) | abs(p(remainingData)) < treshold;
    y0Idx(~trainIdx) = aux;
    
    y1Idx = Ytrain == choosenClasses(2);
    aux = remainingData == choosenClasses(2) | abs(p(remainingData)) < treshold;
    y1Idx(~trainIdx) = aux;
    
end

