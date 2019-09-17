function [X, Y, idx] = prepareData(svmData, characteristics, slice)
%PREPAREDATA returns the X and Y array given a Database svmData, 
% a number of characterisitcs columns and a solce size.
%     
% [X, Y, idx] = prepareData(svmData, characteristics, slice)
% 
% PARAMETERS:
%     svmData - dataset matrix with all the characterisitics and labels
%     
%     characteristics - M-length array with the columns of characteristics
%     wanted.
%     
%     slice [OPTIONAL]- Integer with the lenght from the desired sections
%     of the database. If not passed the function will return all intances.
% 
% RETURN:
%     X - 2*slice x M matrix with all intances choosen characteristics.
%     
%     Y - 2*slice array with the labels of choosen intances.
%     
%     idx - 2*slice array with the indices reference to which intances of 
%     svmData was selected.
    
    if ~exist('slice', 'var') slice = -1; end

    Y = svmData(:, end); 
    X = svmData(:,characteristics);
    if slice ~= -1
        idx = sliceDatabase(Y, slice);
        Y = Y(idx); X = X(idx,:);
    else
        idx = 1:lenght(Y);
    end
end

