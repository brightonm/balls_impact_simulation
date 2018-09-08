// PARTIE 3.2 (N Billes, modèle linéaire)
// Fichier contenant les fonctions qui seront appelées par partie32.sce

// QUESTION 15

// REMARQUE : On remplace la variable linf de l'énoncé par la variable linfe pour éviter des erreurs à l'éxécution car linf est une fonction déjà implémentée sous Scilab
function [linfe, ldiag] = factorise(diago, sous_diago)
    // On suppose diago et sous
    // Factorisation de Cholesky pour matrice tridiagonale
    // On applique simplement l'algorithme de factorisation du cours
    // 1er colonne
    ldiag(1) = sqrt(diago(1))
    linfe(1) = sous_diago(1)/ldiag(1)
    n = size(diago)(1) // vecteur colonne
    // colonnes 2 à n-1
    for i=2:(n-1)
        ldiag(i) = sqrt(diago(i) - linfe(i-1)**2)
        linfe(i) = (sous_diago(i))/ldiag(i)
    end
    ldiag(n) = sqrt(diago(n) - linfe(n-1)**2)
endfunction

// QUESTION 16

function y = descente(linf, ldiag, b)
    // Fonction résolvant le système Ly=b 
    // On applique la méthode de Gauss simplifiée pour les matrices bidiagonales inférieures
    n = size(ldiag)(1)
    y(1) = b(1)/ldiag(1)
    for i=2:n
        y(i) = (b(i)-linf(i-1)*y(i-1))/ldiag(i)
    end
endfunction

// QUESTION 17

function u = remonte(linf, ldiag, y)
    // Fonction résolvant le système t(L)u=y
    // On applique la méthode de Gausse simplifiée pour un matrice biadigonale supérieure, i.e on part de la fin on prend la transposée
    n = size(ldiag)(1)
    u(n) = y(n)/ldiag(n)
    for i=(n-1):(-1):1
        u(i) = (y(i) - linf(i)*u(i+1))/ldiag(i)
    end
endfunction

// QUESTION 18

function M = matrice_poids(m)
    M = eye(n,n) // Matrice des poids
    for i = 1:n
        if ~modulo(i, 2) then
            M(i,i) = m
        end,
    end
endfunction

// Force extérieur appliquée à la première bille

function image = f1(t)
    if t <= 0.5 && t >= 0   then
        image = t
    end,
    if t <= 1 && t > 0.5 then 
        image = 1-t
    end,
    if t > 1 || t < 0 then
        image = 0
    end, 
endfunction

// Résolution 

function solution = boucle(u_m1, u_0)
    solution = [u_m1, u_0] // Cela décale les indices de 2 mais permet de tout fair en une seule boucle
    for k=3:N+2
    // On crée b à chaque étape
        b_k = [M(1,1)*(2*solution(1,k-1)-solution(1,k-2)) + f1(k*h)*h*h] // 1ere ligne de b_k
        for i=2:n // On parcourt les billes
            b_k = [b_k; M(i,i)*(2*solution(i,k-1)-solution(i,k-2))]
        end
        y_k = descente(linfe, ldiag, b_k)
        u_k1 = remonte(linfe, ldiag, y_k) // On calcule u^(k+1)
        solution(:,k) = u_k1 // On l'ajoute à la matrice solution
    end
endfunction

// QUESTION 19 

// Fonction produisant les vitesses à partir des positions

function vect_vitesse = vitesses(solution, i)
    // i est le vect vitesse de la ième bille
    p = size(solution)(2)
    for k=2:p
        vect_vitesse(k) = (solution(i,k)-solution(i,k-1))/h 
    end
endfunction

// Fonction produisant les vitesses pour toutes les billes à partir des positions à temps fixé
function vect_vitesse2 = vitesses2(solution, tps)
    for i=1:n
        vect_vitesse2(i) = (solution(i,tps)-solution(i,tps-1))/h 
    end
endfunction

// Fonction produisant la matrice des energies cinétiques

function mat = energie_cinetique(solution, p)
    l = size(solution)(2)
    for i=1:n
        mat(i,1) = 0.5*((solution(i,2)-solution(i,1))/h )**2 // m=1
    end
    for k = p:p:l
        for i=1:n
            
            mat(i,k/p) = 0.5*((solution(i,k)-solution(i,k-1))/h )**2 // m=1
        end
    end
endfunction

// QUESTION 20

// Force extérieur appliquée à la première bille

function image = f2(t,w)
    // w variable globale
    image = sin(w*t)*tanh(t)
endfunction

// Résolution 

function solution = boucle2(w)
    solution = [u_m1, u_0] // Cela décale les indices de 2 mais permet de tout fair en une seule boucle
    for k=3:N+2
    // On crée b à chaque étape
        b_k = [M(1,1)*(2*solution(1,k-1)-solution(1,k-2)) + f2(k*h, w)*h*h] // 1ere ligne de b_k
        for i=2:n // On parcourt les billes
            b_k = [b_k; M(i,i)*(2*solution(i,k-1)-solution(i,k-2))]
        end
        y_k = descente(linfe, ldiag, b_k)
        u_k1 = remonte(linfe, ldiag, y_k) // On calcule u^(k+1)
        solution(:,k) = u_k1 // On l'ajoute à la matrice solution
    end
endfunction

// Fonction calculant la norme infini de v_n 

function res = norme_inf (solution)
    res = 0
    for k = 2:N
        v = (solution(31,k)-solution(31,k-1))/h
        if abs(v) > res then
            res = abs(v)
        end
    end
endfunction

// Fonction calculant la norme infini de v_1

function res = norme_inf1 (solution)
    res = 0
    for k = 2:N
        v = (solution(1,k)-solution(1,k-1))/h
        if abs(v) > res then
            res = abs(v)
        end
    end
endfunction

// Fonction de calculer le rapport des vitesse

function rapport = rapport_vitesse(w)
    solution = boucle2(w)
    rapport = norme_inf(solution) / norme_inf1(solution)
endfunction


