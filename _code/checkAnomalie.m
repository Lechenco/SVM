function [haveAnomalie] = checkAnomalie(annType)
%CHECKANOMALIE returns a integer or integer 
%array checking if the input have a anomalie
%or not.
% 
% [haveAnomalie] = checkAnomalie(annType)
% 
% PARAMETERS:
%     annType - a character or array of characters 
%     which describes the annotations of a ECG signal.
%
% RETURN:
% 1 Normal, -1 Anormal
   haveAnomalie = 1 - 2 * (annType ~= 'N');
end

