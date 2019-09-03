load('test.mat');
kernel = 'rbf';
runs = 30;

% Characteristics columns
characteristics = [1:20];

trainAccuracy = [];
trainPrecision = [];
trainRecall = [];
trainF1score = [];
runsAccuracy = [];
runsPrecision = [];
runsRecall = [];
runsF1score = [];

for i = 1:runs
    data = svmData;
    fprintf("Running %d of %d times...\n", i, runs);
    
    X = data(:,characteristics);
    Y = data(:, 37);

    posi = find(Y == 1);
    negi = find(Y == -1);
    posi = posi(randperm(length(posi)));
    posi = posi(1:length(negi));
    Y = [Y(negi); Y(posi)];
    X = [X(negi,:); X(posi, :)];

    %Prepare for training
    trainId = separateTrainAndTest(Y, 0.8);
    [Xtrain, Xpredict, Ytrain, Ypredict] = getTrainTestData(X, Y, trainId);

    %Train
    SVMModel = fitSVM(Xtrain, Ytrain, kernel, 0);
    %Predict Train
    [label,score] = predict(SVMModel,Xtrain);
    % Metrics
    [accuracy, precision, recall, f1score] = getMetrics(Ytrain, label);
    trainAccuracy = [trainAccuracy accuracy];
    trainPrecision = [trainPrecision precision];
    trainRecall = [trainRecall recall];
    trainF1score = [trainF1score f1score];
    
    %Predict
    [label,score] = predict(SVMModel,Xpredict);
    % Metrics
    [accuracy, precision, recall, f1score] = getMetrics(Ypredict, label);
    
    runsAccuracy = [runsAccuracy accuracy];
    runsPrecision = [runsPrecision precision];
    runsRecall = [runsRecall recall];
    runsF1score = [runsF1score f1score];
end

fprintf("Train Mean Accuracy: %.5f\n", mean(trainAccuracy));
fprintf("Train Mean Precision: %.5f\n", mean(trainPrecision));
fprintf("Train Mean Recall: %.5f\n", mean(trainRecall));
fprintf("Train Mean F1score: %.5f\n", mean(trainF1score));

fprintf("Mean Accuracy: %.5f\n", mean(runsAccuracy));
fprintf("Mean Precision: %.5f\n", mean(runsPrecision));
fprintf("Mean Recall: %.5f\n", mean(runsRecall));
fprintf("Mean F1score: %.5f\n", mean(runsF1score));
    
