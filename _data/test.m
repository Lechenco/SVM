load('analisys.mat');
destinationFolder = "_test/";

folder = "Arritmia/";
files = [annotationData(:).fileName];

for f = 1:size(files, 2)
   disp("Loading file " + files(f))
   load(folder + files(f));
   ann = annotationData(f).ann;
   anntype = annotationData(f).anntype;

    i = 1;
    index = 0;
    while i < size(anntype, 1)
        count = 0;
        while i < size(anntype, 1) & (anntype(i) == 'N' | ...
                    anntype(i) == '~' | anntype(i) == '|')
            i = i +1;
            count = count +1;
            if ann(i) - ann(i -count) >= 2880
                index = index +1;
                
                window = ann(i -count):ann(i);
                signalAnns = anntype(find(...
                    ann >= window(1) & ann <= window(end)));
                signalWindow = sig(window, 1);
                signalWindow = resample(signalWindow(1:2880), 128, Fs);
                
                path = folder + files(f);
                save(destinationFolder + int2str(index) + ".mat", ...
                     'signalWindow', 'signalAnns', 'path')
                
                count = count -1;
            end
        end
        i = i +1;

    end
end
disp("Finded windows: " + int2str(index))