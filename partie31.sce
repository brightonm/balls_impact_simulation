// PARTIE 3.1 (N Billes, modèle non linéaire)
// Fichier exécutable qui appelle partie31.sci

mode(1) // permet d'exécuter ce script Scilab sans afficher les variables longues à afficher


exec('partie31.sci') // Importation des fonctions utilisées. Se placer dans le bon dssier dans la console Scilab pour éviter les erreurs. 

// On choisit d'initialiser au préalable en tant que variable globale h, m et x^(k)et x^(k-1). Cela étant plus utile pour la suite. 

h = 0.1 // h est le pas 
m = 1 // m est le poids de la petite bille, compris en 0 et 1  
// x_k est x^(k) et x_k1 est x^(k-1) deux vecteurs de R^n quelconques
x_k = []
x_k1 = [] 

// QUESTION 9

// On fixe n=21, T = 60 et les conditions initiales énoncées dans l'énoncé. 

n = 21
x_0 = diag(zeros(21,21))
x_m1 = diag(zeros(20,20)) // On rajoute le premier élément ensuite, en fonction de h

// Pour m=1, on initialise la variable globale m et la matrice diagonale correspondante
M = eye(n,n) // Matrice des poids

// Pour h=10^(-1), on initialise les paramètres globaux
h = 10**(-1)
x_m1 = [-h;x_m1] // On rajoute le prmeier élément de x_m1
T = 60
N = T/h // On actualise N
solution1 = solnumerique(x_0, x_m1, N) // TEMPS COMPILATION environ 5 sec

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solution1, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'r')
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Energie mécanique", "fontsize", 5)


// Pour h = 10**(-2), on initialise les paramètres globaux

h = 10**(-2)
x_m1(1) = -h // On rajoute le prmeier élément de x_m1
N = T/h // On actualise N
solution2 = solnumerique(x_0, x_m1, N) // TEMPS COMPILATION environ 1min

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solution2, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'g')

// Pour h = 10**(-3), on initialise les paramètres globaux

h = 10**(-3)
x_m1(1) = -h // On rajoute le premier élément de x_m1
N = T/h // On actualise N
solution3 = solnumerique(x_0, x_m1, N) // TEMPDS COMPILATION environ 10minutes

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solution3, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'b')
l = legend("h = 0.1", "h = 0.01", "h = 0.001")
l.font_size = 3

clf()


// Pour m=0.5, on initialise la variable globale m et la matrice diagonale correspondante
m = 0.5
M = matrice_poids(m)
// Pour h=10^(-1), on initialise les paramètres globaux
h = 10**(-1)
x_m1(1) = -h // On rajoute le prmeier élément de x_m1
T = 60
N = T/h // On actualise N
solutionbis1 = solnumerique(x_0, x_m1, N) // Compilation 5 sec environ

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solutionbis1, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'r')
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Energie mécanique", "fontsize", 5)

// Pour h = 10**(-2), on initialise les paramètres globaux

h = 10**(-2)
x_m1(1) = -h // On rajoute le prmeier élément de x_m1
N = T/h // On actualise N
solutionbis2 = solnumerique(x_0, x_m1, N) // Compilation : 1 min

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solutionbis2, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'g')

// Pour h = 10**(-3), on initialise les paramètres globaux

h = 10**(-3)
x_m1(1) = -h // On rajoute le prmeier élément de x_m1
N = T/h // On actualise N
solutionbis3 = solnumerique(x_0, x_m1, N) // Compilation : 10 min environ

// Traçons le graphe de l'approximation de l'énergie mécanique en fonction de t=kh
vect_tps =[0:h:T] //abscisses
vect_em = vect_energie_meca(solutionbis3, N, n, M, h) // ordonnees
plot(vect_tps, vect_em', 'b')
l = legend("h = 0.1", "h = 0.01", "h = 0.001")
l.font_size = 3

clf()

// QUESTION 10

// On trace les graphes des vitesses en fonction du temps pour les différentes billes

m = 1
M = eye(n,n)

plot(vect_tps', deplacements_vers_vitesses(solution3,1), 'r')
plot(vect_tps', deplacements_vers_vitesses(solution3,7), 'b')
plot(vect_tps', deplacements_vers_vitesses(solution3,11), 'g')
plot(vect_tps', deplacements_vers_vitesses(solution3,15), 'c')
plot(vect_tps', deplacements_vers_vitesses(solution3,19), 'm')
plot(vect_tps', deplacements_vers_vitesses(solution3,20), 'y')
plot(vect_tps', deplacements_vers_vitesses(solution3,21), 'k')
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesse des billes", "fontsize", 5)
l = legend("bille 1", "bille 7", "bille 11", "bille 15", "bille 19", "bille 20", "bille 21")
l.font_size = 3

// COMM : vitesse d'ejections de la dernière bille etc ...

clf() // clear graph

// On augmente la taille de la pile variables locales de scilab 

// stacksize('max') // Ne fonctionne pas sur la version 6.0.1 de Scilab. Pas nécessaire ici. La taille de la bille est assez grande pour notre utilisation. 

// On représente en niveau de gris les valeurs des forces de contact

forces = force_contact(solution3)

y = [0:N]
x = [1:(n-1)]
Sgrayplot(x, y, forces)
ylabel("Nombre de points de discrétisation", "fontsize", 5)
xlabel("Numéro des billes", "fontsize", 5)


// QUESTION 11

// Idem avec m = 0.5
// On trace les graphes des vitesses en fonction du temps pour les différentes billes
m = 0.5
M = matrice_poids(m)

plot(vect_tps', deplacements_vers_vitesses(solutionbis3,1), 'r')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,7), 'b')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,11), 'g')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,15), 'c')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,19), 'm')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,20), 'y')
plot(vect_tps', deplacements_vers_vitesses(solutionbis3,21), 'k')
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesse des billes", "fontsize", 5)
l = legend("bille 1", "bille 7", "bille 11", "bille 15", "bille 19", "bille 20", "bille 21")
l.font_size = 3

// COMM : vitesse d'ejections de la dernière bille etc ...

clf() // clear graph

// On représente en niveau de gris les valeurs des forces de contact

forces = force_contact(solutionbis3)

y = [0:N]
x = [1:(n-1)]
Sgrayplot(x, y, forces)
ylabel("Nombre de points de discrétisation", "fontsize", 5)
xlabel("Numéro des billes", "fontsize", 5)

// QUESTION 12

// On modifie les paramètres
n = 21
x_0 = diag(zeros(21,21))
x_m1 = diag(zeros(21,21))
h = 10^(-2)
N = 6000
T = 60
x_m1(1) = -h

// TEMPS COMPILATION : environ 10min
vecteur_masse = [0.1: 0.1: 1] // abscisses
vect_vit = feval(vecteur_masse, vitesses_ejection) // ordonnees, on applique terme à terme notre fonction 


plot(vecteur_masse, vect_vit)
xlabel("Masse de la petite bille","font_size", 5)
ylabel("Vitesse ejection de la dernière bille", "font_size", 5)

clf() // clear graph



