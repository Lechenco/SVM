function [count] = saveArrithymWindows(...
        annotationData, folder, destination, startCount, lastCount)
%SAVEARRITHYMWINDOWS extract all the ECG signal
% windows that have a Arrithym anomalie from a 
% MIT Arrithym Database signal.
%
% [count] = saveArrithymWindows(annotationData, folder, destination)
% [count] = saveArrithymWindows(annotationData, folder, destination, startCount)
% [count] = saveArrithymWindows(annotationData, folder, destination, startCount, lastCount)
% 
% PARAMETERS:
%     annotationData - struct with the original 
%     signal metadata.
%
%     folder - path to the folder with the original
%     signal.
%
%     destination - destination folder path.
%
%     startCount [OPTIONAL]- Initial count value
%     (default: 0).
% 
%     lastCount [OPTIONAL] - Final count value, 
%     if this limit is reached the function stops.
%     (default: inf)
%
% RETURN:
%     count - integer with the number of windows founded.
%     If startCount ~= 0 returns the startCount adding
%     the number of windows founded.

    if ~exist('startCount', 'var'); count = 0;
    else; count = startCount; end
    if ~exist('lastCount', 'var'); lastCount = inf; end
    
    windowSize = 1440;
    
    disp("Loading " + annotationData.fileName + "...")
    s = load(folder + annotationData.fileName);
    Fs = s.Fs; sig = s.sig;
    
    anomalyIndex = annotationData.ann(~isHealty(annotationData.anntype));
    anomalyIndex = anomalyIndex((anomalyIndex > windowSize & ...
        anomalyIndex < length(sig) - windowSize)); % muito genérico, necessita pente fino
    disp("Number anomalies: " + int2str(size(anomalyIndex, 1)))
    
    for j = 1:size(anomalyIndex)
         if count >= lastCount
            break; 
         end 
        
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