% Função que calcula o vizinho com menot valor (passo guloso)
function [min_i, min_j] = viz_min(i, j, X, S)

min_i = -1;
min_j = -1;

vetor_p_s = [(normalizar(i - S(1))) (normalizar(j - S(2)))];

valor_min = Inf;

for a = variacaoBusca(vetor_p_s(1))
    if (i + a > 0 &&  i + a <= size(X,1))
        for b = variacaoBusca(vetor_p_s(2))
            if(j + b > 0 &&  j + b <= size(X,2))
                if( ~(a == 0 && b == 0))
                    if(X(i + a,j + b) < valor_min)
                        min_i = i + a;
                        min_j = j + b;
                        valor_min = X(i + a,j + b);
                    end
                end
            end
        end
    end
end

% função que retorna o sinal do número
% negativo -1
% zero é zero
% positivo 1

function abs = normalizar (valor)

if(valor < 0)
    abs = -1;
elseif(valor == 0)
    abs = 0;
else
    abs = 1;
end

% Função que retorna quais vizinho na linha ou na coluna
% deve ser vizitados
function variacao = variacaoBusca(valor)

if(valor < 0)
    variacao = [0 1];
elseif(valor == 0)
    variacao = [-1 0 1];
else
    variacao = [-1 0];
end