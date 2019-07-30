clear all

nLevels = 4;
folder = "_windowSignals/";
files = dir(folder);
svmData = zeros(length(files), 2^(nLevels+1) +1);
paths = [];

% Metadata
for f = 1:size(files)
    if files(f).isdir
        continue
    end
    
    path = folder + files(f).name;
    paths = [paths path];
end

parfor f = 1:length(files)
    if files(f).isdir
        continue
    end
    
    signal = load(folder + files(f).name);
    disp("Opening file " + files(f).name + "...")
    signalWindow = signal.signalWindow ./ max(signal.signalWindow);
    %Silveman's rule
%     s = std(signalWindow)*(4/3/length(signalWindow))^(1/5);
%     sigma = [sigma s];
    sigma = 0.01;

    corr = [];
    wtree = wpdec(signalWindow, nLevels, 'db3');
    E = wenergy(wtree);
    newt = wtree;
    % Erase newt's leaves
    for node = leaves(wtree)'
        cfs = read(newt, 'data', node);
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
    
    for node = leaves(wtree)'
        cfs = read(wtree, 'data', node);
        newt = write(newt, 'data', node, cfs);
        X = wprec(newt);
        corr = [corr corren(signalWindow, X, sigma)];
        cfs(:) = 0;
        newt = write(newt, 'data', node, cfs);
    end
    %corr
    % classify: 1 Normal, -1 Anormal
     haveAnomalie = 1 - 2 * (signal.annType ~= 'N');

     svmData(f, :) = [E corr haveAnomalie];
end

svmData(1:2,:)= [];
save("waveletCorrentropyData.mat", 'paths', 'svmData')
%csvwrite("correntropyData.csv", svmData);