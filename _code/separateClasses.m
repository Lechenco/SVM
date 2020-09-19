function [classes] = separateClasses(annArrays, regexPos, regexNeg)
%SEPARATECLASSES Summary of this function goes here
%   Detailed explanation goes here

    N = length(annArrays);
    classes = zeros(N, 1);
    
    for i = 1:N
        if length(regexp(annArrays(i), regexPos)) == 1
            classes(i) = classes(i) + 1;
        end
        if length(regexp(annArrays(i), regexNeg)) == 1
            classes(i) = classes(i) - 1;
        end
    end
end

