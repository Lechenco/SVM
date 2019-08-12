function [] = trackErrors(correctId, paths)
% TRACKERRORS Function

%% DO LATER
  aux = paths(~test(correctId))';
  origin = [];
  type = [];
  for i = 1:length(aux)
      f = load(aux(i));
      folder = split(aux(i), '/');
      type = [type; path+f.annType];
      origin = [origin; path+'/'+folder(1)];
  end
  
  unique(origin)';
  u = ans;
  for i=1:length(u)
      idx = strfind(origin, u(i));
      idx = find(not(cellfun('isempty', idx)));
      disp([u(i)+':'+num2str(length(idx))])
  end
end