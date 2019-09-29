function [classes] = separateClasses(annArrays, regexPos, regexNeg)
%SEPARATECLASSES Summary of this function goes here
%   Detailed explanation goes here

    N = length(annArrays);
    classes = zeros(N, 1);
    
    for i = 1:N
        if ~isempty(regexp(annArrays(i), regexPos, 'once'))
            classes(i) = classes(i) + 1;
        end
        if ~isempty(regexp(annArrays(i), regexNeg, 'once'))
            classes(i) = classes(i) - 1;
        end
    end
end

