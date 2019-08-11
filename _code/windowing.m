clear all; close all;

folder = "../_data/Arritmia/";
destination = "../_data/_test/";
load("../_data/analisys.mat");
count = 0;
for i = 1:size(annotationData)
    count = saveArrithymWindows(annotationData(i), folder, destination, count);
end
disp("Number of windows with Arrithym finded: " + int2str(count))

windowsRemaining = count;
count = 0;
for i = 1:size(annotationData)
    count = saveNormalWindowsInArrithymData(annotationData(i), folder,...
        destination, count);
end
disp("Number of windows finded: " + int2str(count))
% 
% folder = "../_data/Normal/";
% load("../_data/analisys1.mat");
% count = 0
% for i = 1:size(annotationData)
%     count = saveNormalWindows(annotationData(i), folder, destination,...
%         count,windowsRemaining);
% end
% 
% disp("Number of windows finded: " + int2str(count))