function [SVMModel] = fitSVM(Xtrain, Ytrain, kernel, verbose)
%FITSVM train a new SVMModel for binary classification
% 
%   [SVMModel] = fitSVM(Xtrain, Ytrain, kernel, verbose)
% 
%   PARAMETERS:
%     Xtrain - Matrix NxM sized where N are
%     the number of training instacies and M
%     the number of characteristic.
% 
%     Ytrain - N-sized array contained the label
%     for the training instancies.
% 
%     kernel [OPTIONAL]- determines the SVM kernel for the
%     training, can be 'linear' (default), 'rbf'
%     or 'polynomial'.
% 
%     verbose [OPTIONAL]- integer that determines the
%     verbose mode:
%         0 (default) - verbose off,
%         1 - displays diagnostic messages 
%         and saves convergence criteria every numprint 
%         iterations (defaul: 1000),
%         2 - displays diagnostic messages 
%         and saves convergence criteria at every iteration.
% 
%   RETURN:
%     SVMModel - struct with the trained SVM
%     
% 
    if ~exist('kernel', 'var'); kernel = 'linear'; end
    if ~exist('verbose', 'var'); verbose = 0; end
    
    classes = unique(Ytrain);
    w = ones(size(Ytrain, 1), 1);
    y1 = find(Ytrain == classes(1)); y2 = find(Ytrain == classes(2));
    n1 = length(y1);
    n2 = length(y2);
    
    w(y1) = 1 - n1 / (n1 + n2);
    w(y2) = 1 - n2 / (n1 + n2);
    
    c = cvpartition(length(Ytrain),'KFold',10);
    opts = struct('Optimizer','bayesopt','ShowPlots',false,'CVPartition',c,...
    'AcquisitionFunctionName','expected-improvement-plus');
    
    disp('Training SVM Model...')
    SVMModel = fitcsvm(Xtrain, Ytrain, 'KernelFunction', kernel, ...
'OptimizeHyperparameters','all', 'HyperparameterOptimizationOptions',opts);

end

