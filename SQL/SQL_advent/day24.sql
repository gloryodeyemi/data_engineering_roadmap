-- Day 24 of SQL Advent Calendar

-- Today's Question:
-- Santa is tracking how many presents he delivers each night leading up to Christmas. He wants a running total to see how 
-- many gifts have been delivered so far on any given night. Using the deliveries table, calculate the cumulative sum of gifts 
-- delivered, ordered by the delivery date.

-- Table name: deliveries
-- delivery_date	gifts_delivered
-- 2024-12-20	120
-- 2024-12-21	150
-- 2024-12-22	200
-- 2024-12-23	300
-- 2024-12-24	500

-- Solution 1 - window function
SELECT
    delivery_date,
    gifts_delivered,
    SUM(gifts_delivered) OVER (ORDER BY delivery_date) AS running_total
FROM deliveries;