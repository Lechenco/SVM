clear all;
load _data/svmData;
kernel = 'rbf';
treshold = 1; verbose = 0;

classesStr = ["(N", "(AFIB", "(SBR", "(B" ];
numberClasses = length(classesStr);

svmData = normalize(svmData, 1);
[Xtrain, Xtest, Ytrain, Ytest] = loadData(svmData, labels, classesStr);

%% Train    
models = trainOAOModels(Xtrain, Ytrain, numberClasses, kernel, verbose);

% Test
predictLabel = predictOAOModels(models, Xtest);  

% performance
[cmat, order] = confusionmat(Ytest,predictLabel);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (1-against-1):\naccuracy = %.2f%%\n', acc);
fprintf('Confusion Matrix:\n'), disp(cmat)

precision = 100*(diag(cmat)'./sum(cmat))
recall = 100*(diag(cmat)'./sum(cmat, 2)')

save('_data/_result/oaoRbf.mat', 'models', 'Xtest', 'predictLabel', 'Ytest', 'cmat', 'order')
