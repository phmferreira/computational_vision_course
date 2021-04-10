%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo para remover cross-points
% esse procdimento vai remover atrav�s
% de uma an�lide de conex�es os pontos 
% que se conecta com 3 ou mais pontos

function [Imagem] = RemoverCrossPoints(ImagemBinaria)

% ---------Se��o de testes---------
% Toy problem
%ImagemBinaria = ([0 0 0 0 0 0 0; 0 1 1 0 1 1 0; 0 0 0 1 0 0 0; 0 0 0 1 0 0 0; ...
%    0 0 0 1 0 0 0; 0 0 0 1 0 0 0; 0 0 0 0 0 0 0]);
% Outro exemplo
%ImagemBinaria = alg_hilditch([]);
% ---------------------------------

Imagem = ImagemBinaria;

for i = 1:size(Imagem,1)
    for j = 1:size(Imagem,2)
        
        % O algoritmo vai mudar um pixel de 1 -> 0
        % se esse pixel � conectado com 3 ou mais outros pixeis 0
        
        if(Imagem(i,j) == 1)
            if(testarCondicao(i,j,Imagem) == 1)
                Imagem(i,j) = 0;
            end %end_if condi��o de vizinhan�a
        end % end_if
    end % end_for colunas
end % end_for linhas

%%--------- FIM -------------%%

% #############################################################%
% ##### Se��o Fun��es Auxiliares ####
% #############################################################%

function retorno = testarCondicao(i,j,ImagemBinaria)

retorno = 0;

n = NumeroVizinhos(i,j,ImagemBinaria);

if(n >= 3)
    retorno = 1;
end