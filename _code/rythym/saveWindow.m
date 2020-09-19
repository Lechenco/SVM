function [] = saveWindow(filename, s, annotations, label, windowSize, center)
%SAVEWINDOW Summary of this function goes here
%   Detailed explanation goes here

    global folder destination;
    Fs = s.Fs; sig = s.sig;
    %save
    [signalWindow, annType, signalAnns] = createNewWindow(... 
        annotations, sig, center, windowSize);

    % resample Data
    signalWindow = resample(signalWindow, 128, Fs);
    path = folder + annotations.fileName;           
%     save(destination + filename...
%         , 'signalWindow', 'annType', 'signalAnns', 'path', 'label')
end

