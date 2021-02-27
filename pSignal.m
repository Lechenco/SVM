% Print signal n
n = input("Signal Number: ");

figure
load(paths(n));
t = 0:1/128:5;
plot(t, signalWindow(1:length(t)))
title( paths(n) + " "+ num2str(n))
label
signalAnns