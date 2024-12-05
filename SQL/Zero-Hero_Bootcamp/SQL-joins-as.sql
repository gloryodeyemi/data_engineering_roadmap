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