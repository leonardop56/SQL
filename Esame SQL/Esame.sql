-- Creo il database ToysGroup.
CREATE DATABASE ToysGroup;

-- Seleziono il database.
USE ToysGroup;


-- Creo la tabella Category.
CREATE TABLE Category (
    CategoryID TINYINT PRIMARY KEY,
    CategoryName VARCHAR(20) NOT NULL
);

-- Inserisco dati nella tabella Category.
INSERT INTO Category (CategoryID, CategoryName) VALUES
(1, 'Building'),
(2, 'Dolls'),
(3, 'Vehicles'),
(4, 'Outdoor'),
(5, 'Arts & Crafts');


-- Creo la tabella Product.
CREATE TABLE Product (
    ProductID TINYINT AUTO_INCREMENT PRIMARY KEY,
    CategoryID TINYINT,
    ProductName VARCHAR(30),
    Size VARCHAR(20),
    AgeTarget VARCHAR(20),
    UnitPrice DECIMAL(5,2),
    FOREIGN KEY (CategoryID) REFERENCES Category(CategoryID)
);

-- Inserisco dati nella tabella Product.
INSERT INTO Product (ProductName, CategoryID, Size, AgeTarget, UnitPrice) VALUES
('Lego Classic Set', 1, 'Medium', '6-12 years', 29.99),
('Lego Technic Race Car', 1, 'Medium', '10-16 years', 49.99),
('Lego Friends Bakery', 1, 'Medium', '6-12 years', 34.99),
('Lego Star Wars X-Wing', 1, 'Large', '8-14 years', 99.99),
('Mega Bloks First Builders', 1, 'Large', '2-5 years', 19.99),
('Barbie Dreamhouse', 2, 'Large', '3-10 years', 199.99),
('Barbie Fashionista', 2, 'Small', '3-8 years', 19.99),
('Baby Alive Doll', 2, 'Medium', '2-6 years', 29.99),
('American Girl Doll', 2, 'Medium', '6-12 years', 89.99),
('Disney Princess Doll', 2, 'Medium', '3-8 years', 24.99),
('Hot Wheels Track Builder', 3, 'Large', '4-8 years', 49.99),
('RC Monster Truck', 3, 'Medium', '6-12 years', 69.99),
('Toy Fire Truck', 3, 'Large', '3-8 years', 39.99),
('Matchbox 20 Car Pack', 3, 'Small', '4-10 years', 24.99),
('Toy Construction Set', 3, 'Medium', '5-10 years', 34.99),
('Nerf Blaster Elite', 4, 'Medium', '8-15 years', 34.99),
('Frisbee Pro', 4, 'Small', '6-12 years', 9.99),
('Kickball Set', 4, 'Medium', '4-12 years', 14.99),
('Inflatable Pool', 4, 'Large', '3-10 years', 29.99),
('Soccer Ball Toy', 4, 'Medium', '6-14 years', 19.99),
('Play-Doh Starter Set', 5, 'Small', '3-7 years', 14.99),
('Crayola Marker Set', 5, 'Small', '5-10 years', 12.99),
('Paint Your Own Mug', 5, 'Medium', '8-14 years', 19.99),
('Bead Bracelet Kit', 5, 'Small', '7-12 years', 14.99),
('Origami Paper Set', 5, 'Small', '10+ years', 9.99);


-- Creo la tabella Region.
CREATE TABLE Region (
    RegionID TINYINT AUTO_INCREMENT PRIMARY KEY,
    StateProvinceName VARCHAR(30),
    CountryName VARCHAR(30)
);

-- Inserisco dati nella tabella Region.
INSERT INTO Region (StateProvinceName, CountryName) VALUES
('California', 'United States'),
('Texas', 'United States'),
('Florida', 'United States'),
('New York', 'United States'),
('Illinois', 'United States'),
('Ohio', 'United States'),
('Georgia', 'United States'),
('Pennsylvania', 'United States'),
('Michigan', 'United States'),
('North Carolina', 'United States'),
('Ontario', 'Canada'),
('British Columbia', 'Canada'),
('Quebec', 'Canada'),
('Alberta', 'Canada'),
('Manitoba', 'Canada'),
('Saskatchewan', 'Canada'),
('Nova Scotia', 'Canada'),
('Newfoundland and Labrador', 'Canada'),
('Bavaria', 'Germany'),
('Hesse', 'Germany'),
('Catalonia', 'Spain'),
('Andalusia', 'Spain'),
('Île-de-France', 'France'),
('Normandy', 'France'),
('Lombardy', 'Italy'),
('Tuscany', 'Italy'),
('Vienna', 'Austria'),
('Upper Austria', 'Austria'),
('Stockholm County', 'Sweden'),
('Scania', 'Sweden'),
('Mazovia', 'Poland'),
('Lesser Poland', 'Poland'),
('Scotland', 'United Kingdom'),
('Tokyo Metropolis', 'Japan'),
('Osaka Prefecture', 'Japan'),
('Hokkaido', 'Japan'),
('Aichi Prefecture', 'Japan'),
('Fukuoka Prefecture', 'Japan'),
('New South Wales', 'Australia'),
('Victoria', 'Australia'),
('Queensland', 'Australia'),
('Western Australia', 'Australia'),
('South Australia', 'Australia'),
('Gauteng', 'South Africa'),
('Western Cape', 'South Africa'),
('KwaZulu-Natal', 'South Africa'),
('São Paulo', 'Brazil'),
('Buenos Aires Province', 'Argentina'),
('Riyadh Province', 'Saudi Arabia'),
('Mecca Province', 'Saudi Arabia'),
('Maharashtra', 'India'),
('Karnataka', 'India'),
('West Bengal', 'India'),
('Delhi', 'India'),
('Kerala', 'India');


-- Creo la tabella Sales.
CREATE TABLE Sales (
    SalesID TINYINT AUTO_INCREMENT PRIMARY KEY,
    ProductID TINYINT NOT NULL,
    RegionID TINYINT NOT NULL,
    OrderDate DATE,
    OrderQuantity TINYINT,
    SalesAmount DECIMAL(6, 2),
    FOREIGN KEY (ProductID) REFERENCES Product(ProductID),
    FOREIGN KEY (RegionID) REFERENCES Region(RegionID)
);

-- Inserisco dati nella tabella Sales. Tutti i campi tranne SalesAmount che popolero' dopo.
INSERT INTO Sales (ProductID, RegionID, OrderDate, OrderQuantity) VALUES
(8, 4, '2023-04-15', 8),
(2, 7, '2022-06-10', 6),
(5, 3, '2021-08-01', 4),
(7, 2, '2021-11-22', 3),
(8, 8, '2023-05-17', 7),
(3, 11, '2022-02-03', 5),
(10, 6, '2021-07-19', 6),
(9, 10, '2022-03-07', 8),
(13, 9, '2023-01-12', 10),
(12, 14, '2022-12-05', 4),
(13, 13, '2021-10-22', 5),
(14, 15, '2023-03-10', 7),
(17, 17, '2022-09-29', 3),
(20, 16, '2021-12-03', 6),
(21, 18, '2023-01-17', 9),
(22, 19, '2022-06-01', 2),
(24, 22, '2021-08-26', 8),
(25, 20, '2023-02-04', 5),
(9, 23, '2022-07-13', 4),
(13, 24, '2023-05-22', 6),
(9, 25, '2022-04-18', 7),
(16, 28, '2021-09-12', 8),
(18, 29, '2023-03-28', 9),
(12, 30, '2022-11-10', 10),
(5, 31, '2021-10-05', 7),
(19, 32, '2023-02-25', 9),
(3, 33, '2021-06-19', 4),
(4, 34, '2022-05-20', 3),
(8, 35, '2023-01-30', 6),
(10, 36, '2022-10-27', 5),
(22, 37, '2021-07-03', 9),
(25, 38, '2023-04-13', 2),
(23, 39, '2022-09-01', 10),
(4, 40, '2021-11-07', 8),
(15, 41, '2023-03-22', 6),
(22, 42, '2022-02-16', 4),
(14, 43, '2021-08-19', 3),
(21, 44, '2023-05-03', 7),
(7, 45, '2022-04-22', 5),
(19, 46, '2021-09-26', 2),
(3, 47, '2023-01-29', 8),
(12, 48, '2022-07-23', 9),
(15, 49, '2021-12-17', 6),
(13, 50, '2023-02-08', 4),
(10, 51, '2022-03-24', 10),
(2, 52, '2021-11-14', 8),
(20, 53, '2023-01-04', 3),
(7, 32, '2022-08-16', 5),
(9, 7, '2021-05-31', 6),
(25, 8, '2023-02-06', 7),
(9, 2, '2022-09-27', 6),
(8, 3, '2021-08-07', 3),
(23, 4, '2023-05-05', 8),
(18, 5, '2022-02-11', 6),
(17, 6, '2021-07-04', 5),
(22, 7, '2023-03-22', 9),
(19, 8, '2021-10-11', 4),
(24, 9, '2022-08-21', 7),
(12, 10, '2021-06-23', 2),
(5, 11, '2022-12-15', 10),
(9, 12, '2021-05-18', 8),
(14, 13, '2023-04-11', 6),
(7, 14, '2021-11-05', 9),
(16, 15, '2022-01-30', 4),
(23, 16, '2023-04-19', 8),
(8, 17, '2022-02-05', 6),
(12, 18, '2021-07-13', 3),
(12, 19, '2023-05-22', 7),
(15, 20, '2022-09-17', 9),
(23, 7, '2021-11-01', 5),
(18, 22, '2023-03-13', 8),
(17, 23, '2022-01-10', 4),
(10, 24, '2021-12-28', 7),
(19, 25, '2023-02-14', 2),
(7, 26, '2022-04-03', 8),
(20, 27, '2021-08-17', 6),
(13, 28, '2023-01-06', 9),
(3, 29, '2022-11-01', 5),
(12, 30, '2021-09-23', 8),
(24, 31, '2023-04-01', 7),
(8, 32, '2022-12-09', 4),
(14, 33, '2021-06-15', 3),
(2, 34, '2023-01-12', 7),
(9, 35, '2022-10-18', 5),
(7, 36, '2021-05-02', 9),
(21, 37, '2023-04-27', 6),
(8, 38, '2022-08-28', 4),
(4, 39, '2021-10-09', 7),
(17, 40, '2023-02-01', 6),
(13, 27, '2022-07-14', 9),
(22, 42, '2021-09-04', 6),
(8, 43, '2023-03-12', 3),
(16, 44, '2022-04-25', 8),
(25, 29, '2021-11-17', 7);


-- Popolo la colonna SalesAmount. 
-- SalesAmount = OrderQuantity (from Sales) * UnitPrice (prom Product).
UPDATE Sales s
JOIN Product p ON s.ProductID = p.ProductID
SET SalesAmount = OrderQuantity * UnitPrice;


-- 1. Verificare che i campi definiti come PK siano univoci.
-- Controllo che il numero di valori distinti di ProductID e' uguale al numero toatale di valori di ProductID.
SELECT
	COUNT(DISTINCT(ProductID))
    , COUNT(ProductID)
FROM product;

-- Faccio lo stesso con le altre PK.
SELECT
	COUNT(DISTINCT(CategoryID))
    , COUNT(CategoryID)
FROM category;

SELECT
	COUNT(DISTINCT(RegionID))
    , COUNT(RegionID)
FROM region;

SELECT
	COUNT(DISTINCT(SalesID))
    , COUNT(SalesID)
FROM Sales;


-- 2. Esporre l’elenco dei soli prodotti venduti e per ognuno di questi il fatturato totale per anno.
-- Una INNER JOIN mi consente di trovare solo i prodotti venduti e poi faccio i raggruppamenti.
SELECT
	ProductName
    , YEAR(OrderDate) OrderYear
    , SUM(SalesAmount) TotalAmount
FROM product p
JOIN sales s
ON p.productid = s.productid
GROUP BY productname, YEAR(orderdate)
ORDER BY productname, YEAR(orderdate);


-- 3. Esporre il fatturato totale per stato per anno. Ordina il risultato per data e per fatturato decrescente. 
-- Anche qui faccio una INNER JOIN per considerare solo gli stati in cui c'e' stata almeno una vendita.
SELECT 
	StateProvinceName
    , Year(OrderDate) OrderYear
	, SUM(SalesAmount) TotalAmount
FROM sales s
JOIN region r
ON s.regionid = r.regionid
GROUP BY stateprovincename, YEAR(orderdate)
ORDER BY YEAR(orderdate), SUM(SalesAmount) DESC;


-- 4. Rispondere alla seguente domanda: qual è la categoria di articoli maggiormente richiesta dal mercato?
-- Nel mio database ogni transazione di vendita e' associata a un solo prodotto, ma per ogni transazione di vendita' la quantita' dello stesso prodotto puo' variare.
-- Per esempio, una transazione di vendita puo' includere 8 bambole uguali. OrderQuantity per la specifiaca bambola e' 8 in questo caso. 
-- Per trovare la categoria di articoli piu' richiesa vado a sommare le quantita' di prodotto ordinato per categoria e poi prendo il massimo. 
SELECT
	CategoryName
    , SUM(OrderQuantity) TotalSales
FROM sales s
JOIN product p
ON s.productid = p.productid
JOIN category c
ON p.categoryid = c.categoryid
GROUP BY CategoryName
ORDER BY SUM(OrderQuantity) DESC
LIMIT 1;


-- 5. Rispondere alla seguente domanda: quali sono, se ci sono, i prodotti invenduti? Proponi due approcci risolutivi differenti. 
-- Posso usare una Subquery.
SELECT 
	ProductName
FROM product p
WHERE productid NOT IN (SELECT productid FROM sales);

-- Oppure posso usare una LEFT JOIN.
SELECT 
	ProductName
FROM product p
LEFT JOIN sales s
ON p.productid = s.productid
WHERE salesid IS NULL;


-- 6. Esporre l’elenco dei prodotti con la rispettiva ultima data di vendita (la data di vendita più recente).
SELECT
	ProductName
    , MAX(OrderDate) LastSalesDate
FROM product p
JOIN sales s
ON p.productid = s.productid
GROUP BY p.productid
ORDER BY productname;

-- Se voglio elencare tutti i prodotti, anche quelli non venduti, uso un LEFT JOIN.
-- L'ultima data di vendita per i prodotti non venduti sara' NULL.
SELECT
	ProductName
    , MAX(OrderDate) LastSalesDate
FROM product p
LEFT JOIN sales s
ON p.productid = s.productid
GROUP BY p.productid
ORDER BY productname;