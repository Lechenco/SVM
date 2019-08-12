function [correct, correctId, noMansCorrect] = getPredictFit(...
        trueLabel, predictLabel, score, treshold)
%GETPREDICTACCURACY Summary of this function goes here
%   Detailed explanation goes here
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

