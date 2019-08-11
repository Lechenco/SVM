function [annotation] = getAnnotationData(path)
%GETANNOTATIONDATA Summary of this function goes here
%   Detailed explanation goes here
    [ann,anntype,subtype,chan,num,comments] = rdann(path);
    
    annotation.fileName = names(1,f);
    annotation.numberAnn = size(ann, 1);
    annotation.ann = ann;
    annotation.anntype = anntype;
end

