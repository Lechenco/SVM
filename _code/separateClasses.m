function [classes] = separateClasses(annArrays, classesRegex)
%SEPARATECLASSES Summary of this function goes here
%   Detailed explanation goes here
    
    classesWeight = 2.^(0:length(classesRegex)-1);
    numberClasses = length(classesRegex);
    N = length(annArrays);
    classes = zeros(N, 1);
    for i = 1:N
        for j = 1:numberClasses
            if ~isempty(regexp(annArrays(i), classesRegex(j), 'once'))
                classes(i) = classes(i) + classesWeight(j);
            end
        end
    end

    classes = log2(classes) +1;
end

