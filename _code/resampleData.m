% Programa para normalizar taxa de amostragem do banco de dados


path = "~/Documents/SVM/_data/";
folderInput = "Arritmia/";      %"Saudavel/";
folderOutput = "ArritmiaResample/";     %"SaudavelResample/";
list = dir(path + folderInput);

freqSample = 128;

for i = 3 :size(list) % 3 para pular as linhas '.' e '..'
   load(path + folderInput + list(i).name);
   
   sig = resample(sig, freqSample, Fs);
   tm = resample(tm, freqSample, Fs);
   
   save(path + folderOutput + list(i).name, 'sig', 'freqSample', 'tm')
   
end