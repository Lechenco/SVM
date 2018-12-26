function alphas = lagrange_multiplier(X, Y)
  [m, n] = size(X);
  alphas = zeros(m, 1);
  
  A = zeros(m + 1);
  B = zeros(m + 1, 1);
 
  B(:) = -1;
  B(end) = 0;
  
  % Calcular coeficientes para cada derivada parcial
  for i = 1 : m
    for j = 1 : m
      A(i,j) = - Y(i) * Y(j) * X(i,:) * X(j,:)';
    end
    A(i, end) = -Y(i);
  end
  A(m + 1,1:m) = -Y';
  
  % Resolve sistema linear
  alphas = (A\B)(1: m);
 
endfunction