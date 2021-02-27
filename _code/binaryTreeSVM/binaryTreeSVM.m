clear all;
load _data/svmData;
kernel = 'rbf';
treshold = 1; verbose = 0;

classesStr = ["(N", "(AFIB", "(SBR", "(B" ];
numberClasses = length(classesStr);

svmData = normalize(svmData, 1);

[Xtrain, Xtest, Ytrain, Ytest] = loadData(svmData, labels, classesStr);

% Train    
modelsBTS = trainBTS(Xtrain, Ytrain, kernel, verbose);

% Predict
predictLabel = predictBTS(modelsBTS, Xtest);

[cmat, order] = confusionmat(Ytest,predictLabel);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (Binary Tree of SVM):\naccuracy = %.2f%%\n', acc);
fprintf('Confusion Matrix:\n'), disp(order'), disp(cmat)
disp(classesStr)

precision = 100*(diag(cmat)'./sum(cmat))
recall = 100*(diag(cmat)'./sum(cmat, 2)')

%save('_data/_result/btsRbf.mat', 'modelsBTS', 'Xtest', 'predictLabel', 'Ytest', 'cmat', 'order')