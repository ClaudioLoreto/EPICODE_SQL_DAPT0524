/*W10D3 - Pratica Facoltativa 2
Esercizio 1: creazione database e tabelle.
Andiamo a creare un nuovo database all’interno del quale inseriremo alcune tabelle, definendone gli attributi, la tipologia di dato ammesso e i constraints:*/

CREATE DATABASE GestioneOrdini; -- Creazione del Database:
USE GestioneOrdini;

-- Creazione delle tabella Prodotti
CREATE TABLE Prodotti (
    IDProdotto INT PRIMARY KEY, 
    NomeProdotto VARCHAR(100) NOT NULL, 
    Prezzo DECIMAL(10, 2) NOT NULL
);

-- Creazione delle tabella Clienti
CREATE TABLE Clienti (
    IDCliente INT PRIMARY KEY, 
    Nome VARCHAR(50) NOT NULL, 
    Email VARCHAR(100) NOT NULL
);

-- Creazione delle tabella Ordini
CREATE TABLE Ordini (
    IDOrdine INT PRIMARY KEY, 
    IDProdotto INT, 
    IDCliente INT, 
    Quantità INT NOT NULL, 
    FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto), 
    FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
);

-- Creazione delle tabella DettaglioOrdini
CREATE TABLE DettaglioOrdini (
    IDOrdine INT, 
    IDProdotto INT, 
    IDCliente INT, 
    PrezzoTotale DECIMAL(10, 2),
    FOREIGN KEY (IDOrdine) REFERENCES Ordini(IDOrdine),
    FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
    FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
);

-- BONUS DEL BONUS: Possiamo creare PrezzoTotale come campo calcolato ? 
-- Creazione delle tabella DettaglioOrdini con PrezzoTotale come campo calcolato
CREATE TABLE DettaglioOrdini (
    IDOrdine INT,
    IDProdotto INT,
    IDCliente INT,
    Quantità INT,
    PrezzoTotale    DECIMAL(10, 2) -- Specifica che questa colonna può contenere valori decimali con un massimo di 10 cifre, di cui 2 dopo la virgola
                  GENERATED ALWAYS -- Indica che PrezzoTotale è una colonna calcolata che si baserà sulla successiva espressione, in questo caso la subquery
                  AS (Quantità * -- moltiplico per quantità 
                                 (SELECT Prezzo 
                                    FROM Prodotti 
                                    WHERE Prodotti.IDProdotto = DettaglioOrdini.IDProdotto))-- prende il prezzo dalla tabella Prodotti per il prodotto specifico  
                                    STORED, -- STORED indica che il risultato viene semplicemente generato al momento della query 
    FOREIGN KEY (IDOrdine) REFERENCES Ordini(IDOrdine),
    FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto),
    FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
);

/*Esercizio 2: popolare le tabelle. Popoliamo le tabelle con i seguenti dati: Prodotti*/
-- Inserimento dati nella tabella Prodotti
INSERT INTO Prodotti (IDProdotto, NomeProdotto, Prezzo)
VALUES 
(1, 'Tablet', 300.00),
(2, 'Mouse', 20.00),
(3, 'Tastiera', 25.00),
(4, 'Monitor', 180.00),
(5, 'HHD', 90.00),
(6, 'SSD', 200.00),
(7, 'RAM', 100.00),
(8, 'Router', 80.00),
(9, 'Webcam', 45.00),
(10, 'GPU', 1250.00),
(11, 'Trackpad', 500.00),
(12, 'Techmagazine', 5.00);


-- Inserimento dati nella tabella Ordini
INSERT INTO Ordini (IDOrdine, IDProdotto, Quantità)
VALUES 
(1, 2, 10),
(2, 6, 2),
(3, 5, 3),
(4, 4, 1),
(5, 9, 1),
(6, 4, 2),
(7, 11, 6),
(8, 10, 2),
(9, 3, 3),
(10, 3, 1),
(11, 2, 1);

-- Inserimento dati nella tabella Clienti
INSERT INTO Clienti (IDCliente, Nome, Email)
VALUES 
(1, 'Antonio', NULL),
(2, 'Battista', 'battista@mailmail.it'),
(3, 'Maria', 'maria@posta.it'),
(4, 'Franca', 'franca@lettere.it'),
(5, 'Ettore', NULL),
(6, 'Arianna', 'arianna@posta.it'),
(7, 'Piero', 'piero@lavoro.it');

-- BONUS: DettaglioOrdine Come inseriamo i dati all’interno di questa tabella?
-- Inserimento dati nella tabella DettaglioOrdini
INSERT INTO DettaglioOrdini (IDOrdine, IDProdotto, IDCliente, PrezzoTotale)
SELECT o.IDOrdine
       ,o.IDProdotto
       ,o.IDCliente
       ,p.Prezzo * o.Quantità AS PrezzoTotale -- questo campo è il risultato di una moltiplicazione
  FROM Ordini o
  JOIN Prodotti p ON o.IDProdotto = p.IDProdotto; -- Lego in join stretta Ordini e Prodotti, nel particolare verifico dove l'ID del Prodotto è presente in Ordini.


