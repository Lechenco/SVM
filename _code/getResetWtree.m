function [newt] = getResetWtree(wtree)
%GETRESETWTREE makes a copy of a Wavelet Tree
% structure, but with the all coeficients equals 
% to zero.
% 
% [newt] = getResetWtree(wtree)
% 
% PARAMETERS:
%     wtree - Wavelet Tree Object.
%
% RETURN:
%     newt - Wavelet Tree Object with
%     coeficcients equals to zero.
    newt = wtree;
    
    % Erase newt's leaves
    for node = leaves(wtree)'
        cfs = read(newt, 'data', node);
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
end

