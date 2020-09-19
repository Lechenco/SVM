function [count] = saveNormalWindows(...
        annotationData, folder, destination, startCount, lastCount)
%SAVENORMALWINDOWS extract all the ECG signal
% windows that have no anomalie from a 
% MIT Normal Sinus Database signal.
%
% [count] = saveNormalWindows(annotationData, folder, destination)
% [count] = saveNormalWindows(annotationData, folder, destination, startCount)
% [count] = saveNormalWindows(annotationData, folder, destination, startCount, lastCount)
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
    windowSize = 512;

    disp("Loading " + annotationData.fileName + "m...")
    s = load(folder + annotationData.fileName + "m");
    sig = s.val';

    anomalyIndex = annotationData.ann(isHealty(annotationData.anntype));
    anomalyIndex = anomalyIndex((anomalyIndex > windowSize & ...
        anomalyIndex < length(sig) - windowSize));
    disp("Number normalies: " + int2str(size(anomalyIndex, 1)))
    
    anomalyIndex = anomalyIndex(randperm(length(anomalyIndex), 3000));
    for j = 1:size(anomalyIndex)
        if count >= lastCount
            break; 
        end 
        
        %Get Data
        [signalWindow, annType, signalAnns] = createNewWindow(...
                annotationData, sig, anomalyIndex(j), windowSize);
        signalWindow = signalWindow * 0.005; %Analogic Data to mV
        
        path = folder + annotationData.fileName;
        if isempty(find(~isHealty(signalAnns), 1))
            count = count + 1;   
            save(destination + "B" + int2str(count) + ".mat",...
                'signalWindow', 'annType', 'signalAnns', 'path')
        end
    end
end