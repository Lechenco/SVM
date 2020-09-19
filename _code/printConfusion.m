function [] = printConfusion(predictLabels, trueLabels)
%PRINTCONFUSION prints confusion matrix from the binaries array 
% Ypredict and trueLabels
% 
%  printConfusion(predictLabels, trueLabels)
% 
% PARAMETERS
%     predictLabels - Labels array from the predict techinique
%     trueLabels - Label arrays from the dataset with the right labels. 

    [CM, order] = confusionmat(trueLabels, predictLabels);
    
    disp('Confusion Matrix:')
    fprintf("T\\P \t %d \t %d\n", order(1), order(2));
    fprintf("%d \t %d \t %d\n", order(1), CM(1,1), CM(1, 2));
    fprintf("%d \t %d \t %d\n\n", order(2), CM(2,1), CM(2, 2));
end

