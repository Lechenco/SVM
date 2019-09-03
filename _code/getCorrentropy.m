function [corr] = getCorrentropy(signal, nLevels, wFamily, sigma)
%GETCORRENTROPY calcules the correntropy between 
% each Wavelet Leaves and the original signal
% 
% DEPENDECIES: ITL toolbox for Correntropy function
% 
% [corr] = getCorrentropy(signalWindow, nLevels, wFamily)
% 
% PARAMETERS:
%     signal - array with a ECG signal.
%
%     nLevels - integer with number of Wavelet Levels.
%
%     wFamily - Wavelet Family (e.g.: 'db3').
%
% RETURN:
%     corr - array with 2^nLevels correntopy indices.

    if ~exist('sigma', 'var') sigma = 0.005; end
    
    wtree = wpdec(signal, nLevels, wFamily);
    corr = zeros(1, 2^nLevels);
    
    newt = getResetWtree(wtree);
    
    i = 1;
    for node = leaves(wtree)'
        cfs = read(wtree, 'data', node);
        newt = write(newt, 'data', node, cfs);
        X = wprec(newt);
        corr(i) =  corren(signal, X, sigma);
        i = i +1;
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
end

