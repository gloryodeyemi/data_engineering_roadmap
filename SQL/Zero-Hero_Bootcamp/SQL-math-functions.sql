-- Mathematical Functions and Operators

-- Percentage of replacement cost that is the rental rate.
SELECT ROUND(rental_rate/replacement_cost, 4)*100 AS percent_cost
FROM film;

-- Calculate 10% deposit of replacement cost
SELECT 0.1 * replacement_cost AS deposit
FROM film;

