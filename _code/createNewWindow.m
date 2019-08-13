function [signalWindow, annType, signalAnns] = ...
            createNewWindow(annotationData, sig, central, windowSize)
%CREATENEWWINDOW get the slice of the signal
%with size determinated by a windowSize and centered
%by the central.
% 
%  [signalWindow, annType, signalAnns] = createNewWindow(annotationData, sig, index, windowSize)
% 
%   PARAMETERS:
%     annotationData - struct with the metadatas of the signal.
% 
%     sig - array with the whole signal.
% 
%     central - integer represents the signal position 
%     which will be the central of the window.
% 
%     windowSize - integer with the number of positions 
%     get from both sides in relation to the center.
% 
%   RETURN:
%     signalWindow - array with the slice of sig with
%     lenght equals to 2*windowSize
% 
%     annType - character with the annotation of the center
%     R-wave of the window.
%     
%     signalAnns - chasracters array with the R-wave 
%     annotations from all the window signal.
    window = (-windowSize:windowSize -1) + central;
        
    % Get data
    [annType, signalAnns] = getWindowAnns(annotationData, central,windowSize);
    signalWindow = sig(window, 1);
end

