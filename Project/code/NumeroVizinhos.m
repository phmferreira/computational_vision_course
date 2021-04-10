%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo Auxiliar que conta o n�mero 
% de n�o zeros na vizinhan�a de um pixel

function n = NumeroVizinhos(i,j,Imagem)

n = 0;

for a = -1:1
    if (i + a > 0 &&  i + a <= size(Imagem,1))
        for b = -1:1
            if (j + b > 0 &&  j + b <= size(Imagem,2))
                if( ~(a == 0 && b == 0)) % condi��o para n�o contar o p1
                    if( Imagem(i+a,j+b) ~= 0)
                        n = n + 1;
                    end % end_if
                end % end_if n�o contar o p1
            end % end_if condi��o de coluna (dentro da imagem)
        end % end_for colunas da vizinhan�a
    end % end_if condi��o de linha (dentro da imagem)
end % end_for linhas da vizinhan�a
