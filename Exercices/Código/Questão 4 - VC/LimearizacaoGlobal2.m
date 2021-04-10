function imagem = LimearizacaoGlobal2(cinza1, limiarInicial)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUEST�O 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo de binariza��o global

% Agrupamento de Ramesh

total = (size(cinza1,1)*size(cinza1,2));
p = 1/total;

para = 0;

histograma = imhist(cinza1);

limiar = limiarInicial;
paco = 5;
min = Inf;

while(para ~= 1)
    
    % Divis�o em background e foreground
    back = cinza1(cinza1 < limiar);
    fore = cinza1(cinza1 >= limiar);
    
    g1 = floor(limiar);
    g2 = ceil(limiar);
    
    % calculando b1
    d = 0;
    div = 0;
    for i = 1:g1
        d = d + i*histograma(i)*p;
        div = div + histograma(i)*p;
    end
    
    b_1 = d/div;
    
    % calculando b2
    d = 0;
    div = 0;
    for i = g2:256
        d = d + i*histograma(i)*p;
        div = div + histograma(i)*p;
    end
    
    if (div == 0)
        b_2 = 0;
    else
        b_2 = d/div;
    end
    
    % pr� calculo da fun��o a ser minimizada
    
    g_mins = 1:g1;
    g_maxs = g2:255;
    
    B = (b_1*ones(1,g1) - g_mins);
    A = B.*B;
    
    C = (b_2*ones(1,size(g_maxs,1)) - g_maxs);
    D = C.*C;
    
    % Fun��o a ser minimizada
    min_novo = (sum(A) + sum(D));
    
    % Algoritmo de hill-climbing para encontrar o m�nimo
    if (min_novo < min)
        limiar = limiar + paco;
        min = min_novo;
    else
        para = 1;
        limiar = limiar - paco;
    end    
end

B = binarizacao(cinza1, limiar);

imagem = imshow(B);                 % Mostra o resultado

function B = binarizacao(I, limiar)

for i = (1):(size(I,1))
    for j = (1):(size(I,2))
        if(I(i,j) >= limiar)
            B(i,j) = 0;
        else
            B(i,j) = 1;
        end
    end
end


