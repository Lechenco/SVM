function [] = printPredictResults(score, correct, treshold)
%PRINTPREDICTRESULTS print more readable results
% 
% printPredictResults(score, correct, N, treshold)
% 
% PARAMETERS:
%     score - N-size array of doubles with the predict score
%     for the first class.
% 
%     correct - Integer with the number of correct
%     classifications.
% 
%     treshold [OPTIONAL] - determines the no Man's Land
%     boundaries (default: 1).
%   

    if ~exist('treshold', 'var') treshold = 1; end

    N = size(score, 1);
    disp(['Dados testados: ' num2str(N)]);
    disp(['Classificação correta: ' num2str(correct)]);
    disp(['Taxa de acertos: ' num2str(correct / N * 100) '%']);
    noMansLand = size(find(score(:, 1) < treshold & ...
        score(:, 1) > -treshold), 1) / N * 100;
    disp(['Pontos entre os vetores de suporte: ' num2str(noMansLand) '%']);
end

