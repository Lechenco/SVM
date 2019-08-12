function [SVMModel] = fitSVM(Xtrain, Ytrain, kernel, verbose)
%FITSVM Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('kernel', 'var'); kernel = 'linear'; end
    if ~exist('verbose', 'var'); verbose = 0; end
    
    disp('Training SVM Model...')
    SVMModel = fitcsvm(Xtrain, Ytrain, 'KernelFunction', kernel, ...
'KernelScale','auto', 'verbose', verbose);
end

