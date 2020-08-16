clear all; close all;

folder = "_data/";
destination = "_data/_windowSignals/";
load("_data/analisys1.mat");
count = 0;

normalRythm = ['(N' ];
anormalRythm = {'(AFIB'; '(SBR'; '(B'; '(SVTA'; '(T'; '(VFL'; '(ASV'};
% Type A
for i = 1:size(annotationData)
    %count = saveArrithymWindows(annotationData(i), folder, destination, count);
    
    % Find Arrythimic windows
    a = annotationData(i);
    commentsIdx = find(cellfun(@isempty, a.comments));
    comments = a.comments;
    comments(commentsIdx) = {''};

    windowSize = 1440;
    commentsIdx = find(~cellfun(@isempty, comments));
    %Cut each 8 seconds
    for j = 1:size(commentsIdx, 1)
        idx = commentsIdx(j);
        % checar se idx é anormal
        if (size(find(strcmp(normalRythm, comments(idx))), 1) == 0)
            continue;
        end
        k = j;
        % idx:idx + windowSize
        while(k < size(commentsIdx, 1))
            idxEnd = idx + windowSize;
            if (a.ann(k +1) < idxEnd)
                break;
            end
                
            %save
            %%%%%%%%%
            
            count = count + 1;
            idx = idxEnd + 1;
            k = k + 1;
        end
    end
end
disp("Number of windows with Arrithym finded: " + int2str(count))

windowsRemaining = count;
count = 0;