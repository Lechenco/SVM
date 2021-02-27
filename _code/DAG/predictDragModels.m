function [predictLabel] = predictDragModels(models, Xtest)
%PREDICTDRAGMODELS Summary of this function goes here
%   Detailed explanation goes here

    predictLabel = zeros(length(Xtest), 1);
    for k = 1:length(Xtest)
        i = 1; j = size(models, 1);
        while(i ~= j)
            aux = predict(models{i, j}, Xtest(k, :));
            if aux == -1
                j = j-1;
            else
                i = i+1;
            end
        end
        predictLabel(k) = i;
    end
end

