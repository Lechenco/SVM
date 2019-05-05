clear all

folder = "_windowSignals/";
files = dir(folder);
nLevels = 4;
svmData = [];

for f = 1:size(files)
   if files(f).isdir
        continue
   end
   
   load(folder + files(f).name)
   disp("Opening file " + files(f).name + "...")
   
   wtree = wpdec(signalWindow, nLevels, 'db3');
   E = wenergy(wtree);
   
   % classify: 1 Normal, -1 Anormal
   haveAnomalie = 1 - 2 * (annType ~= 'N');
   
   svmData = [svmData; E haveAnomalie];
end

csvwrite("waveletData.csv", svmData);