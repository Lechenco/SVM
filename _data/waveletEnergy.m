clear all

folder = "_windowSignals/";
files = dir(folder);
nLevels = 4;
svmData = zeros(length(files), 2^nLevels+5);

tic
parfor f = 1:length(files)
   if files(f).isdir
        continue
   end
   
   file = load(folder + files(f).name)
   disp("Opening file " + files(f).name + "...")
   
   wtree = wpdec(file.signalWindow, nLevels, 'db3');
   E = wenergy(wtree);
   wtreeLeaves = leaves(wtree);
   firstNode = read(wtree, 'data',wtreeLeaves(1));
   
   firstNodeTree = wpdec(firstNode, 2, 'db3');
   firstNodeEnergy = wenergy(firstNodeTree);
   % classify: 1 Normal, -1 Anormal
   haveAnomalie = 1 - 2 * (file.annType ~= 'N');
   
   svmData(f, :) = [firstNodeEnergy E haveAnomalie];
end
toc

 svmData(1:2,:)= [];
 csvwrite("waveletData.csv", svmData);