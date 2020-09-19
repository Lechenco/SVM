%rng(1); % For reproducibility
r = rand(20,1) - 0.5; 
t = rand(20,1) - 0.5;  
data1 = [t, r]; 

pos = data1(:,1) > - data1(:,2);
neg = data1(:,1) < - data1(:,2);

Y = zeros(20,1);
Y(pos) = 1;
Y(neg) = -1;

%Train the SVM Classifier
cl = fitcsvm(data1,Y,'KernelFunction','linear',...
    'BoxConstraint',Inf,'ClassNames',[-1,1]);
cl2 = fitcsvm(data1,Y,'KernelFunction','rbf');


% Predict scores over the grid
d = 0.02;
[x1Grid,x2Grid] = meshgrid(min(data1(:,1)):d:max(data1(:,1)),...
    min(data1(:,2)):d:max(data1(:,2)));
xGrid = [x1Grid(:),x2Grid(:)];
[~,scores] = predict(cl,xGrid);
[~,scores2] = predict(cl2,xGrid);

% Plot the data and the decision boundary
figure;
AxesH = axes('Xlim', [-0.5, 0.5], 'XTick', -0.5:0.25:0.5,...
    'Ylim', [-0.5, 0.5], 'YTick', -0.5:0.25:0.5, 'NextPlot', 'add');
h(1:2) = gscatter(data1(:,1),data1(:,2),Y,'k','s^');
hold on
contour(x1Grid,x2Grid,reshape(scores(:,1),size(x1Grid)),[0 0],'k');
legend(h,{'-1','+1', 'Supporte Vectors'});
axis equal
hold off
