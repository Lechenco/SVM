function [E] = getWaveletEnergy(signal, nLevels, wFamily, ...
            nExpandLevels, expandLeaves)
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
%     nExpandLevels [OPTIONAL] - number of levels to expand one or more leaves.
%     
%     expandLeaves [OPTIONAL] - array with which leaves will be expanded.
%
% RETURN:
%     E - array with 2^nLevels size with the wavelet
%     energies. If use Expand, the energies will be in the 
%     follow order: original Leaves + expanded Leaves.

   wtree = wpdec(signal, nLevels, wFamily);
   E = wenergy(wtree);
   
   if exist('nExpandLevels', 'var') & exist('expandLeaves', 'var')
       for i = 1:length(expandLeaves)
            wtreeLeaves = leaves(wtree);
           leaveSignal = read(wtree, 'data',wtreeLeaves(i));

           leaveEnergy = getWaveletEnergy(leaveSignal, nExpandLevels, wFamily);
           E = [E leaveEnergy];
       end
   end
end
