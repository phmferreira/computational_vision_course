%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo FoSA
% Descrição na seção 4 do artigo de ref.


function ImagemRachaduras = FoSA(Imagem)

% CUIDADO COM AS SEÇÕES DE TESTE
% ---------Seção de testes---------
% Figura do exemplo 3
ConjuntoElementos = filtragemBaseadaAPC([]);
exemplo1 = imread('imagens\ex2_NDHM','png'); % Abre a imagem
Imagem = rgb2gray(exemplo1);
r = 16;
% ---------------------------------


% 1º passo - Criação de Elementos de Rachadura

[ConjuntoElementos] = SecoesToElementos(Imagem);

% 2º passo - Filtragem baseada no APC

[novoConjunto] = filtragemBaseadaAPC(ConjuntoElementos);

% 3º passo - Aquisição de Rastro da Rachadura

[NovoConjunto] = AquisicaoRastroRachadura(novoConjunto, Imagem, r);

% 4º passo - pós-processamento (união e poda)

% Computação da imagem das rachaduras

ImagemRachaduras = zeros(size(Imagem,1), size(Imagem,2));

for elemento = NovoConjunto
    ImagemRachaduras = RastroRachadura(elemento.PtS,elemento.pPtPath, ImagemRachaduras);
end

img = imshow(ImagemRachaduras);
saveas(img, 'imagem_rachaduras_ex2_NDHM.jpg', 'jpg');

%%--------- FIM -------------%%

% #############################################################%
% ##### Seção Funções Auxiliares ####
% #############################################################%

function ImagemAlterada = RastroRachadura(PtS, pPtPath, Imagem)

ImagemAlterada = Imagem;

transf_coord = PtS - pPtPath(:,1)';

for x = pPtPath
    pontoAtual = transf_coord + x';
    ImagemAlterada(pontoAtual(1), pontoAtual(2)) = 1;
end % end_for