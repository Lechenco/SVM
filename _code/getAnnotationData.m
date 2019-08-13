function [annotation] = getAnnotationData(path)
%GETANNOTATIONDATA extract the informations
% in a .atr file of the MIT ECG Databases.
% 
% DEPENDECIES: wfdb librarie
% 
% [annotation] = getAnnotationData(path)
% 
% PARAMETERS:
%     path - path to the .atr file 
%
% RETURN:
%     annotation - struct with mainly informations
%     of the extracted file.
    [ann,anntype,subtype,chan,num,comments] = rdann(path);
    
    annotation.fileName = names(1,f);
    annotation.numberAnn = size(ann, 1);
    annotation.ann = ann;
    annotation.anntype = anntype;
end

