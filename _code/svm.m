load('test.mat');
%csvread('correntropyData.csv');
% data = csvread('waveletData.csv');
kernel = 'rbf';

data = svmData;

%  for i = 1:length(paths)
%      if isempty(regexp(paths(i), 'C[0-9]+'))
%          data = [data; svmData(i,:)];
%      end
%  end

% Characteristics columns
characteristics = [1:20];
X = data(:,characteristics);
Y = data(:, 21);

trainId = separateTrainAndTest(Y, 0.8);
[Xtrain, Xpredict, Ytrain, Ypredict] = getTrainTestData(X, Y, trainId);

SVMModel = fitSVM(Xtrain, Ytrain, kernel, 1);

[label,score] = predict(SVMModel,Xpredict);

% Testar a solução com o resto dos dados
treshold = 1; 
[correct, correctId, noMansCorrect] = getPredictFit(...
        Ypredict, label, score, treshold);


% Printar resultados casos testados
disp(['Dados testados: ' num2str(size(Xpredict, 1))]);
disp(['Classificação correta: ' num2str(correct)]);
disp(['Taxa de acertos: ' num2str(correct / size(Xpredict, 1) * 100) '%']);
noMansLand = size(find(score(:, 1) < treshold & ...
    score(:, 1) > -treshold), 1) / size(Xpredict, 1) * 100;
disp(['Pontos entre os vetores de suporte: ' num2str(noMansLand) '%']);

% plot Receiver Operating Characteristc
plotROC(Ypredict,score, -1)
trackErrors(correctId, paths);
