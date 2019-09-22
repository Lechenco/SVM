clear all

nLevels = 4;
nExpandLevels = 2;
expandLeaves = [1];
folder = "_data/_windowSignals/";
destinationFile = "_data/svmData.mat";
files = dir(folder);
svmData = zeros(length(files), 2^(nLevels) +...
                length(expandLeaves)*2^nExpandLevels + 1);
annArray = strings(length(files), 1);
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
     annArray(f) = join(signal.signalAnns');
end

svmData(1:2,:)= [];
annArray(1:2) = [];
save(destinationFile, 'paths', 'svmData', 'annArray')
