clear all

nLevels = 4;
nExpandLevels = 2;
expandLeaves = [1];
folder = "../_data/_windowSignals/";
files = dir(folder);
svmData = zeros(length(files), 2^(nLevels) +...
                length(expandLeaves)*2^nExpandLevels + 1);
paths = [];
wFamily = 'db3';

% Metadata
 for f = 1:size(files)
     if files(f).isdir continue; end
     
     path = folder + files(f).name;
     paths = [paths path];
 end

parfor f = 1:length(files)
    if files(f).isdir continue; end
    
    signal = load(folder + files(f).name);
    disp("Opening file " + files(f).name + "...")
    signalWindow = signal.signalWindow ./ max(signal.signalWindow);

    E = getWaveletEnergy(signalWindow, nLevels, wFamily, ...
                nExpandLevels, expandLeaves);
     haveAnomalie = checkAnomalie(signal.annType);
     svmData(f, :) = [E haveAnomalie];
end

svmData(1:2,:)= [];
save("test1.mat", 'paths', 'svmData')
