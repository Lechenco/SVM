clear all

nLevels = 4;
nExpandLevels = 2;
expandLeaves = [];
folder = "../_data/_test/";

wFamily = 'db3';
wRows = 2^(nLevels) + length(expandLeaves)*2^nExpandLevels;
cRows = 2^(nLevels);

sigmas = [0.08 0.06 0.03 0.02 0.008 0.006 0.003 0.0006];
results = [];

w = load('test');
for i = 1:5
    trueLabel = w.svmData(:, 37);
    wData = w.svmData(:, 1:16);
    idx = sliceDatabase(trueLabel, 3000);
    trueLabel = trueLabel(idx);
    wData = wData(idx,:);
    files = w.paths(idx);

    trainId = separateTrainAndTest(trueLabel);

    % wData = zeros(length(files), wRows);
    svmData = zeros(length(files), wRows + cRows + 1); % Changed

    for sigma = sigmas
        fprintf("Sigma: %f\n", sigma);
        parfor f = 1:length(files)
            signal = load(files(f));
    %         disp("Opening file " + files(f).name + "...")
            signalWindow = signal.signalWindow ./ max(signal.signalWindow);

            corr = getCorrentropy(signalWindow, nLevels, wFamily, sigma);

            % classify: 1 Normal, -1 Anormal
             haveAnomalie = 1 - 2 * ~isHealty(signal.annType);

             svmData(f, :) = [wData(f, :) corr trueLabel(f)];
        end

        % Train SVM
        X = svmData(:,1:32);
        Y = svmData(:, 33);

        z = find(Y==0);
        Y(z) = [];
        X(z, :) = [];

    %     trainId = separateTrainAndTest(Y);
        [Xtrain, Xtest, Ytrain, Ytest] = getTrainTestData(X, Y, trainId);
        SVMModel = fitSVM(Xtrain, Ytrain, 'rbf');
        [label, score] = predict(SVMModel, Xtest);

        [accuracy, precision, recall, f1score] = getMetrics(Ytest, label);
    %     unique(Ytest)
        result.acc = accuracy; result.prec = precision; result.rec = recall;
        result.f1 = f1score; result.s = sigma;
        results = [results result];
        printConfusion(Ytest, label);
    %     confusionmat(label, Ytest)
        fprintf("Accuracy: %.4f\t Precision: %.4f\nRecall: %.4f\t\t F1Score: %.4f\n", ...
            accuracy, precision, recall, f1score);

    end
end