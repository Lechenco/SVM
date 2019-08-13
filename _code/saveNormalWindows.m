function [count] = saveNormalWindows(...
        annotationData, folder, destination, startCount, lastCount)
%SAVENORMALWINDOWS Summary of this function goes here
%   Detailed explanation goes here
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