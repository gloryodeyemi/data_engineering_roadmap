-- Day 1 of SQL Advent Calendar
-- Today's Question:
-- A ski resort company want to know which customers rented ski equipment for more than one type of activity 
-- (e.g., skiing and snowboarding). List the customer names and the number of distinct activities they rented 
-- equipment for.

-- Table name: rentals
-- rental_id	customer_name	activity	rental_date
-- 1	Emily	Skiing	2024-01-01
-- 2	Michael	Snowboarding	2024-01-02
-- 3	Emily	Snowboarding	2024-01-03
-- 4	Sarah	Skiing	2024-01-01
-- 5	Michael	Skiing	2024-01-02
-- 6	Michael	Snowtubing	2024-01-02

CREATE TABLE rentals
(
	rental_id INTEGER,
	customer_name VARCHAR(255),
	activity VARCHAR(255),
	rental_date VARCHAR(255)
);

INSERT INTO rentals
(rental_id, customer_name, activity, rental_date)
VALUES
(1, 'Emily', 'Skiing', '2024-01-01'),
(2, 'Michael', 'Snowboarding', '2024-01-02'),
(3, 'Emily', 'Snowboarding', '2024-01-03'),
(4, 'Sarah', 'Skiing', '2024-01-01'),
(5, 'Michael', 'Skiing', '2024-01-02'),
(6, 'Michael', 'Snowtubing', '2024-01-02');

-- Solution
SELECT customer_name, COUNT(DISTINCT activity) AS no_of_activities
FROM rentals
GROUP BY customer_name
HAVING COUNT(DISTINCT activity) > 1;
