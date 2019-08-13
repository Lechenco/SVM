function [count] = saveArrithymWindows(...
        annotationData, folder, destination, startCount)
%SAVEARRITHYMWINDOWS Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('startCount', 'var'); count = 0;
    else; count = startCount; end
    
    windowSize = 1440;
    
    disp("Loading " + annotationData.fileName + "...")
    s = load(folder + annotationData.fileName);
    Fs = s.Fs;
    sig = s.sig;
    
    anomalyIndex = annotationData.ann(~isHealty(annotationData.anntype));
    anomalyIndex = anomalyIndex((anomalyIndex > windowSize & ...
        anomalyIndex < length(sig) - windowSize));
    disp("Number anomalies: " + int2str(size(anomalyIndex, 1)))
    
    for j = 1:size(anomalyIndex)
        [signalWindow, annType, signalAnns] = createNewWindow(... 
                annotationData, sig, anomalyIndex(j), windowSize);
           
        % resample Data
        signalWindow = resample(signalWindow, 128, Fs);
        path = folder + annotationData.fileName;
        count = count + 1;
        save(destination + "A" + int2str(count) + ".mat"...
               , 'signalWindow', 'annType', 'signalAnns', 'path')
    end
end

