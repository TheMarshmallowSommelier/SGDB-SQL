USE filminforating_PXE;

-- Ajout de l'index sur la colonne titre de la table Film
ALTER TABLE Film ADD INDEX (titre);

-- Ajout de la vue Top 10 des films
CREATE OR REPLACE VIEW top_10_films AS
SELECT f.id, f.titre, AVG(n.valeur) AS moyenne_notes
FROM Film f
JOIN Note n ON f.id = n.film_id
GROUP BY f.id, f.titre
ORDER BY moyenne_notes DESC
LIMIT 10;

-- Ajout de la vue des détails des films
CREATE OR REPLACE VIEW film_details AS
SELECT f.id, f.titre, f.date_sortie, f.duree_minutes,
 r.nom AS realisateur_nom, r.prenom AS realisateur_prenom,
 GROUP_CONCAT(g.nom) AS genres
FROM Film f
JOIN Realisateur r ON f.realisateur_id = r.id
JOIN Film_Genre fg ON f.id = fg.film_id
JOIN Genre g ON fg.genre_id = g.id
GROUP BY f.id, f.titre, f.date_sortie, f.duree_minutes, r.nom, r.prenom;

-- Ajout de la procédure stockée pour calculer le nombre d'acteurs et de réalisateurs
DELIMITER //
CREATE PROCEDURE total_acteurs_realisateurs (OUT total_acteurs INT, OUT total_realisateurs INT)
BEGIN
 SELECT COUNT(*) INTO total_acteurs FROM Acteur;
 SELECT COUNT(*) INTO total_realisateurs FROM Realisateur;
END //
DELIMITER ;

-- Ajout de la procédure stockée pour calculer la moyenne des notes pour un film donné
DELIMITER //
CREATE PROCEDURE calculer_moyenne_notes_film(IN film_id INT, OUT moyenne_notes FLOAT)
BEGIN
  DECLARE note_count INT DEFAULT 0;
  DECLARE note_sum FLOAT DEFAULT 0;
  DECLARE done INT DEFAULT FALSE;
  DECLARE note FLOAT;
  DECLARE cur CURSOR FOR SELECT valeur FROM Note WHERE film_id = film_id;
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur;
  read_loop: LOOP
    FETCH cur INTO note;
    IF done THEN
      LEAVE read_loop;
    END IF;
    SET note_sum = note_sum + note;
    SET note_count = note_count + 1;
  END LOOP;

  CLOSE cur;
  IF note_count > 0 THEN
    SET moyenne_notes = note_sum / note_count;
  ELSE
    SET moyenne_notes = 0;
  END IF;
END //
DELIMITER ;