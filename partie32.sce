// PARTIE 3.2 (N Billes, modèle linéaire)
// Fichier exécutable qui appelle partie32.sci

mode(1) // permet d'exécuter ce script Scilab sans afficher les variables longues à afficher

exec('partie32.sci') // Importation des fonctions utilisées. Se placer dans le bon dssier dans la console Scilab pour éviter les erreurs. 

// Test des fonctions de résolution d'un système par la méthode de Cholesky

p = 7
diago = 2*diag(eye(p,p))
diago = [1;diago]
sous_diago = (-1)*diag(eye(p,p))
b = [1:p+1]'

[linf, ldiag] = factorise(diago, sous_diago)
y = descente(linf, ldiag, b)
sol_cholesky = remonte(linf, ldiag, y)

A = diag(diago,0) + diag(sous_diago,-1) + diag(sous_diago, 1)
sol_normal = inv(A) * b


// QUESTION 19

// On construit la matrice A en tant que variable globale avec conditions initiales

h = 10^(-3)
n = 63
T = 135
N = T/h
m = 1
M = matrice_poids(m)
u_0 = diag(zeros(n,n))
u_m1 = diag(zeros(n,n))

diagonale = 2*diag(eye(n,n))
diagonale(1) = 1
sous_diagonale = (-1)*diag(eye(n-1,n-1))
D = diag(diagonale,0) + diag(sous_diagonale,-1) + diag(sous_diagonale, 1)

// Matrice A tridiagonale 

diago = diag(M) + (h**2)*diag(D)
sous_diago = (h**2)*sous_diagonale 

// Factorisation de Cholesky de A 

[linfe, ldiag] = factorise(diago, sous_diago)

// Résolution

solution = boucle(u_m1, u_0) 

// On trace les vitesses en fonction du temps. 

vect_tps = [0:h:T]'
vect_vitesse1 = vitesses(solution,1)
vect_vitesse8 = vitesses(solution,8)
vect_vitesse32 = vitesses(solution,32)
vect_vitesse48 = vitesses(solution,48)
vect_vitesse63 = vitesses(solution,63)

plot(vect_tps, vect_vitesse1(2:N+2))
plot(vect_tps, vect_vitesse8(2:N+2), 'r')
plot(vect_tps, vect_vitesse32(2:N+2), 'g')
plot(vect_tps, vect_vitesse48(2:N+2), 'y')
plot(vect_tps, vect_vitesse63(2:N+2), 'k')
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesses des billes", "fontsize", 5)
l = legend("bille 1", "bille 8", "bille 32", "bille 48", "bille 63")
l.font_size = 3

clf() // clear graph

// Traçons les vitesses en fonction de i pour k = T/4h

tps = T/(4*h)
vect_i = [1:n]'
vect_vitesse2 = vitesses2(solution, tps)
plot(vect_i, vect_vitesse2)
xlabel("Billes", "fontsize", 5)
ylabel("Vitesses des billes au temps fixé", "fontsize", 5)

clf()

//Traçons l'energie cinétique en fonction de i et k
// On fixe p = 100

ec = energie_cinetique(solution, 100)
y = [0.1:(0.1):T]
x = [1:n]
Sgrayplot(x, y, ec)
ylabel("Temps", "fontsize", 5)
xlabel("Billes", "fontsize", 5)

// QUESTION 20

n = 31
m = 0.6
M = matrice_poids(m)
T = 95
h = 5*10^(-3)
N = T/h
u_0 = diag(zeros(n,n))
u_m1 = diag(zeros(n,n))

diagonale = 2*diag(eye(n,n))
diagonale(1) = 1
sous_diagonale = (-1)*diag(eye(n-1,n-1))
D = diag(diagonale,0) + diag(sous_diagonale,-1) + diag(sous_diagonale, 1)

// Matrice A tridiagonale 

diago = diag(M) + (h**2)*diag(D)
sous_diago = (h**2)*sous_diagonale 

// Factorisation de Cholesky de A 

[linfe, ldiag] = factorise(diago, sous_diago)

// Résolution

vect_w = [1.2:0.05:2.4]
vect_vit = feval(vect_w, rapport_vitesse)

plot(vect_w, vect_vit)
xlabel("Fréquence de forçage", "fontsize", 5)
ylabel("Rapports des vitesses maximales de la dernière et de la première bille", "fontsize", 5)




