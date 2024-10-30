-- HAVING
-- allows filtering after aggregation has taken place, i.e., it comes after a group by.
SELECT customer_id, SUM(amount) FROM payment
GROUP BY customer_id
HAVING SUM(amount) > 100;

SELECT store_id, COUNT(customer_id) FROM customer
GROUP BY store_id
HAVING COUNT(customer_id) > 300;

-- Challenges
-- We want to assign platinum status to customers that have had 40 or more transactions payments.
-- What customer_ids are eligible for platinum status?
SELECT customer_id, COUNT(*) FROM payment
GROUP BY customer_id
HAVING COUNT(*) >= 40;

-- What are the customer_ids of customers who have spent more than $100 in payment transaction
-- with out staff_id member 2?
SELECT customer_id, staff_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id, staff_id
HAVING SUM(amount) > 100;
-- or
SELECT customer_id, SUM(amount) FROM payment
WHERE staff_id = 2
GROUP BY customer_id
HAVING SUM(amount) > 100;