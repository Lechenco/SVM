function [corr] = getCorrentropy(signalWindow, nLevels, wFamily)
%GETCORRENTROPY calcules the correntropy between 
% each Wavelet Leaves and the original signal
% 
% DEPENDECIES: ITL toolbox for Correntropy function
% 
% [corr] = getCorrentropy(signalWindow, nLevels, wFamily)
% 
% PARAMETERS:
%     signalWindow - array with a ECG signal window 
%
%     nLevels - integer with number of Wavelet Levels
%
%     wFamily - Wavelet Family (e.g.: 'db3')
%
% RETURN:
%     corr - array with 2^nLevels correntopy indices

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

