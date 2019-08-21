clear all

folder = "../_data/Arritmia/_annotations/";
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
    annotation = getAnnotationData(file + format);
    
    annotationData = [annotationData; annotation];
end

save('../_data/analisys.mat', 'annotationData')