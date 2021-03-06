%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo agrega??o de se??es de rachaduras
% Descri??o na subse??o 4.2 do artigo de ref.

% Esse procedimento vai identificar e transformar as se??es de rachaduras
% em elementos de rachaduras

function [VetorElementos] = SecoesToElementos(Imagem)

% LEMBRA DE SALVAR AS IMAGENS

% ---------Se??o de testes---------
% Figura do exemplo 3
%exemplo1 = imread('imagens\exemplo1','png'); % Abre a imagem
%Imagem = rgb2gray(exemplo1);
%imshow(Imagem);
% ---------------------------------

% 1? passo - Binarizando a imagem
ImagemBinarizada = AgregandoSecaoRachadura(Imagem);
% Salvando imagem binarizada
img = imshow(ImagemBinarizada);
saveas(img, 'imagem_binarizada_ex2_NDHM.jpg', 'jpg');

% 2? passo - Afinamento das regi?es de rachaduras
ImagemEsqueleto = alg_hilditch(ImagemBinarizada);
% Salvando imagem afinada
img = imshow(ImagemEsqueleto);
saveas(img, 'imagem_afinada_ex2_NDHM.jpg', 'jpg');

% 3? passo - remo??o de cross-points (pontos com jun??o de 3 ou mais
% pontos)
ImagemSemCrossPoints = RemoverCrossPoints(ImagemEsqueleto);
% Salvando imagem sem cross-points
img = imshow(ImagemSemCrossPoints);
saveas(img, 'imagem_semcp_ex2_NDHM.jpg', 'jpg');

% 4? passo - Transforma??o de se??es em elementos de rachaduras
VetorElementos = CriarElementosRachadura(ImagemSemCrossPoints, Imagem);