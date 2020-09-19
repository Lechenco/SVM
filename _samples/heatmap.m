x = annotationData(5);
array = zeros(size(x.anntype));

size(x.anntype(x.anntype ~= 'N'))
unique(x.anntype)

array(x.anntype == 'A') = 10;
array(x.anntype == 'Q') = 5;
array(x.anntype == '+') = 1;
array(x.anntype == '|') = -1;
array(x.anntype == 'f') = -5;
array(x.anntype == 'V') = -10;

map = interp1([-10;10], [1 1 1; 0 0.45 0.74], -10:0.1:10);

imagesc(array)
colormap(map)
colorbar