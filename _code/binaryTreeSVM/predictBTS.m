function [predictLabel] = predictBTS(models, Xtest)
%PREDICTBTS Summary of this function goes here
%   Detailed explanation goes here
predictLabel = zeros(length(Xtest), 1);

idx = @(x) -sign(x).*0.5 + 1.5;
    for k = 1:length(Xtest)
        t = tree(models);
        predicted = 0;
        while(~predicted)
            [label, score] = predict(t.get(1), Xtest(k, :));
            
            childrens = t.getchildren(1);
            
            nextNode = childrens(idx(score(1)));
            t = t.subtree(nextNode);
            if isa(t.get(1), 'char')
                aux = label;
                predicted = 1;
            end

        end
        
        predictLabel(k) = aux;
    end
end

