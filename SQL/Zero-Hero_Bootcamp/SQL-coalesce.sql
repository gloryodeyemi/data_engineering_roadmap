-- COALESCE
-- accepts an unlimited number of arguments.
-- returns the first argument that is not null.
-- if all arguments are null, the COALESCE function will return null.
-- becomes useful when querying a table that contains null values and substituting it with another value.
SELECT title, (replacement_cost - COALESCE(rental_rate, 0)) AS cost_difference
FROM film;
