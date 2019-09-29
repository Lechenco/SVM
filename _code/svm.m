clear all;
% load('test.mat');
load _data/svmData;
kernel = 'rbf';
data = svmData;
characteristics = [1:20]; % Characteristics columns
treshold = 1; pTrain = 0.8;
slice = 6000;

% Separar três classes N, L, V
regex1 = "^N{1,}$"; regex2 = "L+"; regex3 = "V+";
N = length(annArray);
    classes = zeros(N, 1);
    for i = 1:N
        if ~isempty(regexp(annArray(i), regex1, 'once'))
            classes(i) = classes(i) + 1;
        end
        if ~isempty(regexp(annArray(i), regex2, 'once'))
            classes(i) = classes(i) + 2;
        end
        if ~isempty(regexp(annArray(i), regex3, 'once'))
            classes(i) = classes(i) + 4;
        end
    end
svmData(:, end) = classes(:);
svmData = svmData(classes ~= 0 & classes ~= 6,:);
annArray = annArray(classes ~= 0 & classes ~= 6);
paths = paths(classes ~= 0 & classes ~= 6);

% SVM A
fprintf("SVM A: %s x %s\n", regex1, regex2);
svmDataA = selectClassData(svmData, annArray, regex1, regex2);
% Prepare Data
[X, Y, idx] = prepareData(svmDataA, characteristics, slice);
[SVMModelA, trainId] = createSVMModel(X, Y, kernel, pTrain, 0);
Ypredict = Y(~trainId); Xpredict = X(~trainId, :);

[label,score] = predict(SVMModelA,Xpredict);
% Testar a solução com o resto dos dados
[correct, correctId, noMansCorrect] = getPredictFit(...
         Ypredict, label, score, treshold);
    
% Printar resultados casos testados
% printPredictResults(score, correct, treshold);
printConfusionAndMetrics(label, Ypredict); 

% SVM B
fprintf("SVM B: %s x %s\n", regex1, regex3);
svmDataB = selectClassData(svmData, annArray, regex1, regex3);
% Prepare Data
[X, Y, idx] = prepareData(svmDataB, characteristics, slice);
[SVMModelB, trainId] = createSVMModel(X, Y, kernel, pTrain, 0);
Ypredict = Y(~trainId); Xpredict = X(~trainId, :);

[label,score] = predict(SVMModelB,Xpredict);
% Testar a solução com o resto dos dados
[correct, correctId, noMansCorrect] = getPredictFit(...
         Ypredict, label, score, treshold);
    
% Printar resultados casos testados
% printPredictResults(score, correct, treshold);
printConfusionAndMetrics(label, Ypredict); 

% SVM C
fprintf("SVM C: %s x %s\n", regex2, regex3);
svmDataC = selectClassData(svmData, annArray, regex2, regex3);
% Prepare Data
[X, Y, idx] = prepareData(svmDataC, characteristics, slice);
[SVMModelC, trainId] = createSVMModel(X, Y, kernel, pTrain, 0);
Ypredict = Y(~trainId); Xpredict = X(~trainId, :);

[label,score] = predict(SVMModelC,Xpredict);
% Testar a solução com o resto dos dados
[correct, correctId, noMansCorrect] = getPredictFit(...
         Ypredict, label, score, treshold);
    
% Printar resultados casos testados
% printPredictResults(score, correct, treshold);
printConfusionAndMetrics(label, Ypredict); 

% plot Receiver Operating Characteristc
% plotROC(Ypredict,score, -1)
% trackErrors(correctId, paths(~trainId));
