function [b] = isHealty(annType)
%ISHEALTY Summary of this function goes here
%   Detailed explanation goes here
    b = annType == 'N' | ...
        annType == '~' | ...
        annType == '|';

end

