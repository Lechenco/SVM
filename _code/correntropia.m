clear all

nLevels = 4;
folder = "../_data/_test/";
files = dir(folder);
svmData = zeros(length(files), 2^(nLevels+1) +1);
paths = [];
wFamily = 'db3';

% Metadata
% for f = 1:size(files)
%     if files(f).isdir
%         continue
%     end
%     
%     path = folder + files(f).name;
%     paths = [paths path];
% end

parfor f = 1:length(files)
    if files(f).isdir
        continue
    end
    
    signal = load(folder + files(f).name);
    disp("Opening file " + files(f).name + "...")
    signalWindow = signal.signalWindow ./ max(signal.signalWindow);
    %Silveman's rule
%     s = std(signalWindow)*(4/3/length(signalWindow))^(1/5);

    E = getWaveletEnergy(signalWindow, nLevels, wFamily);
    corr = getCorrentropy(signalWindow, nLevels, wFamily);
    
    % classify: 1 Normal, -1 Anormal
     haveAnomalie = 1 - 2 * ~isHealty(signal.annType);

     svmData(f, :) = [E corr haveAnomalie];
end

svmData(1:2,:)= [];
 save("test.mat", 'paths', 'svmData')
%csvwrite("correntropyData.csv", svmData);