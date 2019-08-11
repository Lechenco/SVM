function [E] = getWaveletEnergy(signalWindow, nLevels, wFamily)
% GETWAVELETENERGY function doc

   wtree = wpdec(signalWindow, nLevels, wFamily);
   E = wenergy(wtree);
   
%    wtreeLeaves = leaves(wtree);
%    firstNode = read(wtree, 'data',wtreeLeaves(1));
%    
%    firstNodeTree = wpdec(firstNode, 2, wFamily);
%    firstNodeEnergy = wenergy(firstNodeTree);
%    E = [firstNodeEnergy E];
end
