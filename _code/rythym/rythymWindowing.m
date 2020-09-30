clear all; close all;

global folder signalsPath destination;

folder = "_data/";
signalsPath = "_data/Arritmia/";
destination = "_data/_windowSignals/";
load("_data/analisys.mat");

normalRythm = {'(N' };
anormalRythm = {'(AFIB'; '(SBR'; '(B'; '(SVTA'; '(T'; '(VFL'};
count = 0;
% Type A
for i = 1:size(annotationData)
    % Find Arrythimic windows
    a = annotationData(i);
    a.commentsIdx = find(cellfun(@isempty, a.comments));
    a.comments(a.commentsIdx) = {''};
    
    windowSize = 1440;
    a.commentsIdx = find(~cellfun(@isempty, a.comments));
    %Cut each 8 seconds
    n = findWindows(anormalRythm, a, windowSize, "A", count);
    count = count + n;
end
disp("Number of windows with Arrithym finded: " + int2str(count))

windowsRemaining = count;
count = 0;

% Type B
for i = 1:size(annotationData)

    % Find Arrythimic windows
    a = annotationData(i);
    a.commentsIdx = find(cellfun(@isempty, a.comments));
    a.comments(a.commentsIdx) = {''};

    s = load(signalsPath + a.fileName);
    
    windowSize = 1440;
    a.commentsIdx = find(~cellfun(@isempty, a.comments));
    %Cut each 8 seconds
    n = findWindows(normalRythm, a, windowSize, "B", count);
    count = count + n;

end

disp("Number of windows Normal Rithym finded: " + int2str(count))
