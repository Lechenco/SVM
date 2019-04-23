clear all; close all;

folder = "Arritmia/";
destination = "_windowSignals/";
load("analisys.mat");
count = 0;
windowSize = 1440;

for i = 1:size(annotationData)
    disp("Loading " + annotationData(i).fileName + "...")
    
    load(folder + annotationData(i).fileName)
    
    anomalyIndex = find(annotationData(i).anntype ~= 'N' & ...
                    annotationData(i).anntype ~= '~' & ...
                    annotationData(i).anntype ~= '|');
    disp("Number anomalies: " + int2str(size(anomalyIndex, 1)))
    
    for j = 1:size(anomalyIndex)
        if anomalyIndex(j) <= windowSize | anomalyIndex(j) >= size(sig) - windowSize
            continue;
        end
        window = (-windowSize:windowSize -1) + anomalyIndex(j);
        
        signalWindow = sig(window);
        count = count + 1;   
        annType = annotationData(i).anntype(anomalyIndex(j));
        
        % resample Data
        signalWindow = resample(signalWindow, 128, Fs);
        save(destination + int2str(count) + ".mat", 'signalWindow', 'annType')
    end
    
end
disp("Number of windows finded: " + int2str(count))