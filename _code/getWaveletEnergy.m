function [E] = getWaveletEnergy(signal, nLevels, wFamily)
% GETWAVELETENERGY calcules the wavelet leaves
% energy of a signal.
% 
% [E] = getWeletEnergy(signalWindow, nLevels, wFamily)
% 
% PARAMETERS:
%     signal - array with a ECG signal. 
%
%     nLevels - integer with number of Wavelet Levels.
%
%     wFamily - Wavelet Family (e.g.: 'db3').
%
% RETURN:
%     E - array with 2^nLevels size with the wavelet
%     energies.

   wtree = wpdec(signal, nLevels, wFamily);
   E = wenergy(wtree);
   
%    wtreeLeaves = leaves(wtree);
%    firstNode = read(wtree, 'data',wtreeLeaves(1));
%    
%    firstNodeTree = wpdec(firstNode, 2, wFamily);
%    firstNodeEnergy = wenergy(firstNodeTree);
%    E = [firstNodeEnergy E];
end
