load fisheriris
classKeep = ~strcmp(species,'virginica');
X = meas(classKeep,3:4);
y = species(classKeep);

gscatter(X(:,1),X(:,2),y);
title('Scatter Diagram of Iris Measurements')
xlabel('Petal length')
ylabel('Petal width')
legend('Setosa','Versicolor')

rng(1);
CVSVMModel = fitcsvm(X,y,'CrossVal','on');

[ScoreCVSVMModel,ScoreParameters] = fitSVMPosterior(CVSVMModel);