-- Day 16 of SQL Advent Calendar

-- Today's Question:
-- As the owner of a candy store, you want to understand which of your products are selling best. Write a query to calculate the total revenue generated from each candy category.

-- Table name: candy_sales
-- sale_id	candy_name	quantity_sold	price_per_unit	category
-- 1	Candy Cane	20	1.5	Sweets
-- 2	Chocolate Bar	10	2	Chocolate
-- 3	Lollipop	5	0.75	Sweets
-- 4	Dark Chocolate Truffle	8	2.5	Chocolate
-- 5	Gummy Bears	15	1.2	Sweets
-- 6	Chocolate Fudge	12	3	Chocolate

-- Solution
SELECT
    category,
    SUM(quantity_sold * price_per_unit) AS total_revenue
FROM candy_sales
GROUP BY category;