-- Day 20 of SQL Advent Calendar

-- Today's Question:
-- We are looking for cheap gifts at the market. Which vendors are selling items priced below $10? List the unique 
-- (i.e. remove duplicates) vendor names.

-- Table name: vendors
-- vendor_id	vendor_name	market_location
-- 1	Cozy Crafts	Downtown Square
-- 2	Sweet Treats	Central Park
-- 3	Winter Warmers	Downtown Square

-- Table name: item_prices
-- item_id	vendor_id	item_name	price_usd
-- 1	1	Knitted Scarf	25
-- 2	2	Hot Chocolate	5
-- 3	2	Gingerbread Cookie	3.5
-- 4	3	Wool Hat	18
-- 5	3	Santa Pin	2

SELECT DISTINCT vendor_name
FROM vendors
INNER JOIN item_prices
ON vendors.vendor_id = item_prices.vendor_id
WHERE price_usd < 10;