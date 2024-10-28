-- SELECT
SELECT * FROM actor;

SELECT first_name FROM actor;

SELECT first_name, last_name FROM actor;

SELECT * FROM city;

-- Challenge
-- Use a select statement to grab the first and last names of every customer and their email 
-- address.
SELECT first_name, last_name, email FROM customer;


-- SELECT DISTINCT
SELECT DISTINCT release_year FROM film;

SELECT DISTINCT(release_year) FROM film;

SELECT DISTINCT(rental_rate) FROM film;

-- Challenge
-- Use select distinct to retrieve the distinct rating types our films could have in our 
-- database. 
SELECT DISTINCT rating FROM film;


-- COUNT
SELECT COUNT(*) FROM payment;

SELECT COUNT(amount) FROM payment;

SELECT COUNT(DISTINCT amount) FROM payment;


-- WHERE
SELECT * FROM customer
WHERE first_name = 'Jared';

SELECT title FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R';

SELECT COUNT(title) FROM film
WHERE rental_rate > 4 AND replacement_cost >= 19.99
AND rating = 'R';

SELECT COUNT(*) FROM film
WHERE rating = 'R' OR rating = 'PG-13';

SELECT * FROM film
WHERE rating <> 'R';

-- Challenge
-- 1. What is the email of the customer with the name Nancy Thomas?
SELECT email FROM customer
WHERE first_name = 'Nancy' AND last_name = 'Thomas';

-- 2. Could you give a customer the description for the movie 'Outlaw Hanky'
SELECT description FROM film
WHERE title = 'Outlaw Hanky';

-- 3. Can you get the phone number for the customer who lives at '259 Ipoh Drive'?
SELECT phone FROM address
WHERE address = '259 Ipoh Drive';

