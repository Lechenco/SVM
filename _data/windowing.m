clear all; close all;

folder = "Arritmia/";
destination = "_windowSignals/";
load("analisys.mat");
count = 0;
windowSize = 1440;

for i = 1:size(annotationData)
    disp("Loading " + annotationData(i).fileName + "...")
    
    load(folder + annotationData(i).fileName)
    
    anomalyIndex = annotationData(i).ann(...
                find(annotationData(i).anntype ~= 'N' & ...
                    annotationData(i).anntype ~= '~' & ...
                    annotationData(i).anntype ~= '|'));
    disp("Number anomalies: " + int2str(size(anomalyIndex, 1)))
    
    for j = 1:size(anomalyIndex)
        if anomalyIndex(j) <= windowSize | ...
                anomalyIndex(j) >= size(sig) - windowSize
            continue;
        end
        window = (-windowSize:windowSize -1) + anomalyIndex(j);
        
        % Get data
        signalAnns = annotationData(i).anntype(...
            find(annotationData(i).ann >= window(1) & ...
            annotationData(i).ann <= window(end)));
        signalWindow = sig(window, 1);
        count = count + 1;   
        annType = annotationData(i).anntype(...
            find(annotationData(i).ann == anomalyIndex(j)));
        
        % resample Data
        path = folder + annotationData(i).fileName;
        signalWindow = resample(signalWindow, 128, Fs);
         save(destination + int2str(count) + ...
             ".mat", 'signalWindow', 'annType', 'signalAnns', 'path')
    end 
end
disp("Number of windows finded: " + int2str(count))

folder = "Normal/";
load("analisys1.mat");
windowsRemaining = count;
windowSize = 512;
for i = 1:size(annotationData)
    disp("Loading " + annotationData(i).fileName + "m...")
    
    load(folder + annotationData(i).fileName + "m");
    
    anomalyIndex = annotationData(i).ann(...
        find(annotationData(i).anntype == 'N'));
    
    disp("Number nomalies: " + int2str(size(anomalyIndex, 1)))
    anomalyIndex = anomalyIndex(find(anomalyIndex > windowSize & ...
        anomalyIndex < size(sig) - windowSize));
    anomalyIndex = anomalyIndex(randperm(size(anomalyIndex, 1), 3000));
    for j = 1:size(anomalyIndex)
        if ~windowsRemaining 
            break; 
        end
       
        if anomalyIndex(j) <= windowSize | ...
                anomalyIndex(j) >= size(sig) - windowSize
            continue;
        end
        window = (-windowSize:windowSize -1) + anomalyIndex(j);
        
        signalAnns = annotationData(i).anntype(...
            find(annotationData(i).ann >= window(1) & ...
            annotationData(i).ann <= window(end)));
        signalWindow = val(1, window)';
        signalWindow = signalWindow * 0.005;
        count = count + 1;   
        windowsRemaining = windowsRemaining - 1;
        annType = annotationData(i).anntype(...
            find(annotationData(i).ann == anomalyIndex(j)));
        path = folder + annotationData(i).fileName;
        
         save(destination + int2str(count) + ...
             ".mat", 'signalWindow', 'annType', 'signalAnns', 'path')
    end 
end

disp("Number of windows finded: " + int2str(count))