function [annType, signalAnns] = getWindowAnns(annotationData, ...
        annIndex, windowSize)
%GETSIGNALANNS extract from a signal's metadata struct the 
% annotations for a determinated slice of the signal
%   
% [annType, signalAnns] = getWindowAnns(annotationData, anomalyIndex, windowSize)
% 
% PARAMETERS:
%     annotationData - struct with the signal metadata. 
%
%     annIndex - integer with the position of the window
%     on the full signal.
%
%     windowSize - integer with the number of positions 
%     get from both sides in relation to the center.
%
% RETURN:
%     annType - character with the annotation of the center
%     R-wave of the window.
%     
%     signalAnns - chasracters array with the R-wave 
%     annotations from all the window signal.

    windowBorder = [-windowSize windowSize-1] + annIndex;
    signalAnns = annotationData.anntype(...
            (annotationData.ann >= windowBorder(1) & ...
            annotationData.ann <= windowBorder(end)));
    annType = annotationData.anntype(annotationData.ann == annIndex);
end

