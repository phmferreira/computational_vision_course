%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo F*
% Descri��o na subse��o 3.1 do artigo de ref.

function [X, L] = F_asterisco(I, S)

% Dimens�es 
% row := n�mero de linhas
% col := n�mero de colunas

row = size(I, 1);
col = size(I, 2);

% S - coordenadas do ponto inicial
% Para o exemplo da figura 2

% Inicializa��o da matriz X
% X � a matriz de custo do caminho

X = Inf(row, col);
X(S(1), S(2)) = 0;

% Calculando iterativamente a matriz X
% O algoritmo F* para quando n�o houver mais modifica��es
% ou com 1.000.000 de itera��es

parar = 0;
count = 0;
while(parar == 0)
    
    parar = 1;
    count = count + 1;
    for i = 1:row 
        for j = 1:col 
            for a = -1:1
                if (i + a > 0 &&  i + a <= row)
                    for b = -1:1
                        if(j + b > 0 &&  j + b <= col)
                            if(X(i,j) - X(i + a,j + b) > I(i,j) )
                                
                                X(i,j) = X(i + a,j + b) + cast(I(i,j), 'int16');
                                parar = 0;
                            end
                        end
                    end
                end
            end
        end
    end
    
    if(count == 1000000)
        parar = 1;
    end
end

% Imprimindo a imagem da matriz X
% im = X*(1/max(max(X)));
% imagem = imshow(im);
% saveas(imagem, 'matriz_x.jpg', 'jpg');

% Calculando a matriz L
% L � matriz com n�mero de nodos do caminho
% do ponto (i,j) at� S
L = Calc_L(X, S);

%%--------- FIM -------------%%

% #############################################################%
% ##### Se��o Fun��es Auxiliares ####
% #############################################################%


% Fun��o que calcula a matriz L
function L = Calc_L(X, S)

for i = 1:size(X,1)
    for j = 1:size(X,2)
        L(i,j) = caminhar_X_nodo(i, j, X, S);
    end
end

% Fun��o que calcula o n�mero de nodos (c�lulas)
% no caminho da nodo (i,j) at� S (ponto inicial)

function l = caminhar_X_nodo(i, j, X, S)

X_clone = X;
l = 0;
parar = 0;
anterior_i = 0;
anterior_j = 0;
while(parar == 0)
    l = l + 1;
    
    if(i == S(1) && j == S(2))
        parar = 1;
    else
        [min_i, min_j] = viz_min(i, j, X_clone, S);
        
        if(anterior_i == min_i && anterior_j == min_j)
            X_clone(i,j) = Inf;
        end
        
        anterior_i = i;
        anterior_j = j;
        i = min_i;
        j = min_j;
    end
end
anterior_i = 0;
anterior_j = 0;
if(l ~= 1)
    l = l - 1;
end