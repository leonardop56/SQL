-- Create database
CREATE DATABASE VideoStore;

-- Select the created database
USE VideoStore;

-- Create table
CREATE TABLE STORE (
	CodiceStore TINYINT PRIMARY KEY
    , IndirizzoFisico VARCHAR(50)
    , NumeroTelefono VARCHAR(20)
    );

-- Insert values in first row    
INSERT INTO STORE
	VALUES (1, 'Via Roma 123, Milano', '+39 02 1234567');
    
SELECT *
FROM STORE;

-- Populate values in table STORE
INSERT INTO STORE
	VALUES 
		(2, 'Corso Italia 456', '+39 06 7654321')
        ,(3, 'Roma Piazza San Marco 789 Venezia','+39 041 9876543')
	    ,(4, 'Viale degli Ulivi 234, Napoli','+39 081 3456789') 
        ,(5, 'Via Torino 567, Torino','+39 011 8765432')
        ,(6, 'Corso Vittorio Emanuele 890, Firenze','+39 055 2345678')
        ,(7, 'Piazza del Duomo 123, Bologna','+39 051 8765432')
        ,(8, 'Via Garibaldi 456, Genova','+39 051 8765432')
        ,(9, 'Lungarno Mediceo 789, Pisa','+39 051 8765432')
        ,(10, 'Corso Cavour 101, Palermo','+39 051 8765432');
        
-- Update values in specific row of table STORE        
UPDATE STORE SET NumeroTelefono='+39 010 2345678' WHERE CodiceStore=8;
UPDATE STORE SET NumeroTelefono='+39 050 8765432' WHERE CodiceStore=9;
UPDATE STORE SET NumeroTelefono='+39 091 2345678' WHERE CodiceStore=10;
          
-- Delete rows with conditional clause
-- DELETE FROM STORE WHERE CodiceStore > 1;

CREATE TABLE IMPIEGATO (
	CodiceFiscale CHAR(16) PRIMARY KEY
    , Nome VARCHAR(30)
    , TitoloStudio VARCHAR(30)
    , Recapito VARCHAR(30)
    -- , CONSTRAINT PK_IMPIEGATO PRIMARY KEY (CodiceFiscale)
    );


SELECT *
FROM IMPIEGATO;

INSERT INTO IMPIEGATO
	VALUES 
		('ABC12345XYZ67890', 'Mario Rossi', 'Laurea in Economia', 'mario.rossi@email.com')
        ,('DEF67890XYZ12345', 'Anna Verdi','Diploma di Ragioneria', 'anna.verdi@email.com')
	    ,('GHI12345XYZ67890', 'Luigi Bianchi', 'Laurea in Informatica', 'luigi.bianchi@email.com') 
        ,('JKL67890XYZ12345', 'Laura Neri', 'Laurea in Lingue', 'laura.neri@email.com')
        ,('MNO12345XYZ67890', 'Andrea Moretti', 'Diploma di Geometra', 'andrea.moretti@email.com')
        ,('PQR67890XYZ12345', 'Giulia Ferrara', 'Laurea in Psicologia', 'giulia.ferrara@email.com')
        ,('STU12345XYZ67890', 'Marco Esposito', 'Diploma di Elettronica', 'marco.esposito@email.com')
        ,('VWX67890XYZ12345', 'Sara Romano', 'Laurea in Giurisprudenza', 'sara.romano@email.com')
        ,('YZA12345XYZ67890', 'Roberto De Luca', 'Diploma di Informatica', 'roberto.deluca@email.com')
        ,('BCD67890XYZ12345', 'Elena Santoro', 'Laurea in Lettere', 'elena.santoro@email.com');
        

CREATE TABLE SERVIZIO_IMPIEGATO (
	CodiceFiscale CHAR(16)
    , CodiceStore TINYINT
    , DataInizio DATE
    , DataFine DATE
    , Carica VARCHAR(20)
    , CONSTRAINT PK_SI PRIMARY KEY (CodiceFiscale, CodiceStore, DataInizio)
    , CONSTRAINT FK_Impiegato FOREIGN KEY (CodiceFiscale) REFERENCES IMPIEGATO(CodiceFiscale)
    , CONSTRAINT FK_Store FOREIGN KEY (CodiceStore) REFERENCES STORE(CodiceStore)
    );
    
    
INSERT INTO SERVIZIO_IMPIEGATO
	VALUES 
		('ABC12345XYZ67890', '1', '2023-01-01', '2023-12-31', 'Cassiere')
        ,('DEF67890XYZ12345', '2', '2023-02-01', '2024-01-30', 'Commesso')
	    ,('GHI12345XYZ67890', '3', '2023-03-01', '2024-02-26', 'Magazziniere') 
        ,('JKL67890XYZ12345', '4', '2023-04-01', '2024-03-31', 'Addetto alle vendite')
        ,('MNO12345XYZ67890', '5', '2023-05-01', '2024-04-30', 'Addetto alle pulizie')
        ,('PQR67890XYZ12345', '6', '2023-06-01', '2024-05-31', 'Commesso')
        ,('STU12345XYZ67890', '7', '2023-07-01', '2024-06-30', 'Commesso')
        ,('VWX67890XYZ12345', '8', '2023-08-01', '2024-07-29', 'Cassiere')
        ,('YZA12345XYZ67890', '9', '2023-09-01', '2024-08-31', 'Cassiere')
        ,('BCD67890XYZ12345', '10', '2023-10-01', '2024-09-30', 'Cassiere');
        
SELECT *
FROM SERVIZIO_IMPIEGATO;


CREATE TABLE VIDEOGIOCO (
	Titolo VARCHAR(50)
    , Sviluppatore VARCHAR(20)
    , AnnoDistribuzione DATE
    , CostoAcqiusto DECIMAL(5,2)
    , Genere VARCHAR(20)
    , RemakeDi VARCHAR(50) NULL
    , CONSTRAINT PK_Videogioco PRIMARY KEY (Titolo, Sviluppatore)
    );
    
    
INSERT INTO VIDEOGIOCO
	VALUES
		('Fifa 2023', 'EA Sports', '2023-01-01', 49.99, 'Calcio', null)           
        ,('Assassin\'s Creed: Valhalla', 'Ubisoft', '2020-01-01', 59.99, 'Action', null)
        ,('Super Mario Odyssey', 'Nintendo',  '2017-01-01', 39.99, 'Platform', null)
        ,('The Last of Us Part II', 'Naughty Dog', '2020-01-01', 69.99, 'Action', null)  
        ,('Cyberpunk 2077', 'CD Projekt Red', '2020-01-01', 49.99, 'RPG', null)
        ,('Animal Crossing: New Horizons', 'Nintendo', '2020-01-01', 54.99, 'Simulation', null)
        ,('Call of Duty: Warzone', 'Infinity Ward', '2020-01-01', 0.00, 'FPS', null)
        ,('The Legend of Zelda: Breath of the Wild', 'Nintendo', '2017-01-01', 59.99, 'Action-Adventure', null)
        ,('Fortnite', 'Epic Games', '2017-01-01', 0.00, 'Battle Royale', null)
        ,('Red Dead Redemption 2', 'Rockstar Games', '2018-01-01', 39.99, 'Action-Adventure', null);
        
SELECT *
FROM VIDEOGIOCO;