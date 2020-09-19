function [annotation] = getAnnotationData(path)
%GETANNOTATIONDATA extract the informations
% in a .atr file of the MIT ECG Databases.
% 
% DEPENDECIES: wfdb library
% 
% [annotation] = getAnnotationData(path)
% 
% PARAMETERS:
%     path - path to the .atr file 
%
% RETURN:
%     annotation - struct with mainly informations
%     of the extracted file.
    
    disp(["Geting Annotations from " path]);
    [ann,anntype,subtype,chan,num,comments] = rdann(path, 'atr');
    
    delimiter = '/';
    aux = string(split(path, delimiter));
    annotation.fileName = aux(end);
    annotation.numberAnn = size(ann, 1);
    annotation.ann = ann;
    annotation.anntype = anntype;
    annotation.subtype = subtype;
    annotation.chan = chan;
    annotation.num = num;
    annotation.comments = comments;
end

