function [classes] = ecodeClasses(labels, classesStr)
%ECODECLASSES Summary of this function goes here
%   Detailed explanation goes here

    classes = zeros(length(labels), 1);
    numberClasses = length(classesStr);

    for i = 1:numberClasses
        classIdx = find(labels == classesStr(i));
        classes(classIdx) = i;

        fprintf("Class %s: %d samples\n", classesStr(i), length(classIdx))
    end
end

