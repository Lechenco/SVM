%% Author: Lechenco <lechenco@lechenco-Aspire-5>
%% Created: 2018-12-24

function [ans] = examineExample (i2)
  % variaveis globais
  global X;
  global Y;
  global alphas;
  global b;
  global w;
  global E;
  global C;
  
  tol = 0.001;
  
  y2 = Y(i2);
  alpha2 = alphas(i2);
  E2 = E(i2);
  r2 = y2*E2;
  
  if (r2 < -tol && alpha2 < C) || (r2 > tol && alpha2 > 0)
    % Escolher x1
    if size(find(alphas)) & size(find(alphas == C)) > 1
      if size(find(alphas & alphas ~= C)) > 1
        % x1 deve ter o maior erro comparado a x2
        if E2 < 0
          i1 = find(E == max(E));
        else
          i1 = find(E == min(E));
        end
        if takeStep(i1, i2)
          ans = 1;
          return
        end     
      end
    end
    
    % loop over all nonzeros and non-C alphas, start random
    aux = find(alphas & alphas ~= C);
    for i1 = aux(randperm(size(aux, 1)))
      if i1 & takeStep(i1(1), i2)
          ans = 1;
          return
      end 
    end
    % loop over all possible i1, start random
    for i1 = randperm(size(alphas, 1))
      if takeStep(i1, i2)
        ans = 1;
        return
      end
    end
  end
  
  ans = 0;

end
