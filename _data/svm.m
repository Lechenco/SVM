load('waveletCorrentropyData1.mat');
%csvread('correntropyData.csv');
%data = csvread('waveletData1.csv');

data = svmData;

% File name in first column
characteristics = [1:16];

X = data(:,characteristics);
Y = data(:, 33);

[Y, index] = sort(Y);
paths = paths(index);
X = X(index, :);

posi = find(Y == 1);
negi = find(Y == -1);
randomPosi = posi(randperm(length(posi)));
randomNegi = negi(randperm(length(negi)));
trainLength = fix(length(randomPosi)*0.8);
train = [randomPosi(1:trainLength -1); randomNegi(1:trainLength -1)];
test = [randomPosi(trainLength:end); randomNegi(trainLength:end)];
 
%  train = [1:9300 13900:23250 size(Y,1)-200:size(Y,1)];
%  test = [9301:13899 23250:size(Y,1)];

Xtrain = X(train, :);
Ytrain = Y(train);
Xpredict = X(test, :);
Ypredict = Y(test);

treshold = 1;

  c = cvpartition(size(Ytrain, 1),'KFold',10);
  opts = struct('Optimizer','bayesopt','ShowPlots',true,'CVPartition',c,...
      'AcquisitionFunctionName','expected-improvement-plus');
SVMModel = fitcsvm(Xtrain, Ytrain, 'KernelFunction', 'linear', ...
'KernelScale','auto');%     'OptimizeHyperparameters', 'auto', ...
%     'HyperparameterOptimizationOptions',opts);

%CVSVMModel = crossval(SVMModel);

[label,score] = predict(SVMModel,Xpredict);

% Testar a solução com o resto dos dados
correct = 0;
noMansCorrect = 0;
wrongIdx = [];
for i = 1 : size(Xpredict)
  if (label(i) == Ypredict(i))
    correct = correct +1;
    if (score(i, 1) < treshold & score(i, 1) > -treshold)
        noMansCorrect = noMansCorrect +1;
    end
  else
      wrongIdx = [wrongIdx i];
  end
end


% Printar resultados casos testados
disp(['Dados testados: ' num2str(size(Xpredict, 1))]);
disp(['Classificação correta: ' num2str(correct)]);
disp(['Taxa de acertos: ' num2str(correct / size(Xpredict, 1) * 100) '%']);
noMansLand = size(find(score(:, 1) < treshold & ...
    score(:, 1) > -treshold), 1) / size(Xpredict, 1) * 100;
disp(['Pontos entre os vetores de suporte: ' num2str(noMansLand) '%']);

% plot Receiver Operating Characteristc
[x, y] = perfcurve(Ypredict, score(:,1), -1);
figure()
plot(x, y, 'r')
xlabel('False positive rate') 
ylabel('True positive rate')
title('ROC for Classification by Logistic Regression')

% Track errors
%  paths(test(wrongIdx))';
%  aux = ans;
%  origin = [];
%  type = [];
%  for i = 1:length(aux)
%      load(aux(i));
%      folder = split(aux(i), '/');
%      type = [type; path+annType];
%      origin = [origin; path+'/'+folder(1)];
%  end
%  
%  unique(origin)';
%  u = ans;
%  for i=1:length(u)
%      idx = strfind(origin, u(i));
%      idx = find(not(cellfun('isempty', idx)));
%      disp([u(i)+':'+num2str(length(idx))])
%  end

pt = find(Y(train) == 1);
nt = find(Y(train) == -1);
pp = find(Y(test) == 1);
np = find(Y(test) == -1);
scatter(T(posi, 1),T(posi, 2), 'b')
hold on; scatter(T(negi, 1), T(negi, 2), 'r')