CREATE DATABASE filminforating_PXE;
USE filminforating_PXE;

CREATE TABLE Pays (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

CREATE TABLE Realisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    pays_id INT,
    FOREIGN KEY (pays_id) REFERENCES Pays(id)
);

CREATE TABLE Genre (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL
);

CREATE TABLE Film (
    id INT AUTO_INCREMENT PRIMARY KEY,
    titre VARCHAR(255) NOT NULL,
    date_sortie DATE,
    duree_minutes INT,
    realisateur_id INT,
    FOREIGN KEY (realisateur_id) REFERENCES Realisateur(id)
);

CREATE TABLE Acteur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    date_naissance DATE,
    pays_id INT,
    FOREIGN KEY (pays_id) REFERENCES Pays(id)
);

CREATE TABLE Utilisateur (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nom VARCHAR(255) NOT NULL,
    prenom VARCHAR(255) NOT NULL,
    email VARCHAR(191) UNIQUE NOT NULL,
    mot_de_passe VARCHAR(255) NOT NULL
);

CREATE TABLE Commentaire (
    id INT AUTO_INCREMENT PRIMARY KEY,
    texte TEXT NOT NULL,
    date_creation TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    film_id INT,
    utilisateur_id INT,
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id)
);

CREATE TABLE Note (
    id INT AUTO_INCREMENT PRIMARY KEY,
    valeur ENUM('1', '2', '3', '4', '5') NOT NULL,
    film_id INT,
    utilisateur_id INT,
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (utilisateur_id) REFERENCES Utilisateur(id)
);

CREATE TABLE Film_Genre (
    film_id INT,
    genre_id INT,
    PRIMARY KEY (film_id, genre_id),
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (genre_id) REFERENCES Genre(id)
);

CREATE TABLE Film_Acteur (
    film_id INT,
    acteur_id INT,
    role ENUM('PRINCIPAL', 'SECONDAIRE', 'FIGURANT') NOT NULL,
    PRIMARY KEY (film_id, acteur_id),
    FOREIGN KEY (film_id) REFERENCES Film(id),
    FOREIGN KEY (acteur_id) REFERENCES Acteur(id)
);
