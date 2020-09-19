clear all;
nLevels = 4; wFamily = 'db3';
folder = "_data/_test/";
wRows = 2^(nLevels); cRows = 2^(nLevels);
sigmas = [0.08];

w = load('test');
results = [];
for i = 1:5
    [wData, trueLabel, idx] = prepareData(w.svmData, [1:16], 3000);
    files = w.paths(idx);

    trainId = separateTrainAndTest(trueLabel);
    X = zeros(length(files), wRows + cRows);

    for sigma = sigmas
        % Calc Correntropy
        fprintf("Sigma: %f\n", sigma);
        parfor f = 1:length(files)
            signal = load(files(f));
            signalWindow = signal.signalWindow ./ max(signal.signalWindow);
            corr = getCorrentropy(signalWindow, nLevels, wFamily, sigma);

            % classify: 1 Normal, -1 Anormal
             X(f, :) = [wData(f, :) corr];
        end

        % Train SVM
        [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, trueLabel, trainId);
        SVMModel = fitSVM(Xtrain, Ytrain, 'rbf');
        [label, score] = predict(SVMModel, Xtest);

        % Results
        [accuracy, precision, recall, f1score] = ...
            printConfusionAndMetrics(Ytest, label);
        result.acc = accuracy; result.prec = precision; result.rec = recall;
        result.f1 = f1score; result.s = sigma;
        results = [results result];

    end
end
