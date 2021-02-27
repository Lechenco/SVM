function [dataIdx] = separateClassesFromData(labels, classesStr)
%SEPARATECLASSESFROMDATA Summary of this function goes here
%   Detailed explanation goes here

dataIdx = find(ismember(labels, classesStr));
end

