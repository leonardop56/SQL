-- 1. Effettuate un’esplorazione preliminare del database. Di cosa si tratta?
-- 1. Explore the sakila database. 
-- Use the database and list the colums of a few tabs
USE sakila;

SELECT *
FROM staff;

SELECT *
FROM inventory;


-- 2. Scoprite quanti clienti si sono registrati nel 2006.
-- 2. How many customers registered in 2006?
SELECT create_date
FROM customer;

SELECT COUNT(*)
FROM customer
WHERE DATE(create_date) = '2006-02-14';

SELECT COUNT(*)
FROM customer
WHERE YEAR(create_date) = '2006';


-- 3. Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.
-- 3. Find the total number of rentals on Jan 1st, 2006.
-- I use a different date: 14/02/2006 (Feb 14th, 2006)
SELECT COUNT(*)
FROM rental
WHERE DATE(rental_date) = '2006-02-14';


-- 4. Elencate tutti i film noleggiati nell’ultima settimana e tutte le informazioni legate al cliente che li ha noleggiati.
-- 4. Lisat all films rented in the last (available) week and all the info related to the customer.
SELECT
	MAX(rental_date)
    , ADDDATE(MAX(rental_date), INTERVAL -7 DAY)
FROM rental;

SELECT
	rental_date
FROM rental
HAVING rental_date <= (SELECT MAX(rental_date) FROM rental)
ORDER BY rental_date DESC;


SELECT
	Title
    , rental_date RentalDate
--    , first_name CustomerName
--    , last_name CustomerLastName
    , CONCAT(first_name, ' ', last_name) Name
    , email CustomerEmail 
FROM 
	film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
LEFT JOIN customer c
ON r.customer_id = c.customer_id
WHERE rental_date > (SELECT ADDDATE(MAX(rental_date), INTERVAL -7 DAY) FROM rental)
AND rental_date <= (SELECT MAX(rental_date) FROM rental)
ORDER BY rental_date DESC;


-- 5. Calcolate la durata media del noleggio per ogni categoria film.
-- 5. Calculate the average rental duration for each film category.
SELECT 
	c.name Category
    , ROUND(AVG(DATEDIFF(return_date, rental_date))) AvgRenatlDurationDays
    , ROUND(AVG(TIMESTAMPDIFF(SECOND, rental_date, return_date)),2) AvgRentalDurationSeconds
FROM category c
LEFT JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN inventory i
ON fc.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY c.name;

	
SELECT
	c.name Category
    , ROUND(AVG(DATEDIFF(return_date, rental_date)),2) AverageRentalDurationInDays
    , ROUND(AVG(TIMESTAMPDIFF(HOUR, rental_date, return_date)),2) AverageRentalDurationInHours
FROM
    category c
LEFT JOIN film_category fc
ON c.category_id = fc.category_id
LEFT JOIN inventory i
ON fc.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY c.category_id;



-- 6. Trovate la durata del noleggio piu' lungo.
-- 6. Find the longest rental (longest rental duration).
SELECT	
	Title
    , CONCAT(first_name, ' ', last_name) CustomerName
    , DATEDIFF(return_date, rental_date) MaxRentalinDays
    , TIMESTAMPDIFF(SECOND, rental_date, return_date) MaxRentalInSeconds
FROM film f
JOIN inventory i
ON f.film_id = i.film_id
JOIN rental r
ON i.inventory_id = r.inventory_id
JOIN customer c
ON r.customer_id = c.customer_id
AND DATEDIFF(return_date, rental_date) = (SELECT MAX(DATEDIFF(return_date, rental_date)) FROM rental);