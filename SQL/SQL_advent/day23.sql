-- Day 23 of SQL Advent Calendar

-- Today's Question:
-- The Grinch tracked his weight every day in December to analyze how it changed daily. Write a query to return the weight 
-- change (in pounds) for each day, calculated as the difference from the previous day's weight.

-- Table name: grinch_weight_log
-- log_id	day_of_month	weight
-- 1	1	250
-- 2	2	248
-- 3	3	249
-- 4	4	247
-- 5	5	246
-- 6	6	248

-- Solution 1 - using self join
SELECT
    a.day_of_month,
    a.weight AS current_weight,
    b.weight AS previous_weight,
    a.weight - b.weight AS weight_change
FROM grinch_weight_log AS a
LEFT JOIN grinch_weight_log AS b
ON a.day_of_month = b.day_of_month + 1
ORDER BY a.day_of_month;

-- Solution 2 - using window function
