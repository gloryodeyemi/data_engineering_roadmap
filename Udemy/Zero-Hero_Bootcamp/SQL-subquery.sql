-- Subquery and EXISTS
-- Allows you to construct complex queries, essentially performing a query on the 
-- results of another query.
-- It is performed first because it is inside the parenthesis.
-- The IN can be used if subquery returns multiple values.

SELECT title, rental_rate
FROM film
WHERE rental_rate > (
	SELECT AVG(rental_rate)
	FROM film
);

SELECT film_id, title
FROM film
WHERE film_id IN (
	SELECT inventory.film_id 
	FROM rental
	INNER JOIN inventory
		ON inventory.inventory_id = rental.inventory_id
	WHERE return_date BETWEEN '2005-05-29' AND '2005-05-30'
)
ORDER BY film_id;

-- EXISTS
-- customers with at least one payment whose payment is more that $11.
SELECT first_name, last_name
FROM customer AS c
WHERE EXISTS (
	SELECT * FROM payment AS p
	WHERE p.customer_id = c.customer_id
	AND amount > 11
);

-- opposite
SELECT first_name, last_name
FROM customer AS c
WHERE NOT EXISTS (
	SELECT * FROM payment AS p
	WHERE p.customer_id = c.customer_id
	AND amount > 11
);