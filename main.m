
%[w,b] = smo(iris_data(:,1:2), iris_data(:,3))

% Importa os dados
iris_data = importdata('iris.txt');

N = size(iris_data);

% Separa os dados para treinamento
Y = iris_data(:, 5);
X = iris_data(:, 1:4); 

% Função SVM
[w, b] = smo(X, Y);


% Testar a solução com o resto dos dados
correct = 0;
for i = 131 : N
  if (sign(w * iris_data(i, 1:4)' - b) == iris_data(i,5))
    correct++;
  endif
end
%
for i = 1 : 20
  if (sign(w * iris_data(i, 1:4)' - b) == iris_data(i,5))
    correct++;
  endif
end

% Printar resultados casos testados
display('Dados testados: 40');
display(['Classificação correta: ' num2str(correct)]);
display(['Taxa de acertos: ' num2str(correct / 40 * 100) '%']);

% Testar delimitação dos vetores de suporte 
% Yi(<w,Xi> - b) >= 1
correct = 0;
err = [];
for i = 1 : N(1)
  if (iris_data(i,5)*(w * iris_data(i, 1:4)' - b) >= 1)
    correct++;
  else
    err = [err (iris_data(i,5)*(w * iris_data(i, 1:4)' - b))];
  endif
end

% Printar resultados
display('');
display('Teste de delimitação dos vetores suporte');
display(['Dados testados: ' num2str(N(1))]);
display(['Pontos dentro da região de separação: ' num2str(N(1) - correct)]);
display(['Taxa de acertos: ' num2str(correct / N(1) * 100) '%']);
