function [accuracy, precision, recall, f1score] =...
            getMetrics(predictLabels, trueLabels)
%GETMETRICS return the mainly metrics from predict data of binary class
% 
% [accuracy, precision, recall, f1score] = getMetrics(predictLabels, trueLabels)
% 
% PARAMETERS
%     predictLabels - Labels array from the predict techinique
%     trueLabels - Label arrays from the dataset with the right labels.
%     
% RETURN
%     accuracy - (truePositive + trueNegative) / N
%     precision - truePositive / (truePositive + falsePositive)
%     recall - truePositive / (truePositive + falseNegative)
%     f1score - 2 * precision * recall / (precision + recall)

    [CM, order] = confusionmat(trueLabels, predictLabels);
    
    truePositive = CM(1,1); falseNegative = CM(1,2);
    falsePositive = CM(2,1); trueNegative = CM(2,2);
    
    precision = truePositive / (truePositive + falsePositive);
    recall = truePositive / (truePositive + falseNegative);
    accuracy = (trueNegative + truePositive) / length(trueLabels);
    f1score = 2 * (precision * recall) / (precision + recall);
end

