-- ORDER BY
SELECT * FROM customer
ORDER BY first_name ASC;

SELECT * FROM customer
ORDER BY first_name DESC;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id, first_name ASC;

SELECT store_id, first_name, last_name FROM customer
ORDER BY store_id DESC, first_name ASC;