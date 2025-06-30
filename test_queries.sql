-- Script de vérification : 10 requêtes SQL
USE tifosi;

-- Requête 1 : Afficher la liste des noms des focaccias par ordre alphabétique croissant
SELECT nom FROM focaccia ORDER BY nom ASC;

-- Requête 2 : Afficher le nombre total d'ingrédients
SELECT COUNT(*) AS total_ingredients FROM ingredient;

-- Requête 3 : Afficher le prix moyen des focaccias
SELECT ROUND(AVG(prix), 2) AS prix_moyen FROM focaccia;

-- Requête 4 : Afficher la liste des boissons avec leur marque, triée par nom de boisson
SELECT boisson.nom AS nom_boisson, marque.nom AS marque FROM boisson JOIN marque ON boisson.id_marque = marque.id_marque ORDER BY boisson.nom;

-- Requête 5 : Afficher la liste des ingrédients pour une Raclaccia
SELECT i.nom AS ingredient FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE f.nom = 'Raclaccia';

-- Requête 6 : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
SELECT f.nom AS focaccia, COUNT(c.id_ingredient) AS nb_ingredients FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia GROUP BY f.nom;

-- Requête 7 : Afficher le nom de la focaccia qui a le plus d'ingrédients
SELECT f.nom FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia GROUP BY f.nom ORDER BY COUNT(c.id_ingredient) DESC LIMIT 1;

-- Requête 8 : Afficher la liste des focaccia qui contiennent de l'ail
SELECT DISTINCT f.nom FROM focaccia f JOIN comprend c ON f.id_focaccia = c.id_focaccia JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE i.nom = 'Ail';

-- Requête 9 : Afficher la liste des ingrédients inutilisés
SELECT nom FROM ingredient WHERE id_ingredient NOT IN (SELECT DISTINCT id_ingredient FROM comprend);

-- Requête 10 : Afficher la liste des focaccia qui n'ont pas de champignons
SELECT f.nom FROM focaccia f WHERE f.id_focaccia NOT IN (SELECT DISTINCT c.id_focaccia FROM comprend c JOIN ingredient i ON c.id_ingredient = i.id_ingredient WHERE i.nom = 'Champignon');
