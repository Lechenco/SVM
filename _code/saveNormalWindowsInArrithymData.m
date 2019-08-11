function [count] = saveNormalWindowsInArrithymData(...
    annotationData, folder, destination, startCount)
%SAVENORMALWINDOWSINARRITHYMDATA Summary of this function goes here
%   Detailed explanation goes here
    if ~exist('startCount', 'var'); count = 0;
    else; count = startCount; end
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
                count = count +1;

                [signalWindow, annType, signalAnns] = createNewWindow(...
                   annotationData, sig, ann(i) - windowSize, windowSize);
                annType = 'N';
                signalWindow = resample(signalWindow(1:2880), 128, Fs);

                path = folder + annotationData.fileName;
                save(destination + "X" + int2str(count) + ".mat", ...
                         'signalWindow', 'annType','signalAnns', 'path')
                j = j -1;
            end
        end
        i = i +1;
    end
    disp("Number normalies: " + num2str(count - startCount))
end