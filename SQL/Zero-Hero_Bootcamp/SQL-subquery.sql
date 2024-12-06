-- Subquery and EXISTS
-- Allows you to construct complex queries, essentially performing a query on the 
-- results of another query.
-- It is performed first because it is inside the parenthesis.
-- The IN can be used.

SELECT title, rental_rate
FROM film
WHERE rental_rate > (
	SELECT AVG(rental_rate)
	FROM film
);