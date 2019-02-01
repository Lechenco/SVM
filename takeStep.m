## Author: Lechenco <lechenco@lechenco-Aspire-5>
## Created: 2018-12-24

function [ret] = takeStep (i1, i2)
  global X;
  global Y;
  global alphas;
  global b;
  global w;
  global E;
  global C;
  
  if i1 == i2
    ret = false;
    return
  endif
  eps = 0.001; % taxa de erro
  alpha1 = alphas(i1);
  y1 = Y(i1);
  E1 = E(i1); 
  y2 = Y(i2);
  alpha2 = alphas(i2);
  E2 = E(i2); 
  s = y1 * y2;
  
  % Calcular limites superior e inferior
  if y1 == y2
    L = max(0, alpha2 + alpha1 - C);
    H = min(C, alpha2 + alpha1);
  else
    L = max(0, alpha2 - alpha1);
    H = min(C, C + alpha2 - alpha1);
  endif 
  
  if L == H
    ret = false;
    return
  endif
  
  % Kernel Linear
  k11 = X(i1,:) * X(i1,:)';
  k12 = X(i1,:) * X(i2,:)';
  k22 = X(i2,:) * X(i2,:)';
  
  eta = k11 + k22 - 2 * k12;
  
  % calculo novo alpha2
  if eta > 0
    a2 = alpha2 + y2 * (E1 - E2) / eta;
    a2 = min(H, max(L, a2));
    
  % If eta is non-negative, move new a2 to bound 
  % with greater objective function value
  else
    f1 = y1 .* (E1 + b) - alpha1 .* k11 - s .* alpha2 .* k12;
    f2 = y2 .* (E2 + b) - alpha2 .* k22 - s .* alpha1 .* k12;
    L1 = alpha1 + s .* (alpha2 - L);
    H1 = alpha1 + s .* (alpha2 - H);
    Lobj = L1 * f1 + 0.5 * L1^2 * k11 + 0.5 * L^2 *k22 + s * L * L1 * k12; 
    Hobj = H1 * f1 + 0.5 * H1^2 * k11 + 0.5 * H^2 *k22 + s * H * H1 * k12;
    if Lobj < Hobj - eps 
      a2 = L;
    elseif Lobj > Hobj + eps 
      a2 = H;
    else
      a2 = alpha2;
    endif
  endif
  
  % checando a2
  if abs(a2 - alpha2) < eps * (a2 + alpha2 + eps) 
    ret = false;
    return
  endif
  
  % caclular novo alpha1
  a1 = alpha1 + s * (alpha2 - a2);
  
  % update threshold b
  b1 = E1 + y1 * (a1 - alpha1) * k11 + y2 * (a2 - alpha2) * k12 + b;
  b2 = E2 + y1 * (a1 - alpha1) * k12 + y2 * (a2 - alpha2) * k22 + b;
  
  if 0 < a1 && a1 < C
    b_new = b1;
  elseif 0 < a2 && a2 < C
    b_new = b2;
  else
    b_new = (b1 + b2) / 2;
  endif
  
  % update weigth vector w, if SVM is linear
  w = w + y1 * (a1 - alpha1) * X(i1,:) + y2 * (a2 - alpha2) * X(i2,:);
  
  % update alphas 
  alphas(i1) = a1;
  alphas(i2) = a2;
  
  % update error cache using new Lagrange multipliers
  for i = 1 : size(E)
    E(i) = w * X(i,:)' - b_new - Y(i);
  end
  b = b_new;
  ret = true;
endfunction