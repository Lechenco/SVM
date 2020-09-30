clear all;
load _data/svmData;
kernel = 'rbf';
data = svmData;
characteristics = [1:20]; %[1:10 17:20]; % Characteristics columns
treshold = 1; pTrain = 0.7;
slice = 500; verbose = 0;

classesStr = ["(N", "(AFIB", "(SBR", "(B" ];
numberClasses = length(classesStr);

%% Preparar classes
dataIdx = find(ismember(labels, classesStr));
data = data(dataIdx, :);
labels = labels(dataIdx);
paths = paths(dataIdx);
annArray = annArray(dataIdx);

%% Encode Classes
classes = zeros(length(labels), 1);

for i = 1:numberClasses
    classIdx = find(labels == classesStr(i));
    classes(classIdx) = i;
    
    fprintf("Class %s: %d samples\n", classesStr(i), length(classIdx))
end


%%
% Preparar Dados

Y = classes;
X = data(:, characteristics);
idxTrain = [];
idxTest = [];
for j = 1:numberClasses
   aux = find(Y == j);
   nSamples = length(aux);
   nTrain = int32(nSamples*pTrain);
   
   aux = aux(randperm(nSamples)); %randomize samples
   
   if classesStr(j) == "(N"
       aux = aux(1:slice);
       nSamples = length(aux);
       nTrain = int32(nSamples*pTrain);
   end
   idxTrain = [idxTrain; aux(1:nTrain)];
   idxTest = [idxTest; aux(nTrain +1:end)]; 
end
Ytrain = Y(idxTrain);
Xtrain = X(idxTrain, :);
Ytest = Y(idxTest);
Xtest = X(idxTest, :);

%% Train    
modelsOAA = trainOAAModels(Xtrain, Ytrain, numberClasses, kernel, verbose);

%%
% Predict
predictLabel = predictOAAModels(modelsOAA, Xtest);

[cmat, order] = confusionmat(Ytest,predictLabel);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (1-against-A):\naccuracy = %.2f%%\n', acc);

fprintf('Confusion Matrix:\n'), disp(order'), disp(cmat)

disp(classesStr)

