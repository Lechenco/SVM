function [corr] = getCorrentropy(signalWindow, nLevels, wFamily)
%GETCORRENTROPY Summary of this function goes here
%   Detailed explanation goes here
    sigma = 0.01;
    wtree = wpdec(signalWindow, nLevels, wFamily);
    corr = zeros(1, 2^nLevels);
    
    newt = getResetWtree(wtree);
    
    i = 1;
    for node = leaves(wtree)'
        cfs = read(wtree, 'data', node);
        newt = write(newt, 'data', node, cfs);
        X = wprec(newt);
        corr(i) =  corren(signalWindow, X, sigma);
        i = i +1;
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
end

