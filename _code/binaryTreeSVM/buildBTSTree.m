function [t] = buildBTSTree(models, Xtrain, Ytrain, ...
    kernel, verbose)
%BUILDBTSTREE Summary of this function goes here
%   Detailed explanation goes here

    remainingClasses = unique(Ytrain);
    numberClasses = length(remainingClasses);
    
     if (numberClasses <= 1)
         t = tree('end');
        return;
     end
    
     aux = randperm(numberClasses);
     choosenClasses = sort(remainingClasses(aux(1:2)));
    
     nModels = length(models) - length(find(cellfun(@isempty, models)));

     disp("Choosen Classes: ")
     disp(choosenClasses)
     
     alreadyTrained = 0;
     for i = 1:nModels
        if isequal(models{i}.ClassNames, choosenClasses)
            model = models{i};
            alreadyTrained = 1;
        end
     end

     if ~alreadyTrained
        [model, y0Idx, y1Idx] = trainModel(Xtrain, Ytrain, choosenClasses, kernel, verbose);
    
        nextModel = nModels +1;
        models{nextModel} = model;
     end
     
     % Build subtree
     
    [t, node] = tree(model);

    leftChild = buildBTSTree(models, Xtrain(y0Idx, :), ...
        Ytrain(y0Idx), kernel, verbose);
    t = t.graft(node, leftChild);

    rightChild = buildBTSTree(models, Xtrain(y1Idx, :), ...
        Ytrain(y1Idx), kernel, verbose);
    t = t.graft(node, rightChild);
end

