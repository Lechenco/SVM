clear all; close all;

folder = "../_data/";
destination = "../_data/_windowSignals/";
load("../_data/analisys.mat");
count = 0;
% Type A
for i = 1:size(annotationData)
    count = saveArrithymWindows(annotationData(i), folder, destination, count);
end
disp("Number of windows with Arrithym finded: " + int2str(count))

windowsRemaining = count;
count = 0;
% Type B
for i = 1:size(annotationData)
    count = saveNormalWindowsInArrithymData(annotationData(i), folder,...
        destination, count);
end
disp("Number of windows finded: " + int2str(count))
 
 folder = "../_data/";
 load("../_data/analisys1.mat");
 count = 0;
 % Type C
 for i = 1:size(annotationData)
     count = saveNormalWindows(annotationData(i), folder, destination,...
         count,windowsRemaining);
 end
 
 disp("Number of windows finded: " + int2str(count))