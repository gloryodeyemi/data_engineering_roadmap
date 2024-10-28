-- ORDER BY
SELECT * FROM customer
ORDER BY first_name ASC;

SELECT * FROM customer
ORDER BY first_name DESC;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name ASC;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;

-- LIMIT
SELECT * FROM payment
WHERE amount != 0.0
ORDER BY payment_date DESC
LIMIT 5;

-- Challenge
-- 1. What are the customer ids of the first 10 customers who created a payment?
SELECT customer_id FROM payment
WHERE amount != 0.0
ORDER BY payment_date ASC
LIMIT 10;

-- 2. What are the titles of the 5 shortest (in length of runtime) movies;
SELECT title, length FROM film
ORDER BY length ASC
LIMIT 5;

-- 3. How many movies can a customer watch that is 50 minutes or less in runtime?
SELECT COUNT(*) FROM film
WHERE length <= 50;