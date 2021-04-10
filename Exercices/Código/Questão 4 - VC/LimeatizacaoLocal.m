function imagem = LimeatizacaoLocal(cinza)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUEST�O 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo de binariza��o local

% Agrupamento de kamel


imshow(cinza);                 % Mostra o resultado

% Calculo da matriz auxiliar L para compara��o
L = MatrizL(cinza);

% Binariza��o Local
B = binarizacao(L);

imagem = imshow(B);                 % Mostra o resultado



function B = binarizacao(L)

b = 1;

% Pecorrendo toda imagem
for i = (1+b):(size(L,1)-b)
    for j = (1+b):(size(L,2)-b)
        
        % Regra para binariza��o
        if((( L(i + b,j) == 1 && L(i - b,j) == 1)||( L(i,j + b)== 1 && L(i,j -b)))== 1 ...
                &&((L(i + b,j + b) == 1 && L(i - b,j - b) == 1 )||(L(i + b,j - b)== 1 ...
                && L(i - b,j + b) == 1)))
            B(i,j) = 1;
        else
            B(i,j) = 0;
        end
    end
end


function L = MatrizL(I)

T0 = 20;
b = 5;
w = 2*b + 1;

for i = 1:size(I,1)
    for j = 1:size(I,2)
        
        % Regra para constru��o da matriz do operadores de compara��o L
        if((Media(I,i,j,b) - I(i,j)) >= T0)
            L(i,j) = 1;
        else
            L(i,j) = 0;
        end
    end
end



function m = Media(I,i,j,b)

% M�dia de cinza dada uma regi�o (local e tamanho da janela)
linha = (i-b):(i+b);
count = 0;
sum = 0;
for x = (i-b):(i+b)
    if(x > 0 && x <= size(I,1))
        for y = (j-b):(j+b)
            if(y > 0 && y <= size(I,2))
                sum = sum + cast(I(x,y),'double');
                count = count + 1;
            end
        end
    end
end


m = sum/count;