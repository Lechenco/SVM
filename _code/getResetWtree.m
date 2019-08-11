function [newt] = getResetWtree(wtree)
%GETRESETWTREE Summary of this function goes here
%   Detailed explanation goes here
    newt = wtree;
    
    % Erase newt's leaves
    for node = leaves(wtree)'
        cfs = read(newt, 'data', node);
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
end

