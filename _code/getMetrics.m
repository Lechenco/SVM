function [accuracy, precision, recall, f1score] =...
            getMetrics(Ypredict, trueLabels)
%GETMETRICS Summary of this function goes here
%   Detailed explanation goes here
    
    [CM, order] = confusionmat(trueLabels, Ypredict);
    
%     disp('Confusion Matrix:')
%     fprintf("T\\P \t %d \t %d\n", order(1), order(2));
%     fprintf("%d \t %d \t %d\n", order(1), CM(1,1), CM(1, 2));
%     fprintf("%d \t %d \t %d\n", order(2), CM(2,1), CM(2, 2));
    
    truePositive = CM(1,1); falseNegative = CM(1,2);
    falsePositive = CM(2,1); trueNegative = CM(2,2);
    
    precision = truePositive / (truePositive + falsePositive);
    recall = truePositive / (truePositive + falseNegative);
    accuracy = (trueNegative + truePositive) / length(trueLabels);
    f1score = 2 * (precision * recall) / (precision + recall);
end

