// PARTIE 2 (2 Billes)
// Fichier exécutable qui appelle partie2.sci

mode(1) // permet d'exécuter ce script Scilab sans afficher les variables longues à afficher

exec('partie2.sci') // Importation des fonctions utilisées. Se placer dans le bon dssier dans la console Scilab pour éviter les erreurs. 


// QUESTION 4

Y_0 = [0, 0, 1, 0] // Conditions initiales
T = 4 // Temps maximal d'intégration
// Nombre de points de discrétisation en temps 
h1 = 10**(-1)
h2 = 10**(-2)
h3 = 10**(-3)
N1 = T/h1 
N2 = T/h2
N3 = T/h3 

// Traçage des graphes des déplacements et des vitesses

// 1er cas : h = 10^(-1)

vecteur_tps1 = [0:h1:T] // abscisses
solution1 = eulerexp(Y_0, T, N1) 
x1 = solution1(1,:) //ordonnées déplacement bille 1
x2 = solution1(2,:) //ordonnées déplacement bille 2
plot(vecteur_tps1, x1, 'r') // graphe des déplacements de la bille 1
plot(vecteur_tps1, x2, 'g') // on superpose déplacement de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Position des billes", "fontsize", 5)
l = legend("x1", "x2")
l.font_size = 3
clf() // clear graph

v1 = solution1(3,:) //ordonnées vitesse bille 1
v2 = solution1(4,:) //ordonnées vitesse bille 2
plot(vecteur_tps1, v1, 'r') // graphe vitesse de la bille 1
plot(vecteur_tps1, v2, 'g') // on superpose vitesse de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesse des billes", "fontsize", 5)
l = legend("v1", "v2")
l.font_size = 3
clf() // clear graph

// 2ème cas : h = 10^(-2)

vecteur_tps2 = [0:h2:T] // abscisses
solution2 = eulerexp(Y_0, T, N2)
x1 = solution2(1,:) //ordonnées déplacement bille 1
x2 = solution2(2,:) //ordonnées déplacement bille 2
plot(vecteur_tps2, x1, 'r') // trace graphe des déplacements de la bille 1
plot(vecteur_tps2, x2, 'g') // on superpose déplacement de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Position des billes", "fontsize", 5)
l = legend("x1", "x2")
l.font_size = 3
clf() // clear graph
v1 = solution2(3,:) //ordonnées vitesse bille 1
v2 = solution2(4,:) //ordonnées vitesse bille 2
plot(vecteur_tps2, v1, 'r') // graphe vitesse de la bille 1
plot(vecteur_tps2, v2, 'g') // on superpose vitesse de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesse des billes", "fontsize", 5)
l = legend("v1", "v2")
l.font_size = 3
clf() // clear graph

// 3ème cas : h = 10^(-3)

vecteur_tps3 = [0:h3:T] //abscisses
solution3 = eulerexp(Y_0, T, N3)
x1 = solution3(1,:) //ordonnées déplacement bille 1
x2 = solution3(2,:) //ordonnées déplacement bille 2
plot(vecteur_tps3, x1, 'r') // trace graphe des déplacements de la bille 1
plot(vecteur_tps3, x2, 'g') // on superpose déplacement de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Position des billes", "fontsize", 5)
l = legend("x1", "x2")
l.font_size = 3

clf() // clear graph

v1 = solution3(3,:) //ordonnées vitesse bille 1
v2 = solution3(4,:) //ordonnées vitesse bille 2
plot(vecteur_tps3, v1, 'r') // graphe vitesse de la bille 1
plot(vecteur_tps3, v2, 'g') // on superpose vitesse de la bille 2
xlabel("Temps (secondes)", "fontsize", 5)
ylabel("Vitesse des billes", "fontsize", 5)
l = legend("v1", "v2")
l.font_size = 3
clf() // clear graph

