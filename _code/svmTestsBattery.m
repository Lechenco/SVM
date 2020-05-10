load('_data/svmData');
kernel = 'rbf';
runs = 30;

% Characteristics columns
characteristics = 1:20%[2:6 17:20];

trainAccuracy = []; trainPrecision = [];
trainRecall = []; trainF1score = [];
runsAccuracy = []; runsPrecision = [];
runsRecall = []; runsF1score = [];
slice = 30000;

for i = 1:runs
    data = svmData;
    fprintf("Running %d of %d times...\n", i, runs);
    
    [X, Y, ~] = prepareData(svmData, characteristics, slice);

    %Prepare for training
    trainId = separateTrainAndTest(Y, 0.8);
    [Xtrain, Xpredict, Ytrain, Ypredict] = getTrainTestData(X, Y, trainId);

    %Train
    SVMModel = fitSVM(Xtrain, Ytrain, kernel, 0);
    %Predict Train
    [label,~] = predict(SVMModel,Xtrain);
    % Metrics
    [accuracy, precision, recall, f1score] = getMetrics(Ytrain, label);
    trainAccuracy = [trainAccuracy accuracy];
    trainPrecision = [trainPrecision precision];
    trainRecall = [trainRecall recall];
    trainF1score = [trainF1score f1score];
    
    %Predict
    [label,~] = predict(SVMModel,Xpredict);
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

fprintf("Mean Accuracy: %.5f +- %.5f\n", mean(runsAccuracy), std(runsAccuracy));
fprintf("Mean Precision: %.5f +- %.5f\n", mean(runsPrecision), std(runsPrecision));
fprintf("Mean Recall: %.5f +- %.5f\n", mean(runsRecall), std(runsRecall));
fprintf("Mean F1score: %.5f +- %.5f\n", mean(runsF1score), std(runsF1score));

