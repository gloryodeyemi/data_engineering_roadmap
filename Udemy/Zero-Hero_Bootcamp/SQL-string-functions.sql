-- String functions and operators

-- Length
SELECT LENGTH(first_name) FROM customer;

-- Concatenation
SELECT first_name || ' ' || last_name AS full_name
FROM customer;

SELECT UPPER(first_name) || ' ' || UPPER(last_name) AS full_name
FROM customer;

SELECT LOWER(LEFT(first_name, 1)) || '.' || lower(last_name) || '@gmail.com' AS email
FROM customer;

