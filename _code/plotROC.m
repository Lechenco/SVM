function [] = plotROC(trueLabel,score)
%PLOTROC Summary of this function goes here
%   Detailed explanation goes here
    [x, y] = perfcurve(trueLabel, score(:,1), -1);
    figure()
    plot(x, y, 'r')
    xlabel('False positive rate') 
    ylabel('True positive rate')
    title('ROC for Classification by Logistic Regression')
end

