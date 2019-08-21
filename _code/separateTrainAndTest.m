function [trainId] = separateTrainAndTest(Y, p)
%SEPARATETRAINANDTEST separate the Labels indices
% in train and test.
% 
% [train, test] = separateTrainAndTest(Y, p)
% 
% PARAMETERS:
%     Y - N labeled intance array.
%
%     p [OPTIONAL] - Double number for the 
%     proportion between test and train (default: 0.8).
%
% RETURN:
%     trainId - N-size logical array index, separating
%     train Data (True) and test Data (False).
% 

    if ~exist('p', 'var'); p = 0.8; end
    posi = find(Y == 1);
    negi = find(Y == -1);
    randomPosi = posi(randperm(length(posi)));
    randomNegi = negi(randperm(length(negi)));
    trainLengthPos = fix(length(randomNegi)*p);
    trainLengthNeg = fix(length(randomNegi)*p);
 
    trainId = zeros(length(Y), 1);
    trainId(randomPosi(1:trainLengthPos)) = 1; % Changed
    trainId(randomNegi(1:trainLengthNeg)) = 1;
    trainId = boolean(trainId);
 
end

