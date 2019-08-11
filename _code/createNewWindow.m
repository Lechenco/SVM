function [signalWindow, annType, signalAnns] = ...
            createNewWindow(annotationData, sig, index, windowSize)
%CREATENEWWINDOW Summary of this function goes here
%   Detailed explanation goes here
    window = (-windowSize:windowSize -1) + index;
        
    % Get data
    [annType, signalAnns] = getWindowAnns(annotationData, index,windowSize);
    signalWindow = sig(window, 1);
end

