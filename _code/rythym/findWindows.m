function [count] = findWindows( queries, annotations, windowSize, fileLetter, startWith)
%FINDWINDOWS Summary of this function goes here
%   Detailed explanation goes here
    global signalsPath;
    count = 0;
    s = load(signalsPath + annotations.fileName);
    commentsIdx = annotations.commentsIdx; 
    comments = annotations.comments;
    ann = annotations.ann;
    
    for j = 1:size(commentsIdx, 1)
        idx = commentsIdx(j);
        % checar se idx é anormal
        if (size(find(strcmp(queries, comments(idx))), 1) == 0)
            continue;
        end
        label = comments(idx);
        
        if (j < size(commentsIdx, 1))
            nextComment = ann(commentsIdx(j +1));
        else
            nextComment = ann(end);
        end
        
        sampleStart = ann(commentsIdx(j));
        while(sampleStart <= nextComment)
            sampleEnd = sampleStart + 2*windowSize;
            if (nextComment < sampleEnd)
                break;
            end
                
            filename = fileLetter + int2str(startWith + count) + ".mat";
            saveWindow(filename, s, annotations, ...
                label{1}, windowSize, sampleStart + windowSize);
            
            count = count + 1;
            sampleStart = sampleEnd + 1;
        end
    end
end

