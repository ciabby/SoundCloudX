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
