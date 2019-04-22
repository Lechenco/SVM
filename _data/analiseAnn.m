clear all

folder = "_annotations/";
files = dir(folder);

names = [];

for f = 1:size(files)
   if files(f).isdir
        continue
   end
   aux = string(split(files(f).name, "."));
   names = [names aux];
end
clear f; clear aux;

annotationData = [];

for f = 1:size(names, 2)
    file = num2str(folder + names(1,f));
    format = num2str(names(2,f));
    [ann,anntype,subtype,chan,num,comments] = rdann(file,format);
    
    %arrithmyaIndex = find(anntype ~= 'N');
    
    annotation.fileName = names(1,f);
    annotation.numberAnn = size(ann, 1);
    annotation.ann = ann;
    annotation.anntype = anntype;
%     annotation.subtype = subtype(arrithmyaIndex);
%     annotation.chan = chan;
%     annotation.num = num;
%     annotation.comments = comments;
    
    annotationData = [annotationData; annotation];
end

save('analisys.mat', 'annotationData')