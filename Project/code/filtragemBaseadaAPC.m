%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Vis�o Computacional %%%%%%%%%%%%%%%%%%%
%%%%%%%% Projeto 2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%% Aluno: Paulo Henrique Muniz Ferreira %%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Algoritmo filtragem baseada no APC
% Descri��o na subse��o 4.4 do artigo de ref.

% Esse procedimento vai dividir o conjunto de elementos
% em dois segundo o algoritmo de agrupamento de Otsu [ref-18]
% no caso, o atributo usado para categorizar � nApc

function [novoConjunto] = filtragemBaseadaAPC(ConjuntoElementos)

% ---------Se��o de testes---------
% Figura do exemplo 3
% ConjuntoElementos = SecoesToElementos([]);
% ---------------------------------

Vetor_nApc = [];

for elemento = ConjuntoElementos
    Vetor_nApc = [Vetor_nApc elemento.nApc];
end

% normaliza��o 0 - 1

[pn, pm] = mapminmax(Vetor_nApc);

Vetor_nApc_normalizado = (Vetor_nApc - repmat(pm.xmin, 1, ... 
    size(Vetor_nApc,2)))./repmat((pm.xrange), 1, size(Vetor_nApc,2));

limiar = graythresh(Vetor_nApc_normalizado);

% Filtragem

novoConjunto = [];

for i = 1:size(Vetor_nApc_normalizado,2)
    s = ConjuntoElementos(i);
    if (Vetor_nApc_normalizado(i) <= limiar)
        novoConjunto = [novoConjunto s];
    end % end_if
end % end_for

