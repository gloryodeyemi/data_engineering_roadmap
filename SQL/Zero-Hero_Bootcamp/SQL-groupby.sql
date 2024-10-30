-- AGGREGATE FUNCTIONS
-- AVG(), COUNT(), MAX(), MIN(), SUM()
-- Happens only in the SELECT or HAVING clause
SELECT MIN(replacement_cost) FROM film;

SELECT MAX(replacement_cost) FROM film;

SELECT MAX(replacement_cost), MIN(replacement_cost) FROM film;

SELECT COUNT(*) FROM film;

SELECT ROUND(AVG(replacement_cost), 2) FROM film;

SELECT SUM(replacement_cost) FROM film;

-- GROUP BY
-- Must appear right after a FROM or WHERE statement
-- Column selected must appear in the group by clause except if it has an aggregate function.
-- WHERE statement should not refer to the aggregation result.
-- Sorting result based on aggregate must reference the entire function
SELECT customer_id FROM payment
GROUP BY customer_id
ORDER BY customer_id;

-- What customer is spending the most money in total?
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC;

-- How many transactions per customer
SELECT customer_id, COUNT(amount) FROM payment
GROUP BY customer_id
ORDER BY COUNT(amount) DESC;

SELECT customer_id, staff_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY customer_id;

SELECT staff_id, customer_id, SUM(amount) FROM payment
GROUP BY staff_id, customer_id
ORDER BY staff_id, customer_id;

SELECT DATE(payment_date), SUM(amount) FROM payment
GROUP BY DATE(payment_date)
ORDER BY SUM(amount) DESC;

-- Challenge
-- How many payments did each staff member handle and who gets the bonus?
SELECT staff_id, COUNT(amount) FROM payment
GROUP BY staff_id
ORDER BY COUNT(amount) DESC;
-- Staff 2 gets the bonus with 7,304 total payments handled.

-- What is the average replacement cost per MPAA rating?
SELECT rating, ROUND(AVG(replacement_cost), 2)
FROM film
GROUP BY rating;

-- What are the customer ids of the top 5 customers by total spend;
SELECT customer_id, SUM(amount)
FROM payment
GROUP BY customer_id
ORDER BY SUM(amount) DESC
LIMIT 5;