function [models] = trainBTS(Xtrain, Ytrain, kernel, verbose)
%TRAINBTS Summary of this function goes here
%   Detailed explanation goes here

% Initialize
    remainingClasses = unique(Ytrain);
    numberClasses = length(remainingClasses);
    models = cell((numberClasses * (numberClasses -1)) /2, 1);
    
% Build subtree
    models = buildBTSTree(models, Xtrain, Ytrain, kernel, verbose);
    
end

