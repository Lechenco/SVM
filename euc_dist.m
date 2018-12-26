function dist = euc_dist(X1, X2)
  dist = sum((X1 .- X2).^2);
  
  dist = sqrt(dist);  
endfunction