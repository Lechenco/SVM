function [] = trackErrors(correctId, paths)
% TRACKERRORS Function

  correctId = boolean(correctId);
  aux = paths(~correctId)';
  origin = [];
  type = [];

  for i = 1:length(aux)
      f = load(aux(i));
      folder = split(aux(i), '/');
      file = char(folder(end));
%       type = [type; f.path+f.annType];
      origin = [origin; f.path+'/'+file(1)];
  end
  
  u = unique(origin)';
  for i=1:length(u)
      idx = strfind(origin, u(i));
      idx = find(not(cellfun('isempty', idx)));
      disp([u(i)+':'+num2str(length(idx))])
  end
end
