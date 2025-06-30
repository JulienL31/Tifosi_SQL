-- Script de vérification : 10 requêtes SQL
USE tifosi;

-- Requête 1 : Afficher la liste des noms des focaccias par ordre alphabétique croissant
-- Résultat attendu : Emmentalaccia, Gorgonzollaccia, Mozaccia, Raclaccia, Tradizione
SELECT nom FROM focaccia ORDER BY nom ASC;

-- Requête 2 : Afficher le nombre total d'ingrédients
-- Résultat attendu : 30 (si tous les ingrédients sont bien insérés depuis le fichier Excel)
SELECT COUNT(*) AS total_ingredients FROM ingredient;

-- Requête 3 : Afficher le prix moyen des focaccias
-- Résultat attendu : Moyenne calculée des prix présents (ex: 9.64 selon données actuelles)
SELECT ROUND(AVG(prix), 2) AS prix_moyen FROM focaccia;

-- Requête 4 : Afficher la liste des boissons avec leur marque, triée par nom de boisson
-- Résultat attendu : Liste jointe triée (ex: Capri-sun - Coca-cola, Coca-cola original - Coca-cola, etc.)
SELECT boisson.nom AS nom_boisson, marque.nom AS marque FROM boisson JOIN marque ON boisson.id_marque = marque.id_marque ORDER BY boisson.nom;

-- Requête 5 : Afficher la liste des ingrédients pour une Raclaccia
-- Résultat attendu : Base tomate, Raclette, Cresson, Ail, Champignon, Oignon
SELECT i.nom AS ingredient FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE f.nom = 'Raclaccia';

-- Requête 6 : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
-- Résultat attendu : Liste des focaccias avec le nombre d'ingrédients (ex: Mozaccia - 6, Gorgonzollaccia - 6, etc.)
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia GROUP BY f.nom;

-- Requête 7 : Afficher le nom de la focaccia qui a le plus d'ingrédients
-- Résultat attendu : Une seule focaccia, ex: Gorgonzollaccia
SELECT f.nom FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia GROUP BY f.nom ORDER BY COUNT(c.id_ingredient) DESC LIMIT 1;

-- Requête 8 : Afficher la liste des focaccia qui contiennent de l'ail
-- Résultat attendu : Liste des focaccias ayant de l’ail (ex: Gorgonzollaccia, Raclaccia)
SELECT DISTINCT f.nom FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE i.nom = 'Ail';

-- Requête 9 : Afficher la liste des ingrédients inutilisés
-- Résultat attendu : Liste des ingrédients non utilisés dans aucune focaccia (ex: Ananas, Maïs, etc.)
SELECT nom FROM ingredient WHERE id_ingredient NOT IN (SELECT DISTINCT id_ingredient FROM comprend);

-- Requête 10 : Afficher la liste des focaccia qui n'ont pas de champignons
-- Résultat attendu : Liste des focaccias sans champignons (ex: Tradizione, Mozaccia)
SELECT f.nom FROM focaccia f WHERE f.id_focaccia NOT IN (SELECT DISTINCT c.id_focaccia FROM comprend c JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE i.nom = 'Champignon');
