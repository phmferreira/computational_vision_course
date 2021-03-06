%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis?o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo FoS (F* seed-growning)
% Descri??o na subse??o 3.2 do artigo de ref.

function [P_e1, P_e2, PH, nApc] = FoS(I, S)

% len ? a metade da largura da imagem (? assumido que a imagem ? quadrada)
len = size(I,2);
len = floor(len/2);

% Usando o algoritmo F* para calcular a matriz de custo
% X <- Matriz de custo m?nimo do caminho
% L <- Matriz do n?mero de nodos no caminho m?nimo de acordo com X
[X, L] = F_asterisco(I, S);

% Calculando o custo m?dio de cada caminho
X_chapeu = X./L;

% Salvando imagem da martix X_chapeu
% im = X_chapeu*(1/max(max(X_chapeu)));
% imagem = imshow(im);
% saveas(imagem, 'matriz_x_chapeu.jpg', 'jpg');

% ? extra?do as c?lulas da borda da imagem (ou sub-imagem)
B = getBoundary(X_chapeu);

% Calulo das poss?veis candidatas para ponto 
% do in?cio e fim da rachadura

% M ? o conjunto de pontos de bordas candidatas
M = [];

for i = 1:size(B,1)
    % ? analisado para cada c?lula da borda b_i
    % se b_i ? o menor valor dentre os 2*len vizinhos 
    % (dentre os vizinho da borda)
    % se for o menor ent?o ? uma candidata
    isLowest = LowestInNeighbor(i, B, len, X_chapeu);
    if (isLowest == 1)
        M = [M i];
    end % end_if
end % end_for

% Adapta??o
if(size(M,2) == 1)
    for i = 1:size(B,1)
        % ? analisado para cada c?lula da borda b_i
        % se b_i ? o menor valor dentre os 2*len vizinhos
        % (dentre os vizinho da borda)
        % se for o menor ent?o ? uma candidata
        isLowest = LowestInNeighbor(i, B, 1, X_chapeu);
        if (isLowest == 1)
            M = [M i];
        end % end_if
    end % end_for
end

% ? escolhido dois pontos de M que minimiza o
% caminho de P_e1 -> S -> P_e2
[P_e1, P_e2] = getEndPoints(M, B, X_chapeu, S, len);

% PH ? o caminho m?nimo de P_e1 -> S -> P_e2
PH = getPath(X_chapeu, S, P_e1, P_e2, B);

% Coordenadas de P_e1 e P_e2
P_e1 = [B(P_e1,1) B(P_e1,2)];
P_e2 = [B(P_e2,1) B(P_e2,2)];

nApc = X_chapeu(P_e1(1), P_e1(2)) + X_chapeu(P_e2(1), P_e2(2));

% #############################################################%
% ##### Se??o Fun??es Auxiliares ####
% #############################################################%

% Fun??o que pega todos nodo de borda da imagem
% Caminha pela borda no sentido hor?rio
% Iniciando do ponto (1,1)

function B = getBoundary(X_chapeu)

B = [];
row = size(X_chapeu,1);
col = size(X_chapeu,2);

% pegando a primeira borda
% borda superior da imagem
% i = 1 e j = 1:col

for j = 1:col
    B = [B; 1 j];
end

% pegando a segunda borda
% borda direita da imagem
% i = 2:row e j = col

for i = 2:row
    B = [B; i col];
end

% pegando a terceira borda
% borda inferior da imagem
% i = row e j = col:-1:1

for j = (col-1):-1:1
    B = [B; row j];
end

% pegando a quarta borda
% borda direita da imagem
% i = row:-1:1 e j = 1

for i = (row-1):-1:2
    B = [B; i 1];
end

function isLowest = LowestInNeighbor(i, B, len, X_chapeu)

% isLowest = false
isLowest = 0;

% getNeighbor

N = [];
B_length = size(B,1);

% Caminhando para direita
for d = i:(i+len)
    if (d > B_length)
        N = [N [B(d - B_length, 1); B(d - B_length, 2)]];
    else
        N = [N [B(d, 1); B(d, 2)]];
    end
end

% Caminhando para esquerda

for e = (i-1):-1:(i-len)
    if (e < 1)
        N = [N [B(B_length + e, 1); B(B_length + e, 2)]];
    else
        N = [N [B(e, 1); B(e, 2)]];
    end
end

% IsLowest

N_X = [];

for n = N
    
    N_X = [N_X X_chapeu(n(1),n(2))];
    
end

[M, I] = min(N_X);

% Verificando se o 1 ? o menor entre os (len) vizinhos

if (I == 1)
    isLowest = 1;
end

function [P_e1, P_e2] = getEndPoints(M, B, X_chapeu, S, len)

custos = [];

for i = M
    % calcular custo m?dio do caminho P_atual at? S
    
    custo = caminhar_X(B(i,1), B(i,2), X_chapeu, S);
    custos = [custos custo];
end

[S, I] = sort(custos);

P_e1 = M(I(1));

if(size(I,2) == 1)
    parar = 1;    
end

parar = 0;
indice = 2;

while(parar == 0)
    P_e2 = M(I(indice));
    dist = abs(P_e2 - P_e1);
    
    if(dist > len)
        parar = 1;
    else
        indice = indice + 1;
    end
    
    if (indice == size(I))
        parar = 2;
        P_e2 = M(I(indice));
    end
end

function PH = getPath(X, S, P_e1, P_e2, B)

path1 = getParcialPath(X, S, P_e1, B);
path2 = getParcialPath(X, S, P_e2, B);

% unindo os dois caminhos
tamanho_path2 = size(path2,2);
path2 = path2(:,(tamanho_path2-1):-1:1);
PH = [path1 path2];

function path = getParcialPath(X, S, P_e, B)

i = B(P_e,1);
j = B(P_e,2);
[custo, path] = caminhar_X(i, j, X, S);
