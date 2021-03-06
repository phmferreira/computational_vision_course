%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo esquelitiza??o (algoritmo de hilditch)
% Descri??o no site:
% http://jeff.cs.mcgill.ca/~godfried/teaching/projects97/azar/skeleton.html#algorithm

function ImagemEsqueleto = alg_hilditch(ImagemBinaria)

% ---------Se??o de testes---------
% Toy problem
%ImagemBinaria = ([0 0 0 0 0 0 0; 0 1 1 1 1 1 0; 0 1 1 1 1 1 0; 0 0 1 1 1 0 0; ...
%    0 0 1 1 1 0 0; 0 0 1 1 1 0 0; 0 0 0 0 0 0 0]);
% Outro exemplo
%ImagemBinaria = AgregandoSecaoRachadura([]);
% ---------------------------------

% Inicio do algoritmo
parar = 0;
ImagemEsqueleto = ImagemBinaria;
Imagem_copia = ImagemBinaria;
while(parar ~= 1)
    parar = 1;
    for i = 1:size(ImagemEsqueleto,1)
        for j = 1:size(ImagemEsqueleto, 2)
            
            % O algoritmo decide mudar um pixel de valor 1 para 0
            % se obdecer as quatro condi??es
            if (ImagemBinaria(i,j) == 1)
                if(testarCondicoes(i,j,ImagemBinaria) == 1)
                    ImagemEsqueleto(i,j) = 0;
                    parar = 0;
                end
            end
        end % end_for colunas
    end % end_for linhas
    
    ImagemBinaria = ImagemEsqueleto;
end % end_while condi??o de termino (n?o houve modifica??o)


% Afinamento do matlab para comparar
%BW3 = bwmorph(Imagem_copia,'thin',Inf);
%imshow(BW3);

%%--------- FIM -------------%%

% #############################################################%
% ##### Se??o Fun??es Auxiliares ####
% #############################################################%

% Considere a seguinte regra de vizinhan?a para pixel p1
%
% p9 | p2 | p3
% p8 | p1 | p4
% p7 | p6 | p5

% B <- n?mero de n?o zeros na vizinhan?a de p1
function n = B(p1, ImagemBinaria)

i = p1(1);
j = p1(2);

%n = 0;

% for a = -1:1
%     for b = -1:1
%         if(~(a == 0 && b == 0)) % condi??o para n?o contar o p1
%             if(valor(p1,[a b],ImagemBinaria) ~= 0)
%                 n = n + 1;
%             end % end_if
%         end % end_if n?o contar o p1
%     end % end_for colunas da vizinhan?a
% end % end_for linhas da vizinhan?a

% for a = -1:1
%     if (i + a > 0 &&  i + a <= size(ImagemBinaria,1))
%         for b = -1:1
%             if (j + b > 0 &&  j + b <= size(ImagemBinaria,2))
%                 if( ~(a == 0 && b == 0)) % condi??o para n?o contar o p1
%                     if( ImagemBinaria(i+a,j+b) ~= 0)
%                         n = n + 1;
%                     end % end_if
%                 end % end_if n?o contar o p1
%             end % end_if condi??o de coluna (dentro da imagem)
%         end % end_for colunas da vizinhan?a
%     end % end_if condi??o de linha (dentro da imagem)
% end % end_for linhas da vizinhan?a

n = NumeroVizinhos(i,j,ImagemBinaria);

% A <- n?mero de (0,1) na sequ?ncia p2,p3,p4,p5,p6,p7,p8,p9,p2
function n = A(p1, ImagemBinaria)

estado_a = 1;
estado_b = 0;

n = 0;

% ordem hor?ria de vizinhos
% sequ?ncia p2,p3,p4,p5,p6,p7,p8,p9,p2
ordem_vizinhos = [[-1; 0] [-1; 1] [0; 1] [1; 1] [1; 0] [1; -1] [0; -1] [-1; -1] [-1; 0]];

for pa = ordem_vizinhos
        
    % Transi??es de estados
    if( estado_a == 1 && valor(p1,pa,ImagemBinaria) == 0)
        estado_a = 0;
        estado_b = 1;
    elseif( estado_b == 1 && valor(p1,pa,ImagemBinaria) == 1)
        estado_a = 1;
        estado_b = 0;
        n = n + 1;
    end
end % end_for

% As quatro condi??es
% 2 < = B(p1) < = 6
% A(p1)=1
% p2.p4.p8=0 or A(p2)!= 1
% p2.p4.p6=0 or A(p4)!= 1 

function retorno = testarCondicoes(i,j,Imagem)

p1 = [i j];
b = B(p1,Imagem);
% condi??o: 2 < = B(p1) < = 6
condicao_1 = (2 <= b && b <= 6);
% condi??o: A(p1)=1
condicao_2 = (A(p1,Imagem) == 1);
% sequ?ncia p2,p4,p6, 
pv = [[-1 0]; [0 1]; [1 0]; [0 -1]];

% condi??o: p2.p4.p8=0 or A(p2)!= 1
condicao_3 = condicao_3_4 (p1, pv(1,:), pv(2,:), pv(4,:), pv(1,:), Imagem);
% condi??o: p2.p4.p6=0 or A(p4)!= 1
condicao_4 = condicao_3_4 (p1, pv(1,:), pv(2,:), pv(3,:), pv(2,:), Imagem);

retorno = (condicao_1 & condicao_2 & condicao_3 & condicao_4);

% pa.pb.pc=0 or A(pd)!= 1 
function retorno = condicao_3_4 (p1, pa, pb, pc, pd, imagem)

condicao1 = (valor(p1,pa,imagem) & valor(p1,pb,imagem) & valor(p1,pc,imagem)) == 0;

condicao2 = A((p1 + pd), imagem) ~= 1;

retorno = condicao1 | condicao2;

% ? considerado os valores al?m da borda igual a zero
function retorno = valor(p1,pa,imagem)

i = p1(1) + pa(1);
j = p1(2) + pa(2);

if ((i > 0 && i <= size(imagem,1)) ...
        && (j > 0 && j <= size(imagem,2)))
    retorno = imagem(i,j);
else
    retorno = 0;
end % end_if

