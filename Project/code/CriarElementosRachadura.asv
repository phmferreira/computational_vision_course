%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo para construir elementos de rachaduras (crack elements)
% Esse algoritmo transforma seções de rachaduras e elementos de rachadura
% O elemento é definodo pela estrutura abaixo.
%
% typedef struct tagCrackElement {
%   POINT PtStart, PtEnd; // Os dois pontos finais da rachadura
%   INT nApc; // Média do custo do caminho PtS -> PtE
%   POINT* pPtPath; // Caminho mínimo entre PtS -> PtE
%
% Em Matlab
% s = struct('PtS',[],'PtE',[],'nApc',[],'pPtPath',[]);
%

% Parâmetros :
% ImagemProcessada: é a imagem depois da binarização, do afinamento e 
% da remoção do cross-points (pontos com 3 ou mais junções)
% Imagem: é a imagem original

function [VetorElementos] = CriarElementosRachadura(ImagemProcessada, Imagem)

% ---------Seção de testes---------
% Toy problem
%ImagemProcessada = ([1 0 0 0 0 0 0; 0 1 0 0 1 1 0; 0 0 1 0 0 0 1; 0 0 0 1 0 0 1; ...
%    0 0 0 1 0 0 1; 0 0 0 1 0 0 1; 0 0 0 0 0 0 1]);
%
%Imagem = ([3 7 7 5 4 4 3; 7 3 5 8 1 2 0; 5 9 4 2 5 6 2; 9 9 8 7 6 5 2; ...
%    7 7 7 3 4 5 2; 8 3 3 2 7 3 4; 4 5 7 3 5 4 1]);
% Outro exemplo

% ---------------------------------

VetorElementos = [];

% Pegando os endpoints
% Separar a subimagem da seção de rachadura
% Aplicar F* para encontra melhor caminho entre PtS e PtE
%   - Tem-se o custo médio nApc
%   - Tem-se as coordenadas do caminho pPtPath

for i = 1:size(ImagemProcessada,1)
    for j = 1:size(ImagemProcessada,2)
        
        % For para construir todos os elementos de rachaduras
        % Nessa primeira etapa é calculado somente os pontos de início e
        % fim de cada seção de rachadura
        
        if(ImagemProcessada(i,j) == 1)
            
            if(IsPtEnd(i,j,ImagemProcessada) == 1)
                
                % Pegando PtStart e PtEnd
                [PtEnd, ImagemProcessada] = getPtEnd(i,j,ImagemProcessada);
                
                % Sub-imagem
                x_min = min([j,PtEnd(2)]); %coluna min
                y_min = min([i,PtEnd(1)]); %linha min
                width = max([j,PtEnd(2)]) - x_min;
                height = max([i,PtEnd(1)]) - y_min;
                ret = [x_min y_min width height];
                
                % Pegando a subimagem
                % Tem que ajustar as coordenadas
                subimagem = imcrop(Imagem, ret);
                
                TransCoord = [(y_min - 1) (x_min - 1)];
                
                [X, L] = F_asterisco(subimagem, (PtEnd - TransCoord));
                X_chapeu = X./L;
                
                [nApc, pPtPath] = caminhar_X(i - TransCoord(1), j - TransCoord(2), ...
                    X_chapeu, (PtEnd - TransCoord));
                
                % Alteração na interpretação do Apc
                nApc = X_chapeu(i - TransCoord(1),  j - TransCoord(2));
                
                s = struct('PtS', [i j], 'PtE', PtEnd, ...
                    'nApc', nApc, 'pPtPath', pPtPath);
                
                VetorElementos = [VetorElementos s];
                
            end % end_if condição de ponto de início
        end % end_if
    end % end_for colunas
end % end_for linhas



%%--------- FIM -------------%%

% #############################################################%
% ##### Seção Funções Auxiliares ####
% #############################################################%

% Será consisderado um ponto de final se ele posuir apenas um vizinho
function retorno = IsPtEnd(i,j,ImagemProcessada)

retorno = 0;
n = NumeroVizinhos(i,j,ImagemProcessada);

if(n == 1)
    retorno = 1;
end

% Para encontrar o outro ponto de final de rachadura
% é caminhado na trilha a partir de um ponto de início
% para quando chegar a um pixel com apenas um vizinho
function [pt, ImagemProcessada] = getPtEnd(i,j,ImagemProcessada)

parar = 0;

while( parar ~= 1)
    i_anterior = i;
    j_anterior = j;
    
    pt = getVizinho(i,j,ImagemProcessada);
    
    i = pt(1);
    j = pt(2);
    
    if(IsPtEnd(i,j,ImagemProcessada) == 1)
        parar = 1;
        ImagemProcessada(i_anterior,j_anterior) = 0;
        ImagemProcessada(i,j) = 0;
    else
        ImagemProcessada(i_anterior,j_anterior) = 0;
    end
    
end % end_while

function pt = getVizinho(i,j,ImagemProcessada)

parar = 0;
count = 1;

pt_vizinhos = [[-1; 0] [-1; 1] [0; 1] [1; 1] [1; 0] [1; -1] [0; -1] [-1; -1]];

while(parar ~= 1)
    
    a = pt_vizinhos(1,count);
    b = pt_vizinhos(2,count);
        
    if (i + a > 0 &&  i + a <= size(ImagemProcessada,1))
        if (j + b > 0 &&  j + b <= size(ImagemProcessada,2))
            if( ImagemProcessada(i+a,j+b) == 1)
                parar = 1;
                pt = [(i+a),(j+b)];
            end % end_if vizinho
        end % end_if condição de coluna (dentro da imagem)
    end % end_if condição de linha (dentro da imagem)
    
    
    count = count + 1;
        
end %end_while condição de parada pixel == 1
