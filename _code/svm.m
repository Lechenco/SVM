clear all;
% load('test.mat');
load _data/svmData;
kernel = 'rbf';
data = svmData;
characteristics = [1:10 17:20]; % Characteristics columns
treshold = 1; pTrain = 0.8;
slice = 6000;

class = separateClasses(annArray, "R*", "L*");

svmData(class == 1, end) = 1;
svmData(class == -1, end) = -1;
svmData(class == 0,:) = [];
paths(class == 0) = [];

% Prepare Data
[X, Y, idx] = prepareData(svmData, characteristics, slice);
paths = paths(idx);

% Train and Predict
trainId = separateTrainAndTest(Y, pTrain);
[Xtrain, Xpredict, Ytrain, Ypredict] = getTrainTestData(X, Y, trainId);
SVMModel = fitSVM(Xtrain, Ytrain, kernel, 0); % 0 to supress training output
tic
[label,score] = predict(SVMModel,Xpredict);
toc
% Testar a solução com o resto dos dados
[correct, correctId, noMansCorrect] = getPredictFit(...
        Ypredict, label, score, treshold);
    
% Printar resultados casos testados
printPredictResults(score, correct, treshold);
printConfusionAndMetrics(label, Ypredict); 

% plot Receiver Operating Characteristc
% plotROC(Ypredict,score, -1)
 trackErrors(correctId, paths(~trainId));
