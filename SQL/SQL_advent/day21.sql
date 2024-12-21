-- Day 21 of SQL Advent Calendar

-- Today's Question:
-- Santa needs to optimize his sleigh for Christmas deliveries. Write a query to calculate the total weight of gifts for each 
-- recipient type (good or naughty) and determine what percentage of the total weight is allocated to each type. Include the 
-- recipient_type, total_weight, and weight_percentage in the result.

-- Table name: gifts
-- gift_id	gift_name	recipient_type	weight_kg
-- 1	Toy Train	good	2.5
-- 2	Lumps of Coal	naughty	1.5
-- 3	Teddy Bear	good	1.2
-- 4	Chocolate Bar	good	0.3
-- 5	Board Game	naughty	1.8

SELECT 
    recipient_type,
    SUM(weight_kg) AS total_weight,
    ROUND(SUM(weight_kg) * 100.0 / (SELECT SUM(weight_kg) FROM gifts), 2) AS weight_percentage
FROM gifts
GROUP BY recipient_type;