function [svmData] = selectClassData(svmData, annArray, regexPos, regexNeg)
%SELECTCLASSDATA Summary of this function goes here
%   Detailed explanation goes here

    class = separateClasses(annArray, regexPos, regexNeg);
    svmData(class == 1, end) = 1;
    svmData(class == -1, end) = -1;
    svmData(class == 0,:) = [];
end

