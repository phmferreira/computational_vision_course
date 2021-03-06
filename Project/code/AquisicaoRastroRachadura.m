%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo aquisi??o do rastro da rachadura
% Descri??o na subse??o 4.5 do artigo de ref.

function [NovoConjunto] = AquisicaoRastroRachadura(ConjuntoElementos, Imagem, r)

% ---------Se??o de testes---------
% Figura do exemplo 3
% ConjuntoElementos = filtragemBaseadaAPC([]);
% exemplo1 = imread('imagens\exemplo1','png'); % Abre a imagem
% Imagem = rgb2gray(exemplo1);
% r = 16;
% ---------------------------------

NovoConjunto = ConjuntoElementos;
for elemento = ConjuntoElementos
    % Construido um novo elemento a partir do PtStart
    [novoElemento] = AplicarFoS(elemento.PtS, Imagem, r);
    NovoConjunto = [NovoConjunto novoElemento];
    
    % Construido um novo elemento a partir do PtEnd
    [novoElemento] = AplicarFoS(elemento.PtE, Imagem, r);
    NovoConjunto = [NovoConjunto novoElemento];
end % end_for

[novoConjunto] = filtragemBaseadaAPC(NovoConjunto);

%%--------- FIM -------------%%

% #############################################################%
% ##### Se??o Fun??es Auxiliares ####
% #############################################################%

% ? aplicado o algoritmo FoS a uma subimagem (2r+1 de largura)
% com o elemento sendo a semente (localizada no centro da imagem
function [novoElemento] = AplicarFoS(Ponto, Imagem, r)

% testar a gera??o de subimagem para um ponto de borda

% Sub-imagem
x_min = Ponto(2) - r;
y_min = Ponto(1) - r;
width = 2*r;
height = 2*r;
ret = [x_min y_min width height];

% Pegando a subimagem
% Tem que ajustar as coordenadas
subimagem = imcrop(Imagem, ret);

% tem (talvez) que ajustar quando o ponto for de borda

TransCoord = [(y_min - 1) (x_min - 1)];

if(TransCoord(1) < 0)
    TransCoord(1) = 0;
end

if(TransCoord(2) < 0)
    TransCoord(2) = 0;
end

% Transforma??o das coordenadas da imagem para a da subimagem
S = Ponto - TransCoord;

[P_e1, P_e2, PH, nApc] = FoS(subimagem, S);

% Transforma??o das coordenadas da subimagem para a da imagem
P_e1 = P_e1 + TransCoord;
P_e2 = P_e2 + TransCoord;

novoElemento = struct('PtS', P_e1, 'PtE', P_e2, 'nApc', nApc, 'pPtPath', PH);




