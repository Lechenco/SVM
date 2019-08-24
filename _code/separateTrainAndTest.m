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
%     OBS: The proportion considerr the class with less instancies;
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
    
    if length(posi) > length(negi)
        trainLength = fix(length(randomNegi)*p);
    else
        trainLength = fix(length(randomPosi)*p);
    end

    trainId = zeros(length(Y), 1);
    trainId(randomPosi(1:trainLength)) = 1; 
    trainId(randomNegi(1:trainLength)) = 1;
    trainId = boolean(trainId);
 
end

