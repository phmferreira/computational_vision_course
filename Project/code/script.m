%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Artigo usado para implementação do projeto 2 de visão computacional
%
% [1] Q. Li, Q. Zou, D. Zhang, and Q. Mao, 
% “FoSA: F* Seed-growing Approach for crack-line 
% detection from pavement images”,
% Image and Vision Computing, vol. 29, no. 12, pp. 861-872, Nov. 2011.
%

clear

% Script que roda todos os experimentos

% ################## %
%%%%% Toy problem %%%%
% Exemplo da Figura 2%
% ################## %


%I = [1 2 5 6; 7 4 1 6; 3 5 1 3; 9 7 2 1];
%S = [2 3];

%[P_e1, P_e2, PH] = FoS(I, S);


% ################################################## %
%%%%% Exemplo da figura 3 do artigo de referência %%%%
% ################################################## %

exemplo1 = imread('imagens\exemplo1','png'); % Abre a imagem
cinza_ex1 = rgb2gray(exemplo1);

S = [117 113];

[P_e1, P_e2, PH] = FoS(cinza_ex1, S);

copia_cinza = cinza_ex1;

for x = PH
    copia_cinza(x(1),x(2)) = 255;
end

subplot(1,2,1), subimage(cinza_ex1)
subplot(1,2,2), subimage(copia_cinza)

imagem = imshow(copia_cinza);
saveas(imagem, 'imagem_ex1_detectada.jpg', 'jpg');

