function AlgoritmoLocal()

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Visão Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% QUESTÂO 1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo de segmentação a partir do embaçamento

colorida = imread('flor','bmp'); % Abre a imagem
cinza = rgb2gray(colorida);    % Converte para escala de cinza

imshow(cinza);                 % Mostra o resultado

% tamanho da janela é 17x17

linhas = floor(size(cinza,1)/17);
colunas = floor(size(cinza,2)/17);

% Matriz com os valores alfa local para cada janela
Alfa_locais = zeros(linhas,colunas);

for i = 1:linhas
    
    x = (i-1)*17 + 1;
    x2 = x + 16;
    
    for j = 1:colunas
        y = (j-1)*17 + 1;
        y2 = y + 16;
        [Quarter1] = cinza(x:x2, y:y2);
        
        %Calculando localmente o valor de alfa
        alfa_local = local_power_spretrum(Quarter1);
        Alfa_locais(i,j) =  alfa_local;
    end
end


% Segmentação por limiar


function alfa = local_power_spretrum(janela)

% Calculando o espectro de potência (power spectrum)

N1 = size(janela,1);
N2 = size(janela,2);
N = N1*N2;

% Calculando a transformada de fourier da imagem
fftA = fft2(janela);

% Calculando o valor absoluto e elevando ao quadrado
abs_fftA = abs(fftA);
squar_fftA = abs_fftA^2;

% Espectro de potência
S = (1/N)*squar_fftA;

% Transformação de coordenadas cartesianas para polares
[S_polar, sum_r] = transformacao_polar(S);

S_f_sum = sum(S_polar,1);

loglog(sum_r);

loglog(S_f_sum);

alfa = (log(sum_r(1)) - log(sum_r(5)))/(log(5)-log(1));


% transformando para forma polar
function [output, sum_r] = transformacao_polar(input)

sum_r = zeros(300,1); % somatório fixando o raio e variando o ângulo

oRows = size(input, 1);
oCols = size(input, 2);
dTheta = 2*pi / oCols;
%b = 10 ^ (log10(oRows) / oRows); 

for i = 1:oRows % rows
    for j = 1:oCols % columns
        %r = b ^ i - 1; % the log-polar
        r = (i.^2+j.^2).^.5;
        theta = j * dTheta;
        x = round(r * cos(theta) + size(input,2) / 2);
        y = round(r * sin(theta) + size(input,1) / 2);
        
        if (x>0) & (y>0) & (x<size(input,2)) & (y<size(input,1))
            output(i,j) = input(y,x);
            
            [THETA,RHO] = cart2pol(x - size(input,2) / 2,y - size(input,1) / 2);
            sum_r(round(RHO)) = sum_r(round(RHO)) + input(y,x);
        end
    end
end
