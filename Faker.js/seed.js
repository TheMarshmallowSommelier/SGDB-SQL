const faker = require('faker');
const mysql = require('mysql2/promise');

const connectionConfig = {
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'filminforating_PXE',
};

async function main() {
    const connection = await mysql.createConnection(connectionConfig);

    // Génération de données pour la table Pays
    for (let i = 0; i < 10; i++) {
        const nom = faker.address.country();
        const query = 'INSERT INTO Pays (nom) VALUES (?)';
        await connection.execute(query, [nom]);
    }

    // Génération de données pour la table Realisateur
    for (let i = 0; i < 10; i++) {
        const nom = faker.name.lastName();
        const prenom = faker.name.firstName();
        const pays_id = Math.floor(Math.random() * 10) + 1;
        const query = 'INSERT INTO Realisateur (nom, prenom, pays_id) VALUES (?, ?, ?)';
        await connection.execute(query, [nom, prenom, pays_id]);
    }

    // Génération de données pour la table Genre
    const genres = ['Action', 'Comédie', 'Drame', 'Horreur', 'Science-fiction', 'Documentaire', 'Animation', 'Thriller', 'Aventure', 'Crime'];
    for (let i = 0; i < genres.length; i++) {
        const query = 'INSERT INTO Genre (nom) VALUES (?)';
        await connection.execute(query, [genres[i]]);
    }

    // Génération de données pour la table Film
    for (let i = 0; i < 20; i++) {
        const titre = faker.lorem.words(3);
        const date_sortie = faker.date.past(10);
        const duree_minutes = Math.floor(Math.random() * 180) + 60;
        const realisateur_id = Math.floor(Math.random() * 10) + 1;
        const query = 'INSERT INTO Film (titre, date_sortie, duree_minutes, realisateur_id) VALUES (?, ?, ?, ?)';
        await connection.execute(query, [titre, date_sortie, duree_minutes, realisateur_id]);
    }

    // Génération de données pour la table Acteur
    for (let i = 0; i < 50; i++) {
        const nom = faker.name.lastName();
        const prenom = faker.name.firstName();
        const date_naissance = faker.date.past(50);
        const pays_id = Math.floor(Math.random() * 10) + 1;
        const query = 'INSERT INTO Acteur (nom, prenom, date_naissance, pays_id) VALUES (?, ?, ?, ?)';
        await connection.execute(query, [nom, prenom, date_naissance, pays_id]);
    }

    // Génération de données pour la table Utilisateur
    for (let i = 0; i < 30; i++) {
        const nom = faker.name.lastName();
        const prenom = faker.name.firstName();
        const email = faker.internet.email();
        const mot_de_passe = faker.internet.password();
        const query = 'INSERT INTO Utilisateur (nom, prenom, email, mot_de_passe) VALUES (?, ?, ?, ?)';
        await connection.execute(query, [nom, prenom, email, mot_de_passe]);
    }

    // Génération de données pour la table Commentaire
    for (let i = 0; i < 100000; i++) {
        const texte = faker.lorem.sentences(3);
        const film_id = Math.floor(Math.random() * 20) + 1;
        const utilisateur_id = Math.floor(Math.random() * 30) + 1;
        const query = 'INSERT INTO Commentaire (texte, film_id, utilisateur_id) VALUES (?, ?, ?)';
        await connection.execute(query, [texte, film_id, utilisateur_id]);
    }

    // Génération de données pour la table Note
    for (let i = 0; i < 200000; i++) {
        const valeur = Math.floor(Math.random() * 5) + 1;
        const film_id = Math.floor(Math.random() * 20) + 1;
        const utilisateur_id = Math.floor(Math.random() * 30) + 1;
        const query = 'INSERT INTO Note (valeur, film_id, utilisateur_id) VALUES (?, ?, ?)';
        await connection.execute(query, [valeur, film_id, utilisateur_id]);
    }

    // Génération de données pour la table Film_Genre
    for (let i = 0; i < 50000; i++) {
        const film_id = Math.floor(Math.random() * 20) + 1;
        const genre_id = Math.floor(Math.random() * 10) + 1;
        const query = 'INSERT INTO Film_Genre (film_id, genre_id) VALUES (?, ?) ON DUPLICATE KEY UPDATE film_id=film_id';
        await connection.execute(query, [film_id, genre_id]);
    }

    // Génération de données pour la table Film_Acteur
    for (let i = 0; i < 50000; i++) {
        const film_id = Math.floor(Math.random() * 20) + 1;
        const acteur_id = Math.floor(Math.random() * 50) + 1;
        const role = faker.random.arrayElement(['PRINCIPAL', 'SECONDAIRE', 'FIGURANT']);
        const query = 'INSERT INTO Film_Acteur (film_id, acteur_id, role) VALUES (?, ?, ?) ON DUPLICATE KEY UPDATE film_id=film_id';
        await connection.execute(query, [film_id, acteur_id, role]);
    }

    console.log('Données générées avec succès !');
    await connection.end();
}

main().catch((error) => {
    console.error(error);
    process.exit(1);
});


