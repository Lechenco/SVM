clear all

nLevels = 4;
nExpandLevels = 2;
expandLeaves = [];
folder = "../_data/_test/";
files = dir(folder);

wFamily = 'db3';
wRows = 2^(nLevels) + length(expandLeaves)*2^nExpandLevels;
cRows = 2^(nLevels);

files = files(2:end);
negi = randperm(30000);
posi = 40000:70000;
posi = posi(randperm(length(posi)));
files = [files(posi(1:30000)); files(negi(1:30000))];

wData = zeros(length(files), wRows);
svmData = zeros(length(files), wRows + cRows + 1); % Changed

sigmas = [0.001 0.005 0.01 0.05 0.1 0.5 1];


parfor f = 1:length(files)
    if files(f).isdir
        continue
    end
    signal = load(folder + files(f).name);
%         disp("Opening file " + files(f).name + "...")
        signalWindow = signal.signalWindow ./ max(signal.signalWindow);

     E = getWaveletEnergy(signalWindow, nLevels, wFamily, ...
                    nExpandLevels, expandLeaves);
     wData(f, :) = E;
end


for sigma = sigmas
    fprintf("Sigma: %f\n", sigma);
    parfor f = 1:length(files)
        if files(f).isdir
            continue
        end

        signal = load(folder + files(f).name);
%         disp("Opening file " + files(f).name + "...")
        signalWindow = signal.signalWindow ./ max(signal.signalWindow);

        corr = getCorrentropy(signalWindow, nLevels, wFamily, sigma);

        % classify: 1 Normal, -1 Anormal
         haveAnomalie = 1 - 2 * ~isHealty(signal.annType);

         svmData(f, :) = [wData(f, :) corr haveAnomalie];
    end

    % Train SVM
    X = svmData(:,1:32);
    Y = svmData(:, 33);
    
    z = find(Y==0);
    Y(z) = [];
    X(z, :) = [];

    trainId = separateTrainAndTest(Y);
    [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, trainId);
    SVMModel = fitSVM(Xtrain, Ytrain, 'rbf');
    [label, score] = predict(SVMModel, Xtest);

    [accuracy, precision, recall, f1score] = getMetrics(Ytest, label);
    unique(Ytest)

    printConfusion(Ytest, label);
    confusionmat(label, Ytest)
    fprintf("Accuracy: %.4f\t Precision: %.4f\nRecall: %.4f\t F1Score: %.4f\n", ...
        accuracy, precision, recall, f1score);

end