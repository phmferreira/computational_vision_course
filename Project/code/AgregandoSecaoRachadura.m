%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo binariza??o
% Descri??o na subse??o 4.2 do artigo de ref.
%
% ### Explica??o (do que eu entendi) #######
%
% ? usado um limiar para separar 
% e-se??o (rachaduras expostas) 
% do plano de fundo (background)
% por?m ? usado o NDHM - M?todo do histograma das diferen?as entre
% vizinhan?a
% (mas n?o est? bem claro como fazer)
% ficou mais claro no artigo:
% 
% [1] Q. Zou, Y. Cao, Q. Li, Q. Mao, and S. Wang, ?CrackTree: Automatic
% crack detection from pavement images,? Pattern Recognition Letters,
% vol. 33, no. 3, pp. 227-238, Feb. 2012.


function ImagemBinarizada = AgregandoSecaoRachadura(Imagem)

% ---------Se??o de testes---------
% Toy problem
% Imagem = [1 2 5 6; 7 4 1 6; 3 5 1 3; 9 7 2 1];

% Figura do exemplo 3
%exemplo1 = imread('imagens\exemplo1','png'); % Abre a imagem
%Imagem = rgb2gray(exemplo1);
% ---------------------------------

% H <- ? o histograma das diferen?as
%%%%% (abscissas - valor do n?vel de cinza)
%%%%% (ordenadas - valor acumulado das diferen?as)
% I_D <- Matriz correspondente a matriz da diferen?a de cada pixel
[H, I_D]  = NDHM(Imagem);

% Opera??o de Limiariza??o
% Melhores detalhes dessa etapa na se??o 4 de [17] do artigo ref. 

ImagemBinarizada = binarizacao(H, Imagem);

%%--------- FIM -------------%%

% #############################################################%
% ##### Se??o Fun??es Auxiliares ####
% #############################################################%

% neighboring difference histogram method ref. [17] no artigo de ref.
function [H, I_D]  = NDHM(Imagem)

row = size(Imagem,1);
col = size(Imagem,2);

H = zeros(1,256);
I_D = zeros(row,col);

% For para calcular a diferen?a entre os vizinhos do pixel (i,j)
for i = 1:row
    for j = 1:col
        %%%
        if(Imagem(i,j) + 1 == 150)
            teste = 0;
        end
        I_D(i,j) = psi_chapeu(i,j, Imagem);
        %%%
        H(Imagem(i,j) + 1) = H(Imagem(i,j) + 1) + I_D(i,j);
    end % end_for colunas da imagem
end % end_for linhas da imagem

% calcula a fun??o (4) do artigo de ref.
function psi_normalizado = psi_chapeu(i,j, Imagem)

psi_normalizado = 0;

% Calcular somat?rio das diferen?as 
%psi = somatorio_diferenca(i,j,Imagem);

for a = -1:1
    if (i + a > 0 &&  i + a <= size(Imagem,1))
        for b = -1:1
            if (j + b > 0 &&  j + b <= size(Imagem,2))
                if( ~(a == 0 && b == 0)) % condi??o remover pixel (i,j)
                    
                    % somat?rio das diferen?as normalizado
                    % evita ru?do sal-e-pimenta (speckle noise)
                    
                    p_0 = cast(Imagem(i, j),'double');
                    p_j = cast(Imagem(i + a, j + b),'double');
                    
                    %sigma = (p_j - p_0)/psi;
                    
                    psi_normalizado = psi_normalizado ...
                        + (p_j - p_0);
                    
                end % end_if
            end % end_if condi??o de coluna (dentro da imagem)
        end % end_for colunas da vizinhan?a
    end % end_if condi??o de linha (dentro da imagem)
end % end_for linhas da vizinhan?a

%psi_normalizado = psi_normalizado/(psi);

if(psi_normalizado == -Inf)
    parar = 1;
    psi_normalizado = 0;
elseif(psi_normalizado == Inf)
    parar = 1;
    psi_normalizado = 0;
elseif(isnan(psi_normalizado))
    parar = 2;
    psi_normalizado = 0;
end

function psi = somatorio_diferenca(i,j,Imagem)

psi = 0;

for a = -1:1
    if (i + a > 0 &&  i + a <= size(Imagem,1))
        for b = -1:1
            if (j + b > 0 &&  j + b <= size(Imagem,2))
                if( ~(a == 0 && b == 0)) % condi??o remover pixel (i,j)
                    
                    % somat?rio das diferen?as
                    psi = psi + (cast(Imagem(i + a, j + b),'double') ...
                        - cast(Imagem(i, j),'double'));
                    
                end % end_if
            end % end_if condi??o de coluna (dentro da imagem)
        end % end_for colunas da vizinhan?a
    end % end_if condi??o de linha (dentro da imagem)
end % end_for linhas da vizinhan?a

if (psi == 0)
    parar = 1;
end

function I_B = binarizacao(H, Imagem)

row = size(Imagem,1);
col = size(Imagem,2);

I_B = zeros(row, col);
% ? escolhido o t (n?vel de cinza) que 
% tem maior valor no Histograma (de diferen?as)

[M, t] = max(H);

for i = 1:row
    for j = 1:col
        if(Imagem(i,j) <= (t-1))
            I_B(i,j) = 1;
        else
            I_B(i,j) = 0;
        end %end_if condi??o de binariza??o
    end %end_for colunas
end % end_for linhas


