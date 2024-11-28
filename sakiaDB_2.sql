-- 1. Identificate tutti i clienti che non hanno effettuato nessun noleggio a gennaio 2006.
-- 1. Find all customers that didn't make any rental in January 2006.
SELECT 
	DISTINCT
    customer_id 
    , CONCAT(first_name, ' ', last_name) CustomerName
FROM customer 
WHERE customer_id NOT IN (SELECT customer_id
							FROM rental
							WHERE rental_date BETWEEN '2005-05-01' AND '2005-06-01');
 
SELECT 
	DISTINCT
    customer_id 
    , CONCAT(first_name, ' ', last_name) CustomerName
FROM customer 
WHERE customer_id NOT IN (SELECT customer_id
							FROM rental
							WHERE rental_date >= '2005-05-01' AND rental_date < '2005-06-01');

SELECT 
	DISTINCT
    customer_id 
    , CONCAT(first_name, ' ', last_name) CustomerName
FROM customer 
WHERE customer_id NOT IN (SELECT customer_id
							FROM rental
							WHERE YEAR(rental_date) = '2005' AND MONTH(rental_date) ='05');
                            


-- 2. Elencate tutti i film che sono stati noleggiati più di 10 volte nell’ultimo quarto del 2005.
-- 2. List all films rented more than 10 times in the last trimester of 2005.
-- Let's use the last semester of 2005 instead
SELECT
	title Title
    , COUNT(rental_id) TimesRented
FROM 
	film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
WHERE rental_date BETWEEN '2005-07-01' AND '2005-12-31'
GROUP BY title
HAVING COUNT(rental_id)>10;


-- 3. Trovate il numero totale di noleggi effettuati il giorno 1/1/2006.
-- 3. Find the total number of rentals made on Jan 1st, 2006.
-- I use a different date: 14/02/2006 (Feb 14th, 2006)
SELECT
	COUNT(*)
FROM rental
WHERE DATE(rental_date) = '2006-02-14';


-- 4. Calcolate la somma degli incassi generati nei weekend (sabato e domenica).
-- 4. Calcualte the total amount of sales during weekends (Saturaday and Sunday).
SELECT
	SUM(amount) AS IncassoTotWeekend
FROM payment
WHERE DAYOFWEEK(payment_date) = 6  -- Saturday
OR DAYOFWEEK(payment_date) = 1;    -- Sunday

SELECT
	dayofweek(payment_date)
    , dayname(payment_date)
FROM payment;


-- 5. Individuate il cliente che ha speso di più in noleggi.
-- 5. Find the customer that spent most in rentals.

-- 5.1 First step
-- Sum of amount per customer
SELECT 
	customer_id
    , SUM(amount) AS customer_total
FROM payment
GROUP BY customer_id;

-- 5.2 Second step
-- Max of sum of amount, using subquery to find sum of amount per customer
SELECT MAX(customer_total) AS max_total_amount
FROM(
	SELECT 
		customer_id
        , SUM(amount) AS customer_total
    FROM payment
    GROUP BY customer_id
	) AS subquery;

-- 3. Third step
-- Customer ID of customer with highest sum of amount
SELECT
	customer_id
    , SUM(amount) AS max_total_amount
FROM payment
GROUP BY customer_id
HAVING SUM(amount) = (SELECT MAX(customer_total) AS max_total_amount
					  FROM (
							SELECT customer_id, SUM(amount) AS customer_total
							FROM payment
							GROUP BY customer_id
							) AS subquery
					 );

-- 5.4 Final step
-- Customer with highest sum of amount
SELECT
	first_name
    , last_name
FROM customer c
WHERE customer_id = (SELECT customer_id
					 FROM payment
					 GROUP BY customer_id
					 HAVING SUM(amount) = (SELECT MAX(customer_total) AS max_total_amount
										   FROM (
												 SELECT customer_id, SUM(amount) AS customer_total
												 FROM payment
												 GROUP BY customer_id
												) AS subquery
										  )
					);
                    
                    
-- Easy way using ORDER BY and LIMIT to find the most sepnding customer(s)
SELECT 
	CONCAT(first_name, last_name) CustomerName
    , SUM(amount) TotalAmount
FROM customer c
LEFT JOIN payment p
ON c.customer_id = p.customer_id
GROUP BY c.customer_id
ORDER BY SUM(amount) DESC
LIMIT 3;


-- 6. Elencate i 5 film con la maggior durata di noleggio.
-- 6. List the 5 movies with the highest rental duration.
SELECT 
	title Title
    , ROUND(AVG(TIMESTAMPDIFF(SECOND, rental_date, return_date)),2) RentalLengthSeconds
    , ROUND(AVG(DATEDIFF(return_date, rental_date))) RentalLengthDays
FROM film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY title
ORDER BY AVG(TIMESTAMPDIFF(SECOND, rental_date, return_date)) DESC
LIMIT 5;


-- 7. Calcolate il tempo medio tra due noleggi consecutivi da parte di un cliente.
-- 7. Calculate the aerage time between two consecutive rentals for each client.
-- I can use a SELF-JOIN to calculate list of current rentals and previous rentals per customer
SELECT 
	r1.customer_id,
	r1.rental_date AS current_rental_date,
	MAX(r2.rental_date) AS previous_rental_date
FROM 
	rental r1
LEFT JOIN rental r2
ON r1.customer_id = r2.customer_id
WHERE r2.rental_date < r1.rental_date
GROUP BY r1.customer_id, r1.rental_date
ORDER BY r1.customer_id;

-- Use SLEF-JOIN in CTE
WITH rental_pairs AS (
	SELECT 
        r1.customer_id,
        r1.rental_date AS current_rental_date,
        MAX(r2.rental_date) AS previous_rental_date
    FROM rental r1
    LEFT JOIN rental r2
	ON r1.customer_id = r2.customer_id
	WHERE r2.rental_date < r1.rental_date
    GROUP BY 
	r1.customer_id, r1.rental_date
	)
SELECT
	first_name FirstName
    , last_name LastName
    , ROUND(AVG(DATEDIFF(current_rental_date, previous_rental_date))) AS AvgRentalIntDays
    , ROUND(AVG(TIMESTAMPDIFF(SECOND, previous_rental_date, current_rental_date)),2) AS AvgRentalIntSeconds
FROM customer c
LEFT JOIN rental_pairs rp
ON c.customer_id = rp.customer_id
GROUP BY c.customer_id
ORDER BY first_name, last_name;


-- Or I can calculate the average manually: last rental - first rental / no. of rentals
SELECT 
	CONCAT(first_name, ' ', last_name) AS CustomerName
    , ROUND(DATEDIFF(MAX(rental_date),MIN(rental_date))/COUNT(c.customer_id)) AvgRentalIntDays
    , ROUND(TIMESTAMPDIFF(SECOND, MIN(rental_date), MAX(rental_date))/COUNT(c.customer_id),2) AS AvgRentalIntSeconds
FROM customer c
LEFT JOIN rental r
ON c.customer_id = r.customer_id
GROUP BY c.customer_id
ORDER BY first_name, last_name;



-- 8. Individuate il numero di noleggi per ogni mese del 2005.
-- 8. Find the number of rentals for each month of 2005.
SELECT
	MONTHNAME(rental_date) Month
	, COUNT(rental_date) NoOfRentals
FROM rental
WHERE YEAR(rental_date) = '2005'
GROUP BY MONTHNAME(rental_date);


-- 9. Trovate i film che sono stati noleggiati almeno due volte lo stesso giorno.
-- 9. List the films that have been rented at least twice on the same day.
SELECT
	DATE(rental_date)
    , inventory_id
FROM rental
GROUP BY DATE(rental_date), inventory_id;


SELECT 
    title Title
    , DATE(rental_date) RentalDate
    , COUNT(rental_id) NoOfRentals
FROM film f
LEFT JOIN inventory i
ON f.film_id = i.film_id
LEFT JOIN rental r
ON i.inventory_id = r.inventory_id
GROUP BY DATE(rental_date), title
HAVING COUNT(rental_id)> 1;
    
  
-- 10. Calcolate il tempo medio di noleggio.
-- 10. Calculate the average rental duration.
SELECT
	ROUND(AVG(DATEDIFF(return_date, rental_date))) AvgRentalLengthDays
    , ROUND(AVG(TIMESTAMPDIFF(SECOND, rental_date, return_date)),2) AvgRentalLengthSeconds
FROM rental;