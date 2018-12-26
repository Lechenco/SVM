function [w, b] = smo(X0, Y0)
  % Declarando variaveis globais
  clear global
  global X
  global Y
  global alphas
  global b
  global w 
  global E
  global C
  
  % inicializando variaveis
  X = X0;
  Y = Y0;
  alphas = zeros(size(Y));
  b = 0;
  w = zeros(1, size(X)(2));
  E = -Y;
  C = 10000;
  
  N = size(Y);
  int = 0;
  
  numChanged = 0;
  examineAll = true;
  
  while numChanged > 0 || examineAll
    int += 1;
    numChanged = 0;
    if examineAll
      % Examinar cada exemplo
      for i = 1 : N
        numChanged += examineExample(i);
      end
    else
      for i = find(alphas & alphas != C)
        numChanged += i && examineExample(i(1));
      end
    endif
    
    % validação para continuar o loop
    if examineAll 
      examineAll = false;
    elseif numChanged == 0
      examineAll = true;
    endif
  endwhile

  int
  w
  b
 
endfunction