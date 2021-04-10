function selectImagem(texto)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUESTÂO 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo que segmenta texto-imagem e conta quantas imagens tem

cinza = imread(texto,'bmp'); % Abre a imagem

% Binarização usado Otsu
escala = graythresh(cinza);
binarizada1 = im2bw(cinza, escala);

A = binarizada1;

% Elementos estruturantes
B = ones(3);
C = [0 1 0; 0 1 0; 0 1 0];
D = [0 0 0; 1 1 1; 0 0 0];

% Remover letras pequenas (etapa 1)

A2 = imerode(A,B);
A = A2;

for i = 1:2
    A2 = imdilate(A,B);
    A = A2;
    figure, imshow(A)
end

% Presevar fotos
for i = 1:3
    A2 = imerode(A,D);
    A = A2;
end

for i = 1:5
    A2 = imdilate(A,B);
    A = A2;    
end

% Remover letras maiores sem revorve a imagem

for i = 1:9
    
    A2 = imerode(A,C);
    A = A2;
    
    A2 = imdilate(A,B);
    A = A2;
    
end


% Reconstruido regiões onde tem imagens
% (Pode haver regiões ruídosas, mas são eleminadas posteriormente)

for i = 1:14
    A2 = imerode(A,B);
    A = A2;
end

% Filtra ruído (particulas pequenas)

A = ~A;
[Rotulos, num] = bwlabel(A);

for i = 1:num
    [r,c] = find(Rotulos==i);
    rc = [r c];
    
    area = size(rc,1)*size(rc,2);
    
    if(area < 2000)
        
        for x = rc'
            A(x(1),x(2)) = 0;
        end        
    end
end

% Calculando o locais das imagens 
% (num_imagens = número de fotos no jornal)

[Rotulos, num_imagens] = bwlabel(A);

figuras = [];

for i = 1:num_imagens
    [r,c] = find(Rotulos==i);
    
    x1 = min(r);
    x2 = max(r);
    y1 = min(c);
    y2 = max(c);
    
    temp = [y1; (x1+5); (y2-y1); (x2-x1-10)];
    figuras = [figuras temp];
end

% segmentação do jornal em fotos e texto

letras = cinza;

for ret = figuras
    temp = imcrop(cinza, ret');
    imagem = imshow(temp);
    texto_temp = strcat(texto, num2str(ret(1)));
    texto_temp = strcat(texto_temp, 'fotos.jpg');
    saveas(imagem, texto_temp, 'jpg');
    
    for x = ret(2):(ret(2) + ret(4))
        for y = ret(1):(ret(1) + ret(3))            
            letras(x, y) = 255;            
        end
    end
end

imagem = imshow(letras);
texto_temp = strcat(texto, 'letras.jpg');
saveas(imagem, texto_temp, 'jpg');

