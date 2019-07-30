clear all

folder = "_windowSignals/";
files = dir(folder);
nLevels = 4;
svmData = zeros(length(files), 2^nLevels+1);

tic
parfor f = 1:length(files)
   if files(f).isdir
        continue
   end
   
   file = load(folder + files(f).name)
   disp("Opening file " + files(f).name + "...")
   
   wtree = wpdec(file.signalWindow, nLevels, 'db3');
   E = wenergy(wtree);
   
   % classify: 1 Normal, -1 Anormal
   haveAnomalie = 1 - 2 * (file.annType ~= 'N');
   
   svmData(f, :) = [E haveAnomalie];
end
toc

 svmData(1:2,:)= [];
 csvwrite("waveletData.csv", svmData);