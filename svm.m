function [w, b] = svm(X0, Y0)
  X = [];
  Y = [];
  N = size(Y0);
  dist = realmax; % Largest Float Number
  non_zeros = [];
  
  % Encontrar os pontos com menor distancia entre eles
  for i = 1 : N
    for j = 1 : N
      if Y0(i) != Y0(j) 
        aux = euc_dist(X0(i,:), X0(j,:));
        if aux < dist
          dist = aux;
          X = [X0(i,:);X0(j,:)];
          Y = [Y0(i); Y0(j)];
          non_zeros = [i; j];
        endif 
        if aux == dist && size(find(non_zeros == i))(2) == 0
          X = [X; X0(i,:);X0(j,:)];
          Y = [Y; Y0(i); Y0(j)];
          non_zeros = [non_zeros; i; j];
        endif
      endif
    end
  end
  % Preparar vetor de alphas
  %alphas = zeros(N);
  %alphas(non_zeros) = 1
  
  % Recebe os valores dos alphas obtidos por multiplicadores
  % de Lagrange
  alphas = lagrange_multiplier(X, Y)
  
  % Calculo do vetor w e do bias b
  w = sum(alphas .* Y .* X); 
  
  b =  - w * X(1,:)' + Y(1);  % Rever
  
  % Plot para dados com apenas duas dimensões
  x1 = 0:0.1:5;
  x2 = (-b - w(1) .* x1) / w(2);
  x3 = (-b - w(1) .* x1 -1) / w(2);
  x4 = (-b - w(1) .* x1 + 1) / w(2);
 
  plot(x1, x2,'r', x1,x3, 'b', x1,x4, 'b');
  hold;
  scatter(X(:,1)', X(:, 2)', [], Y, 'filled')
 
endfunction