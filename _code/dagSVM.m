clear all;
load _data/svmData;
kernel = 'rbf';
data = svmData;
characteristics = [1:10 17:20]; % Characteristics columns
treshold = 1; pTrain = 0.5;
slice = 6000; verbose = 0;

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


% Prepare Data
Y = svmData(:, end);
X = svmData(:, characteristics);
C1 = find(Y == 1); C2 = find(Y == 2); C3 = find(Y == 4);
C1 = C1(randperm(length(C1))); C2 = C2(randperm(length(C2))); 
C3 = C3(randperm(length(C3)));
C1 = C1(1:slice); C2 = C2(1:slice); C3 = C3(1:slice);

% Separate train and test
trainidx1 = C1(1:pTrain*slice); trainidx2 = C2(1:pTrain*slice);
trainidx3 = C3(1:pTrain*slice);
testidx1 = C1(pTrain*slice+1:end); testidx2 = C2(pTrain*slice+1:end);
testidx3 = C3(pTrain*slice+1:end);

% SVM A: N - LBB
Xtrain = X([trainidx1; trainidx2], :); Ytrain = Y([trainidx1; trainidx2]);
SVMModelA = fitSVM(Xtrain, Ytrain, kernel, verbose);

% SVM B: N - V
Xtrain = X([trainidx1; trainidx3], :); Ytrain = Y([trainidx1; trainidx3]);
SVMModelB = fitSVM(Xtrain, Ytrain, kernel, verbose);

% SVM C: V - LBB
Xtrain = X([trainidx3; trainidx2], :); Ytrain = Y([trainidx3; trainidx2]);
SVMModelC = fitSVM(Xtrain, Ytrain, kernel, verbose);

% Predict
Xtest = X([testidx1; testidx2; testidx3], :); 
Ytest = Y([testidx1; testidx2; testidx3]);

predictLabel = Ytest;
for i = 1:length(Ytest)
    aux = predict(SVMModelC,Xtest(i,:));
    if aux == 2
        predictLabel(i) = predict(SVMModelA,Xtest(i,:));
    else
        predictLabel(i) = predict(SVMModelB,Xtest(i,:));
    end
    
end

cmat = confusionmat(Ytest,predictLabel);
acc = 100*sum(diag(cmat))./sum(cmat(:));
fprintf('SVM (1-against-A):\naccuracy = %.2f%%\n', acc);
fprintf('Confusion Matrix:\n'), disp(cmat)
