/*W10D3 - Pratica Facoltativa 2 */

CREATE DATABASE GestioneStore; -- Creazione del Database:
USE GestioneStore;

-- Creazione delle tabella STORE
CREATE TABLE STORE (
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    CodiceStore INT,
    IndirizzoFisico VARCHAR(100),
    NumeroTelefono VARCHAR(20)
);

-- Creazione delle tabella IMPIEGATO
CREATE TABLE IMPIEGATO (
    Id INT AUTO_INCREMENT PRIMARY KEY, 
    CodiceFiscale VARCHAR(16) PRIMARY KEY,
    Nome VARCHAR(50),
    TitoloStudio VARCHAR(100),
    Recapito VARCHAR(100)
);

-- Creazione delle tabella SERVIZIO_IMPIEGATO
CREATE TABLE SERVIZIO_IMPIEGATO (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    CodiceFiscale VARCHAR(16),
    CodiceStore INT,
    DataInizio DATE,
    DataFine DATE,
    Carica VARCHAR(50),
    IdImpiegato INT,
    IdStore INT,
    FOREIGN KEY (IdImpiegato) REFERENCES IMPIEGATO(Id),
    FOREIGN KEY (IdStore) REFERENCES STORE(Id)
);

-- Creazione delle tabella SERVIZIO_IMPIEGATO
CREATE TABLE VIDEOGIOCO (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    Titolo VARCHAR(100) PRIMARY KEY,
    Sviluppatore VARCHAR(50),
    AnnoDistribuzione DATE,
    CostoAcquisto DECIMAL(5,2),
    Genere VARCHAR(50),
    RemakeDi VARCHAR(100)
);

-- Popolamento della tabella STORE
INSERT INTO STORE (CodiceStore, IndirizzoFisico, NumeroTelefono) VALUES
(1, 'Via Roma 123, Milano', '+39 02 1234567'),
(2, 'Corso Italia 456, Roma', '+39 06 7654321'),
(3, 'Piazza San Marco 789, Venezia', '+39 041 9876543'),
(4, 'Viale degli Ulivi 234, Napoli', '+39 081 3456789'),
(5, 'Via Torino 567, Torino', '+39 011 8765432'),
(6, 'Corso Vittorio Emanuele 890, Firenze', '+39 055 2345678'),
(7, 'Piazza del Duomo 123, Bologna', '+39 051 8765432'),
(8, 'Via Garibaldi 456, Genova', '+39 010 2345678'),
(9, 'Lungarno Mediceo 789, Pisa', '+39 050 8765432'),
(10, 'Corso Cavour 101, Palermo', '+39 091 12345678');

-- Popolamento della tabella IMPIEGATO
INSERT INTO IMPIEGATO (CodiceFiscale, Nome, TitoloStudio, Recapito) VALUES
('ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com'),
('DEF67890XYZ12345', 'Anna Verdi', 'Diploma di Ragioneria', 'anna.verdi@email.com'),
('GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com'),
('JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com'),
('MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com'),
('PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com'),
('STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com'),
('VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com'),
('YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com'),
('BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@email.com');

-- Popolamento della tabella SERVIZIO_IMPIEGATO
INSERT INTO SERVIZIO_IMPIEGATO (CodiceFiscale, CodiceStore, DataInizio, DataFine, Carica, IdImpiegato, IdStore) VALUES
('ABC12345XYZ67890', 1, '2023-01-01', '2023-12-31', 'Cassiere', 1, 1),
('DEF67890XYZ12345', 2, '2023-02-01', '2023-11-30', 'Commesso', 2, 2),
('GHI12345XYZ67890', 3, '2023-03-01', '2023-10-31', 'Magazziniere', 3, 3),
('JKL67890XYZ12345', 4, '2023-04-01', '2023-09-30', 'Addetto alle vendite', 4, 4),
('MNO12345XYZ67890', 5, '2023-05-01', '2023-08-31', 'Addetto alle pulizie', 5, 5),
('PQR67890XYZ12345', 6, '2023-06-01', '2023-07-31', 'Commesso', 6, 6),
('STU12345XYZ67890', 7, '2023-07-01', '2023-06-30', 'Commesso', 7, 7),
('VWX67890XYZ12345', 8, '2023-08-01', '2023-05-31', 'Cassiere', 8, 8),
('YZA12345XYZ67890', 9, '2023-09-01', '2023-04-30', 'Cassiere', 9, 9),
('BCD67890XYZ12345', 10, '2023-10-01', '2023-03-31', 'Cassiere', 10, 10);

-- Popolamento della tabella VIDEOGIOCO
INSERT INTO VIDEOGIOCO (Titolo, Sviluppatore, AnnoDistribuzione, CostoAcquisto, Genere, RemakeDi) VALUES
('Fifa 2023', 'EA Sports', '2023-01-01', 49.99, 'Calcio', NULL),
('Assassin''s Creed: Valhalla', 'Ubisoft', '2020-01-01', 59.99, 'Action', NULL),
('Super Mario Odyssey', 'Nintendo', '2017-01-01', 39.99, 'Platform', NULL),
('The Last of Us Part II', 'Naughty Dog', '2020-01-01', 69.99, 'Action', NULL),
('Cyberpunk 2077', 'CD Projekt Red', '2020-01-01', 49.99, 'RPG', NULL),
('Animal Crossing: New Horizons', 'Nintendo', '2020-01-01', 54.99, 'Simulation', NULL),
('Call of Duty: Warzone', 'Infinity Ward', '2020-01-01', 0.00, 'FPS', NULL),
('The Legend of Zelda: Breath of the Wild', 'Nintendo', '2017-01-01', 59.99, 'Action-Adventure', NULL),
('Fortnite', 'Epic Games', '2017-01-01', 0.00, 'Battle Royale', NULL),
('Red Dead Redemption 2', 'Rockstar Games', '2018-01-01', 39.99, 'Action-Adventure', NULL);

-- COLLOCAZIONE VIDEOGIOCO: Esercizio DDL e DML Create questa relazione utilizzando i dati estratti dalle tabelle precedenti.
-- Creazione delle tabella COLLOCAZIONE_VIDEOGIOCO
CREATE TABLE COLLOCAZIONE_VIDEOGIOCO (
    Id INT AUTO_INCREMENT PRIMARY KEY,
    CodiceStore INT,
    Titolo VARCHAR(100),
    IdImpiegato INT,
    IdVideogioco INT,
    FOREIGN KEY (IdImpiegato) REFERENCES IMPIEGATO(Id),
    FOREIGN KEY (IdVideogioco) REFERENCES VIDEOGIOCO(Id)
);

-- Popolamento della tabella COLLOCAZIONE_VIDEOGIOCO
INSERT INTO COLLOCAZIONE_VIDEOGIOCO (CodiceStore, Titolo, IdImpiegato, IdVideogioco) VALUES
(1, 'Fifa 2023', 1, 1),
(1, 'Assassin\'s Creed: Valhalla', 2, 2),
(2, 'Super Mario Odyssey', 3, 3),
(3, 'The Last of Us Part II', 4, 4),
(4, 'Cyberpunk 2077', 5, 5),
(5, 'Animal Crossing: New Horizons', 6, 6),
(6, 'Call of Duty: Warzone', 7, 7),
(7, 'The Legend of Zelda: Breath of the Wild', 8, 8),
(8, 'Fortnite', 9, 9),
(9, 'Red Dead Redemption 2', 10, 10);
