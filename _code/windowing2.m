clear all; close all;

folder = "_data/";
signalsPath = "_data/Arritmia/";
destination = "_data/_windowSignals/";
load("_data/analisys.mat");
count = 0;

normalRythm = ['(N' ];
anormalRythm = {'(AFIB'; '(SBR'; '(B'; '(SVTA'; '(T'; '(VFL'; '(ASV'};
% Type A
for i = 1:size(annotationData)
    % Find Arrythimic windows
    a = annotationData(i);
    commentsIdx = find(cellfun(@isempty, a.comments));
    comments = a.comments;
    comments(commentsIdx) = {''};

    s = load(signalsPath + a.fileName);
    Fs = s.Fs; sig = s.sig;
    
    windowSize = 1440;
    commentsIdx = find(~cellfun(@isempty, comments));
    %Cut each 8 seconds
    for j = 1:size(commentsIdx, 1)
        idx = commentsIdx(j);
        % checar se idx é anormal
        if (size(find(strcmp(anormalRythm, comments(idx))), 1) == 0)
            continue;
        end
        label = comments(idx);
        
        
        if (j < size(commentsIdx, 1))
            nextComment = a.ann(commentsIdx(j +1));
        else
            nextComment = a.ann(end);
        end
        
        sampleStart = a.ann(commentsIdx(j));
        while(sampleStart <= nextComment)
            sampleEnd = sampleStart + 2*windowSize;
            if (nextComment < sampleEnd)
                break;
            end
                
            %save
            [signalWindow, annType, signalAnns] = createNewWindow(... 
                a, sig, sampleStart + windowSize , windowSize);
           
            % resample Data
             signalWindow = resample(signalWindow, 128, Fs);
            path = folder + a.fileName;
            count = count + 1;
            save(destination + "A" + int2str(count) + ".mat"...
                   , 'signalWindow', 'annType', 'signalAnns', 'path', 'label')
            %%%%%%%%%
            
            count = count + 1;
            sampleStart = sampleEnd + 1;
        end
    end
end
disp("Number of windows with Arrithym finded: " + int2str(count))

windowsRemaining = count;
count = 0;

% Type B
for i = 1:size(annotationData)
    % Find Arrythimic windows
    a = annotationData(i);
    commentsIdx = find(cellfun(@isempty, a.comments));
    comments = a.comments;
    comments(commentsIdx) = {''};

    s = load(signalsPath + a.fileName);
    Fs = s.Fs; sig = s.sig;
    
    windowSize = 1440;
    commentsIdx = find(~cellfun(@isempty, comments));
    
    

end