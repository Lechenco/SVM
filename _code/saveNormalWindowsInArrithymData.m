function [count] = saveNormalWindowsInArrithymData(...
    annotationData, folder, destination, startCount, lastCount)
%SAVENORMALWINDOWSINARRITHYMDATA extract all the ECG signal
% windows that have no anomalie from a 
% MIT Arrithym Database signal.
%
% [count] = saveNormalWindowsInArrithymData(annotationData, folder, destination)
% [count] = saveNormalWindowsInArrithymData(annotationData, folder, destination, startCount)
% [count] = saveNormalWindowsInArrithymData(annotationData, folder, destination, startCount, lastCount)
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
    
    disp("Loading file " + annotationData.fileName)
    s = load(folder + annotationData.fileName);
    sig = s.sig; Fs = s.Fs;
    ann = annotationData.ann;
    anntype = annotationData.anntype;

    i = 1;
    while i < size(anntype, 1)
        j = 0;
        while i < size(anntype, 1) & anntype(i) == 'N'
            i = i +1; j = j +1;
            if ann(i) - ann(i -j) >= 2880
                 if count >= lastCount
                    break; 
                 end 
                count = count +1;

                [signalWindow, annType, signalAnns] = createNewWindow(...
                   annotationData, sig, ann(i) - windowSize, windowSize);
                annType = 'N';
                signalWindow = resample(signalWindow(1:2880), 128, Fs);

                path = folder + annotationData.fileName;
                save(destination + "C" + int2str(count) + ".mat", ...
                         'signalWindow', 'annType','signalAnns', 'path')
                j = j -1;
            end
        end
        i = i +1;
    end
    disp("Number normalies: " + num2str(count - startCount))
end