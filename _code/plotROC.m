function [] = plotROC(trueLabel,score, class)
%PLOTROC plot a Receiver Operating Characteristics
% curve.
% 
% [] = plotROC(trueLabel,score, class)
% 
% PARAMTERS:
%     trueLabel - N-size array with the labels
%     used for testing.
%     
%     score - N-size array with the predict score
%     acquire during the test.
% 
%     class - indicates the class label which will
%     be consider for plot the graph

    [x, y] = perfcurve(trueLabel, score(:,1), class);
    figure()
    plot(x, y, 'r')
    xlabel('False positive rate') 
    ylabel('True positive rate')
    title('ROC for Classification by Logistic Regression')
end

