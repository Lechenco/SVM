data = csvread('_data/waveletData.csv');

Y = data(:, 17);
X = data(:, 1:16);

Xtrain = X(1:20000, :);
Ytrain = Y(1:20000);
Xpredict = X(20000:end, :);
Ypredict = Y(20000:end);

% Função SVM
[w, b] = smo(Xtrain, Ytrain);


% Testar a solução com o resto dos dados
correct = 0;
for i = 1 : size(Xpredict)
  if (sign(w * Xpredict(i,:)' - b) == Ypredict(i))
    correct = correct +1;
  end
end


% Printar resultados casos testados
disp(['Dados testados: ' num2str(size(Xpredict))]);
disp(['Classificação correta: ' num2str(correct)]);
disp(['Taxa de acertos: ' num2str(correct / size(Xpredict, 1) * 100) '%']);

% Testar delimitação dos vetores de suporte 
% Yi(<w,Xi> - b) >= 1
correct = 0;
err = [];
for i = 1 : size(X, 1)
  if (Y(i)*(w * X(i,:)' - b) >= 1)
    correct = correct +1;
  else
    err = [err (Y(i)*(w * X(i,:)' - b))];
  end
end

% Printar resultados
disp('');
disp('Teste de delimitação dos vetores suporte');
disp(['Dados testados: ' num2str(N(1))]);
disp(['Pontos dentro da região de separação: ' num2str(N(1) - correct)]);
disp(['Taxa de acertos: ' num2str(correct /size(X,1) * 100) '%']);
