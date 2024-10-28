-- BETWEEN
SELECT * FROM payment
WHERE amount BETWEEN 8 AND 9;

SELECT COUNT(*) FROM payment
WHERE amount NOT BETWEEN 8 AND 9;

SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-14'; 
-- between when used with timestamp only goes up to the 00:00 hour mark and not 24 hour mark, so
-- make sure to extend the date to the next day like below.
SELECT * FROM payment
WHERE payment_date BETWEEN '2007-02-01' AND '2007-02-15';

-- IN
SELECT * FROM payment
WHERE amount in (0.99, 1.98, 1.99);

SELECT COUNT(*) FROM payment
WHERE amount NOT IN (0.99, 1.98, 1.99);

SELECT * FROM customer
WHERE first_name IN ('John', 'Jake', 'Julie');