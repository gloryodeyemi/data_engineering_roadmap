-- COALESCE
-- accepts an unlimited number of arguments.
-- returns the first argument that is not null.
-- if all arguments are null, the COALESCE function will return null.
-- becomes useful when querying a table that contains null values and substituting it with another value.
SELECT title, (replacement_cost - COALESCE(rental_rate, 0)) AS cost_difference
FROM film;

-- CAST
-- convert one data type into another
SELECT CAST('5' AS INTEGER);
SELECT '5'::INTEGER; -- Postgres
-- SELECT CAST(date AS TIMESTAMP) FROM TABLE

SELECT CHAR_LENGTH(CAST(inventory_id AS VARCHAR))
FROM rental;