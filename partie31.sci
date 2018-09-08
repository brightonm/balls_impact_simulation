// PARTIE 3.1 (N Billes, modèle non linéaire)

// Fichier contenant les fonctions qui seront appelées par partie31.sce

// QUESTION 7

// On choisit d'initialiser au préalable en tant que variable globale h, m et x^(k)et x^(k-1). Cela étant plus utile pour la suite. (cf fichier exécutable)

function res_vect = feulerimp(y)
    // res_vect et y sont des vecteurs de R^n
    n = size(y)(1)
    // On calcule la l'image de y par f
    f_y = - max(y(1) - y(2), 0)^(3/2) // Premier élément de f(y)
    // Calcul et ajout des éléments suivants de f(y)
    for i = 2:(n-1)
        row_to_add = max(y(i-1) - y(i), 0)^(3/2) - max(y(i) - y(i+1), 0)^(3/2)
        f_y = [f_y; row_to_add]
    end
    // Ajout du dernier élément de f(y)
    f_y = [f_y; max(y(n-1) - y(n), 0)^(3/2)]
    res_vect = M * (y - 2*x_k + x_k1) - h^2*f_y
endfunction

// QUESTION 8

function res = solnumerique(x_0, x_m1, N)
    // N est le nombre d'itérations
    // x_0 est x^(0) et x_m1 est x^(-1) deux vecteurs de R^n quelconques
    // res est un vecteur de R^n
    res(:,1) = x_m1
    res(:,2) = x_0
    for k = 2:(N+1) // On va jusqu'à (N+1) pour à la fin avoir un vecteur solution de taille N.
    // On réactualise certaines variables globales pour utiliser judicieusement la fonction feulerimp
       x_k1  = res(:,k-1)
       x_k  = res(:,k)
       res(:,k+1) = fsolve(x_k, feulerimp) // x_app = x^(k) approximativement car h est petit
    end
    res = res(:,2:(N+2)) // on enlève le vecteur initial car le temps commence à 0 pour renvoyer une solution numérique traçable.
endfunction

// QUESTION 9

// Fonction permettant de creer le vecteur de l'energie mécanique en fonction de t
function H = vect_energie_meca(solution, N, n, M, h)
    // h : pas, M : matrice des poids, n : nb de billes, N : nombre de répétitions, solution : matrice solution des déplacements. 
    H = []
    H(1) = 0 // k=1
    for i=1:n // 1ere somme pour k=1
        v_i_1 = (solution(i,1) - x_m1(i))/h
        H(1) = H(1) + 0.5*M(i,i)*(v_i_1)**2// On crée H^1 séparemment car les vitesses initiales ne sont pas contenues dans la matrice solution
    end,
    for i=1:(n-1) // 2eme somme
        H(1) = H(1) + (2/5)*max(solution(i,1)-solution(i+1,1), 0)**(5/2)
    end,
    for k= 2:(N+1) // k > 1
        H(k) = 0
        for i=1:n // 1ere somme
            v_i_k = (solution(i,k) - solution(i,k-1))/h
            H(k) = H(k) + 0.5*M(i,i)*(v_i_k)**2
        end,
        for i=1:(n-1) // 2eme somme
            H(k) = H(k) + (2/5)*max(solution(i,k)-solution(i+1,k), 0)**(5/2)
        end,
    end,
endfunction

// Fonction créant la matrice M à partie de m. 
function M = matrice_poids(m)
    M = eye(n,n) // Matrice des poids
    for i = 1:n
        if ~modulo(i, 2) then
            M(i,i) = m
        end,
    end
endfunction

// QUESTION 10

// On trace les graphes des vitesses en fonction du temps pour les différentes billes

function vect_vitesse = deplacements_vers_vitesses(solution, i)
    // 
    vect_vitesse = [(solution(i,1) - x_m1(i))/h] // On initialise le vecteur vitesse 
    for k=2:(N+1)
        vect_vitesse(k) = (solution(i,k) - solution(i,k-1))/h
    end
endfunction

function res = force_contact(solution)
    // Fonction créant la matrice des forces de contact
    res = []
    for k=1:(N+1)
        for i=1:(n-1)
            res(i,k) = max(solution(i,k) - solution(i+1,k), 0)**(3/2)
        end
    end
endfunction

// QUESTION 12 

function res = vitesses_ejection(m)
    // Fonction renvoyant la vitesse d'ejection en fonction de la masse m
    M = matrice_poids(m)
    solution = solnumerique(x_0, x_m1, N)
    res = (solution(n, N) - solution(n, N-1))/h
endfunction


