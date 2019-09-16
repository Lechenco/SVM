function [] = printConfusion(Ypredict, trueLabels)
%PRINTCONFUSION Summary of this function goes here
%   Detailed explanation goes here
    [CM, order] = confusionmat(trueLabels, Ypredict);
    
    disp('Confusion Matrix:')
    fprintf("T\\P \t %d \t %d\n", order(1), order(2));
    fprintf("%d \t %d \t %d\n", order(1), CM(1,1), CM(1, 2));
    fprintf("%d \t %d \t %d\n\n", order(2), CM(2,1), CM(2, 2));
end

