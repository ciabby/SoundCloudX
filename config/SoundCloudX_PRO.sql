DROP DATABASE IF EXISTS SoundCloudX_PRO;
CREATE DATABASE SoundCloudX_PRO;
USE SoundCloudX_PRO;

-- 1. DDL
CREATE TABLE Artisti (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
    nome_arte VARCHAR(100) NOT NULL UNIQUE,
    stato ENUM('Attivo', 'Inattivo', 'In Pausa') DEFAULT 'Attivo'
);

CREATE TABLE Album (
    id_album INT PRIMARY KEY AUTO_INCREMENT,
    titolo VARCHAR(100) NOT NULL,
    anno_uscita INT CHECK (anno_uscita > 1900),
    id_artista INT,
    CONSTRAINT fk_artista FOREIGN KEY (id_artista) REFERENCES Artisti(id_artista) ON DELETE CASCADE
);

CREATE TABLE Brani (
    id_brano INT PRIMARY KEY AUTO_INCREMENT,
    titolo_brano VARCHAR(100) NOT NULL,
    durata_sec INT CHECK (durata_sec >= 30),
    ascolti INT DEFAULT 0,
    id_album INT,
    CONSTRAINT fk_album FOREIGN KEY (id_album) REFERENCES Album(id_album) ON DELETE CASCADE
);

CREATE TABLE Playlist (
    id_playlist INT PRIMARY KEY AUTO_INCREMENT,
    nome_playlist VARCHAR(100) NOT NULL,
    visibilita ENUM('Pubblica', 'Privata') DEFAULT 'Privata'
);

CREATE TABLE Contenuto_Playlist (
    id_playlist INT,
    id_brano INT,
    posizione INT DEFAULT 1,
    PRIMARY KEY (id_playlist, id_brano), -- CHIAVE COMPOSTA
    CONSTRAINT fk_play FOREIGN KEY (id_playlist) REFERENCES Playlist(id_playlist) ON DELETE CASCADE,
    CONSTRAINT fk_brano FOREIGN KEY (id_brano) REFERENCES Brani(id_brano) ON DELETE CASCADE
);

-- 2. ALTER TABLE
ALTER TABLE Artisti ADD COLUMN nazione VARCHAR(50);
ALTER TABLE Brani CHANGE titolo_brano nome_canzone VARCHAR(100);
ALTER TABLE Artisti ADD COLUMN email VARCHAR(100) UNIQUE;
ALTER TABLE Artisti ADD COLUMN biografia VARCHAR(255);
ALTER TABLE Artisti MODIFY biografia TEXT;

-- 3. DML (Esempi)
UPDATE Brani SET ascolti = ascolti * 1.10 WHERE ascolti > 10000;
UPDATE Artisti SET stato = 'In Pausa' WHERE nazione = 'Giappone';
DELETE FROM Playlist WHERE id_playlist = 5;
DELETE FROM Brani WHERE durata_sec < 60;

-- 4. SELECT
SELECT DISTINCT nazione FROM Artisti;
SELECT * FROM Brani ORDER BY durata_sec DESC;
SELECT * FROM Artisti WHERE nome_arte LIKE '%Dj%';
SELECT * FROM Album WHERE anno_uscita BETWEEN 2010 AND 2020;
SELECT * FROM Brani WHERE id_album IN (2, 4, 7);
SELECT * FROM Brani WHERE id_album IS NULL;
SELECT * FROM Brani WHERE ascolti > 50000;
SELECT * FROM Artisti WHERE nazione = 'Italia' AND stato = 'Attivo';
SELECT * FROM Brani WHERE durata_sec < 120 OR ascolti = 0;
SELECT * FROM Artisti ORDER BY LENGTH(nome_arte) DESC LIMIT 3;

- ==========================================================
-- FASE 5: ANALISI AVANZATA (LE 10 QUERY RICHIESTE)
-- ==========================================================

-- 1. Join Semplice (Canzone + Album)
SELECT B.nome_canzone, A.titolo AS nome_album 
FROM Brani B 
JOIN Album A ON B.id_album = A.id_album;

-- 2. Conteggio Globale
SELECT COUNT(*) AS totale_brani_piattaforma FROM Brani;

-- 3. Top Artist (Aggregazione su 3 tabelle: Artisti -> Album -> Brani)
SELECT AR.nome_arte, SUM(B.ascolti) AS ascolti_totali
FROM Artisti AR
JOIN Album AL ON AR.id_artista = AL.id_artista
JOIN Brani B ON AL.id_album = B.id_album
GROUP BY AR.nome_arte;

-- 4. Media Durata per Album
SELECT id_album, AVG(durata_sec) FROM Brani GROUP BY id_album;

-- 5. Playlist Report (Triple Join: Playlist -> Contenuto -> Brani)
SELECT P.nome_playlist, B.nome_canzone, CP.posizione
FROM Playlist P
JOIN Contenuto_Playlist CP ON P.id_playlist = CP.id_playlist
JOIN Brani B ON CP.id_brano = B.id_brano;

-- 6. Album Explorer (Conteggio brani per album)
SELECT A.titolo, COUNT(B.id_brano) AS num_canzoni
FROM Album A
LEFT JOIN Brani B ON A.id_album = B.id_album
GROUP BY A.titolo
ORDER BY num_canzoni DESC;

-- 7. GROUP BY + HAVING (Artisti prolifici)
SELECT id_artista, COUNT(id_album) 
FROM Album 
GROUP BY id_artista 
HAVING COUNT(id_album) >= 1; -- Inserito 1 per test, nella traccia è 5

-- 8. Top 5 Brani (Join + Limit)
SELECT AR.nome_arte, B.nome_canzone, B.ascolti
FROM Brani B
JOIN Album AL ON B.id_album = AL.id_album
JOIN Artisti AR ON AL.id_artista = AR.id_artista
ORDER BY B.ascolti DESC
LIMIT 5;

-- 9. Playlist Affollate (Having)
SELECT id_playlist, COUNT(id_brano) 
FROM Contenuto_Playlist 
GROUP BY id_playlist 
HAVING COUNT(id_brano) > 10;

-- 10. Statistiche Avanzate (Max durata con filtro Having)
SELECT AR.nome_arte, MAX(B.durata_sec) AS brano_piu_lungo
FROM Artisti AR
JOIN Album AL ON AR.id_artista = AL.id_artista
JOIN Brani B ON AL.id_album = B.id_album
GROUP BY AR.nome_arte
HAVING brano_piu_lungo > 300;