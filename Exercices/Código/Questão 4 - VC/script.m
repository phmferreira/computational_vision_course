
% Script para executar os experimento referente a questão 4 
% para todas as imagens localizadas no arquivo docs.rar

% global Ramesh

cinza1 = imread('DIBCO2011_HW1','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal2(cinza1, 15);
saveas(imagem,'Global2_DIBCO2011_HW1.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW4','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal2(cinza1, 10);
saveas(imagem,'Global2_DIBCO2011_HW4.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW6','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal2(cinza1, 10);
saveas(imagem,'Global2_DIBCO2011_HW6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR6','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal2(cinza1, 10);
saveas(imagem,'Global2_DIBCO2011_PR6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR7','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal2(cinza1, 70);
saveas(imagem,'Global2_DIBCO2011_PR7.jpg', 'jpg')

% global Lloyd  

cinza1 = imread('DIBCO2011_HW1','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal(cinza1);
saveas(imagem,'Global_DIBCO2011_HW1.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW4','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal(cinza1);
saveas(imagem,'Global_DIBCO2011_HW4.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW6','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal(cinza1);
saveas(imagem,'Global_DIBCO2011_HW6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR6','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal(cinza1);
saveas(imagem,'Global_DIBCO2011_PR6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR7','bmp'); % Abre a imagem
imagem = LimearizacaoGlobal(cinza1);
saveas(imagem,'Global_DIBCO2011_PR7.jpg', 'jpg')

%Local Kamel
cinza1 = imread('DIBCO2011_HW1','bmp'); % Abre a imagem
imagem = LimeatizacaoLocal(cinza1);
saveas(imagem,'Local_DIBCO2011_HW1.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW4','bmp'); % Abre a imagem
imagem = LimeatizacaoLocal(cinza1);
saveas(imagem,'Local_DIBCO2011_HW4.jpg', 'jpg')

cinza1 = imread('DIBCO2011_HW6','bmp'); % Abre a imagem
imagem = LimeatizacaoLocal(cinza1);
saveas(imagem,'Local_DIBCO2011_HW6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR6','bmp'); % Abre a imagem
imagem = LimeatizacaoLocal(cinza1);
saveas(imagem,'Local_DIBCO2011_PR6.jpg', 'jpg')

cinza1 = imread('DIBCO2011_PR7','bmp'); % Abre a imagem
imagem = LimeatizacaoLocal(cinza1);
saveas(imagem,'Local_DIBCO2011_PR7.jpg', 'jpg')
