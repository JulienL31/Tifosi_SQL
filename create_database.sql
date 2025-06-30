-- Script de création de la base de données tifosi
-- Ce script crée la base, l'utilisateur et toutes les tables avec les contraintes


DROP DATABASE IF EXISTS tifosi;
CREATE DATABASE tifosi;
USE tifosi;

-- Création de l'utilisateur
DROP USER IF EXISTS 'tifosi'@'localhost';
CREATE USER 'tifosi'@'localhost' IDENTIFIED BY 'mdptifosi123';
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- Table ingredient
CREATE TABLE ingredient (
    id_ingredient INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Table focaccia
CREATE TABLE focaccia (
    id_focaccia INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE,
    prix DECIMAL(5,2) NOT NULL
);

-- Table comprend
CREATE TABLE comprend (
    id_focaccia INT,
    id_ingredient INT,
    quantite INT DEFAULT 1,
    PRIMARY KEY (id_focaccia, id_ingredient),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia) ON DELETE CASCADE,
    FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient) ON DELETE CASCADE
);

-- Table marque
CREATE TABLE marque (
    id_marque INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL UNIQUE
);

-- Table boisson
CREATE TABLE boisson (
    id_boisson INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    id_marque INT,
    FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
);

-- Table menu
CREATE TABLE menu (
    id_menu INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    prix DECIMAL(5,2) NOT NULL
);

-- Table contient (menu → boisson)
CREATE TABLE contient (
    id_menu INT,
    id_boisson INT,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
);

-- Table est_constitue (menu → focaccia)
CREATE TABLE est_constitue (
    id_menu INT,
    id_focaccia INT,
    PRIMARY KEY (id_menu, id_focaccia),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_focaccia) REFERENCES focaccia(id_focaccia)
);

-- Table client
CREATE TABLE client (
    id_client INT PRIMARY KEY,
    nom VARCHAR(50) NOT NULL,
    email VARCHAR(150) NOT NULL UNIQUE,
    code_postal INT NOT NULL
);

-- Table achete
CREATE TABLE achete (
    id_client INT,
    id_menu INT,
    date_achat DATE,
    PRIMARY KEY (id_client, id_menu, date_achat),
    FOREIGN KEY (id_client) REFERENCES client(id_client),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);
