-- Create database
CREATE DATABASE Facoltativo2;

-- Select database
USE Facoltativo2;

-- Create table
CREATE TABLE Prodotti (
	IDProdotto INT PRIMARY KEY
    , NomeProdotto VARCHAR(100)
    , Prezzo DECIMAL(10,2)
    );

-- Delete table     
-- DROP TABLE store;
    
CREATE TABLE Clienti (
	IDCliente INT PRIMARY KEY
    , Nome VARCHAR(50)
    , Email VARCHAR(100)
    );
    
CREATE TABLE Ordini (
	IDOrdine INT PRIMARY KEY
    , IDProdotto INT
    , IDCliente INT
    , Quantita INT 
    , FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto)
    , FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
    );
    
CREATE TABLE DettaglioOrdini (
	IDOrdine INT
    , IDProdotto INT
    , IDCliente INT
    , PrezzoTotale DECIMAL(10,2)
    , PRIMARY KEY (IDOrdine, IDProdotto, IDCliente)
    , FOREIGN KEY (IDOrdine) REFERENCES Ordini(IDOrdine)
    , FOREIGN KEY (IDProdotto) REFERENCES Prodotti(IDProdotto)
    , FOREIGN KEY (IDCliente) REFERENCES Clienti(IDCliente)
    );
    
    
INSERT INTO Prodotti
	VALUES
    (1, 'Tablet', 300.00)
    ,(2, 'Mouse', 20.00)
    ,(3, 'Tastiera', 25.00)
    ,(4, 'Monitor', 180.00)
    ,(5, 'HHD', 90.00)
    ,(6, 'SSD', 200.00)
    ,(7, 'RAM', 100.00)
    ,(8, 'Router', 80.00)
    ,(9, 'Webcam', 45.00)
    ,(10, 'GPU', 1250.00)
    ,(11, 'Trackpad', 500.00)
    ,(12, 'Techmagazine', 5.00)
    ,(13, 'Martech', 50.00);

SELECT *
FROM Prodotti;

INSERT INTO Clienti
	VALUES
		(1, 'Antonio', null)
        ,(2, 'Battista', 'battista@mailmail.it')
        ,(3, 'Maria', 'maria@posta.it')
        ,(4, 'Franca', 'franca@lettere.it')
        ,(5, 'Ettore', null)
        ,(6, 'Arianna', 'arianna@posta.it')
        ,(7, 'Piero', 'piero@lavoro.it');

SELECT *
FROM Clienti;


INSERT INTO Ordini(IDOrdine, IDProdotto, IDCliente, Quantita)
	VALUES
		(1, 2, 1, 10)
        ,(2, 6, 3, 2)
        ,(3, 5, 4, 3)
        ,(4, 1, 2, 1)
        ,(5, 9, 7, 1)
        ,(6, 4, 7, 2)
        ,(7, 11, 6, 6)
        ,(8, 10, 3, 2)
        ,(9, 3, 5, 3)
        ,(10, 3, 1, 1)
        ,(11, 2, 2, 1);
        
SELECT *
FROM Ordini;


-- LEFT JOIN to populate PrezzoTotale
SELECT
	o.IDOrdine
    , o.IDProdotto
    , o.IDCliente
	, p.Prezzo * o.Quantita AS PrezzoTotale
FROM Ordini o
LEFT JOIN Prodotti p 
	ON o.IDProdotto = p.IDProdotto
ORDER BY IDOrdine;

-- INNER JOIN
SELECT
	o.IDOrdine
    , o.IDProdotto
    , o.IDCliente
	, p.Prezzo * o.Quantita AS PrezzoTotale
FROM Ordini o
INNER JOIN Prodotti p 
ON o.IDProdotto = p.IDProdotto
ORDER BY IDOrdine;


-- Populate DettaglioOrdini with LEFT JOIN of Ordini and Prodotti
INSERT INTO 
	DettaglioOrdini
		SELECT
			o.IDOrdine
			, o.IDProdotto
			, o.IDCliente
			, p.Prezzo * o.Quantita AS PrezzoTotale
		FROM Ordini o
		LEFT JOIN Prodotti p 
			ON o.IDProdotto = p.IDProdotto
		ORDER BY IDOrdine;
		
        
SELECT *
FROM DettaglioOrdini;