
# Ma (première) DB

## Description
Ce projet a pour but de créer une base de données pour gérer des informations sur les films, les acteurs, les réalisateurs, les genres, les pays, les utilisateurs, les commentaires et les notes.

La base de données est créée et gérée grâce à Flyway. Les données sont générées aléatoirement à l'aide de Faker.js et insérées dans les tables de la base de données.

## Installation
* Installer mysql via WAMP, docker ou autres
* Cloner le projet : git clone https://github.com/votre_nom/projet_bd.git
* Installer Java (si ce n'est pas déjà fait) : https://www.java.com/fr/download/
* Installer Flyway : https://flywaydb.org/documentation/getstarted/firststeps/installation
* Installer les dépendances de Faker.js : 
    $ cd Faker.js && npm install

## Utilisation
* Créer la base de données et les tables : 
$ cd Flyway && flyway migrate
* Générer les données aléatoires et les insérer dans la base de données : 
$ cd ../Faker.js && node seed.js

Pour plus d'info voir le Recap.pdf
