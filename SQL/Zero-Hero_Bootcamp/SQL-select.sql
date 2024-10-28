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

