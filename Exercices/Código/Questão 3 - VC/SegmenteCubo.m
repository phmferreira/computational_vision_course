function SegmenteCubo()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUEST?O 3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo de segmenta??o dos ret?ngulos

cinza = imread('cuboG','bmp'); % Abre a imagem

% Binariza??o usado Otsu
figure, imshow(cinza)
binarizada1 = im2bw(cinza, 0.2);

A = binarizada1;
figure, imshow(A)

% Filtra ru?do (particulas pequenas e muito grandes)

[Rotulos, num] = bwlabel(A);
RGB = label2rgb(Rotulos);
%figure, imshow(RGB)

for i = 1:num
    [r,c] = find(Rotulos==i);
    rc = [r c];
    
    area = size(rc,1)*size(rc,2);
    
    % Regra para decidir regi?es pequenas e grandes
    if(area < 10000 || area > 100000)
        
        for x = rc'
            A(x(1),x(2)) = 0;
        end        
    end
end

%figure, imshow(A)

% segmenta??o dos ret?ngulos

cubo_sem = cinza;
retangulos = cinza;

for i = 1:size(cinza,1)
    for j = 1:size(cinza,2)
        
        if(A(i,j) == 0)
            retangulos(i,j) = 255;
        else            
            cubo_sem(i,j) = 255;
        end
    end
end


imagem = imshow(retangulos);
saveas(imagem, 'retangulos.jpg', 'jpg');

imagem2 = imshow(cubo_sem);
saveas(imagem2, 'cubo_seg.jpg', 'jpg');
