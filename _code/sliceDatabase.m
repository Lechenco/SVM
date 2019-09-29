function [idx] = sliceDatabase(trueLabel, slice)
%GETDATABASESLICE return a random indices array with two 
% balanced slices from each of the trueLabel binary classes.
% 
% [idx] = sliceDatabase(trueLabel, slice)
% 
% PARAMETERS:
%     trueLabel - array with all labels from the database.    
% 
%     slice - Integer with the lenght from the desired sections
%     of the database
%
% RETURN:
%     idx - 2*slice-lenght array with the indices selected.

    posi = find(trueLabel == 1);
    negi = find(trueLabel == -1);
    posi = posi(randperm(length(posi)));
    %posi = posi(1:length(negi));
    posi = posi(1:slice); negi = negi(1:slice);
    
    idx = [posi; negi];
end

