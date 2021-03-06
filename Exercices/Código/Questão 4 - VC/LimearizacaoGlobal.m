function imagem = LimearizacaoGlobal(cinza1)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUEST?O 4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo de binariza??o global

% Agrupamento de Lloyd

p = 1/(size(cinza1,1)*size(cinza1,2));

para = 0;

limiar = 0.5*255;

x = cast(cinza1,'double');
V = var(reshape(x(:,:),[],1));

while(para ~= 1)
    
    back = cinza1(cinza1 < limiar);
    fore = cinza1(cinza1 >= limiar);
    
    % calculo de m_f e m_g
    p_t = p*size(fore,1);
    m_b =  mean(back);
    %m_b = p*sum(back);
    m_f =  mean(fore);
    %m_f = p*sum(fore);
    
    % as imagens na pasta dessa quest?o com o nome teste no meio
    % foram referente a uma excu??o com a modifica??o (comentada)
    % de m_f e m_g
    
    % Calculo do novo limiar
    limiar_novo = ((m_b + m_f)/2) + (V/(m_f - m_b))*log((1-p_t)/p_t);
    
    if (limiar_novo < limiar)
        limiar = limiar_novo;
    else
        para = 1;
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


