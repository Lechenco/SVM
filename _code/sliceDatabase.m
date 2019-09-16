function [idx] = sliceDatabase(trueLabel, slice)
%GETDATABASESLICE Summary of this function goes here
%   Detailed explanation goes here
    posi = find(trueLabel == 1);
    negi = find(trueLabel == -1);
    posi = posi(randperm(length(posi)));
    posi = posi(1:length(negi));
    posi = posi(1:slice); negi = negi(1:slice);
    
    idx = [posi; negi];
end

