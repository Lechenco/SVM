function [correct, correctId, noMansCorrect] = getPredictFit(...
        trueLabel, predictLabel, score, treshold)
%GETPREDICTACCURACY examine the predict results from a
%SVMModel and returns the corretcs intancies amount.
% 
% [correct, correctId, noMansCorrect] = getPredictFit(trueLabel, predictLabel, score, treshold)
% 
% PARAMETERS:
%     trueLabel - N-size array with the true labels of the data 
%
%     predictLabel - N-size array with the labels predicts by 
%     the model.
%
%     score - N-size array of doubles with the predict score
%     for the first class.
% 
%     treshold [OPTIONAL] - determines the no Man's Land
%     boundaries (default: 1).
%
% RETURN:
%     correct - Integer with the number of correct
%     classifications.
% 
%     correctId - logical index array tracing the
%     corrects intancies.
% 
%     noMansCorrect - Integer with the number of
%     correct classifications inside the no Man's
%     Land
 
    if ~exist('treshold', 'var'); treshold = 1; end
    correct = 0;
    noMansCorrect = 0;
    correctId = zeros(length(trueLabel), 1);
    score = score(:, 1);
    for i = 1 : length(trueLabel)
      if (predictLabel(i) == trueLabel(i))
        correct = correct +1;
        correctId(i) = 1;
        if (score(i) < treshold & score(i) > -treshold)
            noMansCorrect = noMansCorrect +1;
        end
      end
    end
end

