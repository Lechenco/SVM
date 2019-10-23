clear all;
load _data/svmData;
kernel = 'rbf';
data = svmData;
characteristics = [1:10 17:20]; % Characteristics columns
treshold = 1; pTrain = 0.5;
slice = 6000; verbose = 0;

% Separar três classes N, L, V
classesRegex = ["^N+$" "L+" "V+"];
numberClasses = length(classesRegex);
classes = separateClasses(annArray, classesRegex);

svmData = svmData(ismember(classes, 1:numberClasses),:);
annArray = annArray(ismember(classes, 1:numberClasses));
paths = paths(ismember(classes, 1:numberClasses));
svmData(:, end) = classes(ismember(classes, 1:numberClasses));

% Prepare Data
[Xtrain, Ytrain, Xtest, Ytest] = prepareClassesData(svmData,...
                characteristics, slice, pTrain, numberClasses);
            
modelsOAA = trainOAAModels(Xtrain, Ytrain, numberClasses, kernel, verbose);

% Predict
predictLabel = predictOAAModels(modelsOAA, Xtest);

cmat = confusionmat(Ytest,predictLabel);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (1-against-A):\naccuracy = %.2f%%\n', acc);
fprintf('Confusion Matrix:\n'), disp(cmat)
