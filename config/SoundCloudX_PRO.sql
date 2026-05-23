DROP DATABASE IF EXISTS SoundCloudX_PRO;
CREATE DATABASE SoundCloudX_PRO;
USE SoundCloudX_PRO;

-- 1. DDL
CREATE TABLE Artisti (
    id_artista INT PRIMARY KEY AUTO_INCREMENT,
    nome_arte VARCHAR(100) NOT NULL UNIQUE,
    stato ENUM('Attivo', 'Inattivo', 'In Pausa') DEFAULT 'Attivo'
);
CREATE TABLE Utenti (
    id_utente INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    mail VARCHAR(100) NOT NULL UNIQUE,
    passwords VARCHAR(255) NOT NULL
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
    id_album INT NOT NULL,
    CONSTRAINT fk_album FOREIGN KEY (id_album) REFERENCES Album(id_album) ON DELETE CASCADE
);

