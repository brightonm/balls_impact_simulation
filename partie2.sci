// PARTIE 2 (2 Billes)
// Fichier contenant les fonctions qui seront appelées par partie2.sce

// QUESTION 2

function F_Y = rhs(Y) 
    // F_Y et Y appartiennent à R^4
    // Y = [x1, x2, v1, v2]
    F_Y(1) = Y(3)
    F_Y(2) = Y(4)
    F_Y(3) = - max(Y(1) - Y(2), 0)**(3/2)
    F_Y(4) = - F_Y(3)
endfunction

// QUESTION 3

function solution = eulerexp(Y_0, T, N)
    h = T/N  // pas
    solution(:,1) = Y_0 // on initialise le vecteur solution
    for k=1:N
        solution(:,k+1) = solution(:,k)+ h*rhs(solution(:,k))
    end
endfunction
