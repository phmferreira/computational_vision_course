%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo

% Função que dada a matriz X de pesos calcula o caminho 
% e o custo total do nodo (i,j) até S (ponto inicial)

function [custo, path] = caminhar_X(i, j, X, S)

X_clone = X;

custo = X_clone(i,j);
parar = 0;
path = [i ; j];

while(parar == 0)
    
    X_clone(i,j) = Inf;
    
    if(i == S(1) && j == S(2))
        parar = 1;
    else
        [min_i, min_j] = viz_min(i, j, X_clone, S);
        
        if(min_i == -1)
            parar = 2;
        end
        i = min_i;
        j = min_j;
        custo = custo + X(i,j);
        path = [path [i ; j]];
    end
end
