function [haveAnomalie] = checkAnomalie(annType)
%CHECKANOMALIE Summary of this function goes here
%   Detailed explanation goes here
% classify: 1 Normal, -1 Anormal
   haveAnomalie = 1 - 2 * (annType ~= 'N');
end

