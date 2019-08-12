function [train, test] = separateTrainAndTest(Y, p)
%SEPARATETRAINANDTEST Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('p', 'var'); p = 0.8; end
    posi = find(Y == 1);
    negi = find(Y == -1);
    randomPosi = posi(randperm(length(posi)));
    randomNegi = negi(randperm(length(negi)));
    trainLengthPos = fix(length(randomPosi)*p);
    trainLengthNeg = fix(length(randomNegi)*p);
    train = [randomPosi(1:trainLengthPos -1); randomNegi(1:trainLengthNeg -1)];
    test = [randomPosi(trainLengthPos:end); randomNegi(trainLengthNeg:end)];
end

