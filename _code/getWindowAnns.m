function [annType, signalAnns] = getWindowAnns(annotationData, ...
        anomalyIndex, windowSize)
%GETSIGNALANNS Summary of this function goes here
%   Detailed explanation goes here
    windowBorder = [-windowSize windowSize-1] + anomalyIndex;
    signalAnns = annotationData.anntype(...
            (annotationData.ann >= windowBorder(1) & ...
            annotationData.ann <= windowBorder(end)));
    annType = annotationData.anntype(annotationData.ann == anomalyIndex);
end

