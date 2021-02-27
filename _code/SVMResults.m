folder = "_data/_result/";
numberOfClasses = 4;

classesStr = ["(N", "(AFIB", "(SBR", "(B", "Average"];

precisionTable = {};
recallTable = {};
VarNames = {};

%defining my colors
f1=[0 0 139]/255;
f4=[50 205 50]/255;
f9=[236 0 0]/255;
f14=[85 26 139]/255;

files = dir(folder);
for f = 1:size(files)
     if files(f).isdir continue; end

    r = load(folder + files(f).name);
     
    precision = 100*(diag(r.cmat)'./sum(r.cmat));
    recall = 100*(diag(r.cmat)'./sum(r.cmat, 2)');
    
    if length(precision) > numberOfClasses
        precision = precision(2:end);
        recall = recall(2:end);
    end
    
    precision = [precision mean(precision)];
    recall = [recall mean(recall)];
    
    i = size(precisionTable, 2);
    fileAndExtension = split(files(f).name, '.');
    VarNames{i + 1} = fileAndExtension{1}; 
    precisionTable{i + 1} =  precision';
    recallTable{i + 1} = recall';
    
    figure
    if size(r.cmat, 1) > numberOfClasses
        cm = confusionchart(r.cmat, ["Not Classified", classesStr(1:numberOfClasses)]);
    else
        cm = confusionchart(r.cmat, classesStr(1:numberOfClasses));
    end
    t = split(files(f).name, '.');
    title(strrep(t(1), '_', ' '))
    
    cm.FontSize = 14;
    cm.ColumnSummary = 'column-normalized';
    cm.RowSummary = 'row-normalized';
    
end

% Precision Table
disp('Precision Table')
disp(table(precisionTable{:}, 'VariableNames',VarNames, 'RowNames', classesStr))

% recall Table
disp('Recall Table')
disp(table(recallTable{:}, 'VariableNames',VarNames, 'RowNames', classesStr))