%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo F*
% Descrição na subseção 3.1 do artigo de ref.

function [X, L] = F_asterisco(I, S)

% Dimensões 
% row := número de linhas
% col := número de colunas

row = size(I, 1);
col = size(I, 2);

% S - coordenadas do ponto inicial
% Para o exemplo da figura 2

% Inicialização da matriz X
% X é a matriz de custo do caminho

X = Inf(row, col);
X(S(1), S(2)) = 0;

% Calculando iterativamente a matriz X
% O algoritmo F* para quando não houver mais modificações
% ou com 1.000.000 de iterações

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
% L é matriz com número de nodos do caminho
% do ponto (i,j) até S
L = Calc_L(X, S);

%%--------- FIM -------------%%

% #############################################################%
% ##### Seção Funções Auxiliares ####
% #############################################################%


% Função que calcula a matriz L
function L = Calc_L(X, S)

for i = 1:size(X,1)
    for j = 1:size(X,2)
        L(i,j) = caminhar_X_nodo(i, j, X, S);
    end
end

% Função que calcula o número de nodos (células)
% no caminho da nodo (i,j) até S (ponto inicial)

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