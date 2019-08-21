function [b] = isHealty(annType)
%ISHEALTY returns if a input annotation 
% match with a Normal type of annotation
% 
% [b] = isHealty(annType)
% 
% PARAMETERS:
%     annType - character indicating the 
%     classification of a QRS wave
%
% RETURN:
%     b - boolean showing if the input is Healty 
%     or not

    b = annType == 'N' | ...
        annType == '~' | ...
        annType == '|';

end

