function [accuracy, precision, recall, f1score] = ...
    printConfusionAndMetrics(predictLabels, trueLabels)
%PRINTCONFUSIONANDMETRICS return the mainly metrics from predict data 
% of binary class. Also prints the consfusion Matrix and this metrics on
% the console.
% 
% [accuracy, precision, recall, f1score] = printConfusionAndMetrics(predictLabels, trueLabels)
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

    printConfusion(predictLabels, trueLabels); 
    [accuracy, precision, recall, f1score] = ...
        getMetrics(predictLabels, trueLabels);
    fprintf("Accuracy: %.4f\t Precision: %.4f\nRecall: %.4f\t\t F1Score: %.4f\n", ...
            accuracy, precision, recall, f1score);
end

