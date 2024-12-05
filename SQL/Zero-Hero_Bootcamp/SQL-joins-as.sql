-- AS (Alias)
-- It cannot be used in a WHERE statement or HAVING clause because they get assigned at the 
-- end.
SELECT COUNT(amount) AS num_transactions
FROM payment;

SELECT customer_id, SUM(amount) AS total_spent
FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

-- JOINS
-- allows combination of multiple tables.

-- INNER JOIN
-- returns records that matches in both tables.
SELECT payment_id, payment.customer_id, first_name 
FROM payment
INNER JOIN customer
ON payment.customer_id = customer.customer_id;

-- OUTER JOINs
-- allows us to specify how to deal with data present in only one of the tables
-- FULL OUTER JOIN, LEFT OUTER JOIN, and RIGHT OUTER JOIN

-- FULL OUTER JOIN
-- it grabs everything
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id;

-- WHERE statement filter
SELECT * FROM customer
FULL OUTER JOIN payment
ON customer.customer_id = payment.customer_id
WHERE customer.customer_id IS NULL
OR payment.customer_id IS NULL;

-- confirmation
SELECT COUNT(DISTINCT customer_id) FROM payment;
SELECT COUNT(DISTINCT customer_id) FROM customer;

-- LEFT OUTER JOIN
-- grabs data exclusive to the left table or present in both table
-- the table order matters.
-- WHERE can be used to filter values only unique to the left table, i.e., values in
-- left table but not in right table.
SELECT film.film_id, title, inventory_id, store_id
FROM film
LEFT JOIN inventory
ON inventory.film_id = film.film_id;
