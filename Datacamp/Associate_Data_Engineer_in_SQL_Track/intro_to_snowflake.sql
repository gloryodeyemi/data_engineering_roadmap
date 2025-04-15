-- Select pizza_type_id, pizza_size and price from pizzas table
SELECT pizza_type_id, pizza_size, price
FROM pizzas;

-- Count the total number of pizza entries in the pizza_type.
-- Filter the query to count only the pizzas that are categorized as Classic.
-- Further refine the count to include only those pizzas where the name contains the word Cheese.
SELECT COUNT(*) AS count_all_pizzas
FROM pizza_type
WHERE category = 'Classic'
    AND name LIKE '%Cheese%';

-- Select and convert the request_id column from uber_request_data table to VARCHAR using the CAST method aliasing it to request_id_string.
-- Convert request_timestamp to DATE using the TO_DATE function aliasing it as request_date.
-- Convert the drop_timestamp column to TIME using the :: operator, and alias it to drop_time.
-- Filter the records where request_date is greater than '2016-06-01' and drop_time is less than '6 AM'.
SELECT 
    CAST(request_id AS VARCHAR) AS request_id_string,
    TO_DATE(request_timestamp) AS request_date,
    drop_timestamp::TIME AS drop_time
FROM uber_request_data
WHERE request_date > '2016-06-01'
AND drop_time < '06:00:00';

-- Standardize the status entries in the uber_request_data table. Convert all entries in the status column to lowercase.
SELECT LOWER(status) FROM uber_request_data

-- Convert all entries in the pickup_point column to uppercase.
SELECT UPPER(pickup_point) FROM uber_request_data

-- Complete the CONCAT function to combine the pickup_point and status with the given comments.
SELECT CONCAT('Trip from ', pickup_point, ' was completed with status: ', status) AS trip_comment
FROM uber_request_data

-- Retrieve the order_id and pizza_id from order_details for orders where the total pizza quantity is more than 3 using the HAVING clause.
-- Group the orders using GROUP BY ALL
-- Arrange your results by order_id and then by total_quantity in a descending sequence.
SELECT order_id, pizza_id, SUM(quantity) AS total_quantity
FROM order_details
GROUP BY ALL
HAVING SUM(quantity) > 3
ORDER BY order_id DESC, total_quantity DESC;

-- Select the current date and current time using a valid date and time functions.
SELECT CURRENT_DATE, CURRENT_TIME

-- Complete the concatenation for the CURRENT_DATE and CURRENT_TIME, converting the result to TIMESTAMP.
SELECT CONCAT(CURRENT_DATE, ' ', CURRENT_TIME)::TIMESTAMP

-- Extract month from the concatenated timestamp and alias as concat_month
-- Filter records from uber_request_data where request_timestamp's month is greater or equal than concat_month.
SELECT *,
	EXTRACT(MONTH FROM CONCAT(CURRENT_DATE, ' ', CURRENT_TIME)::TIMESTAMP) AS concat_month
FROM uber_request_data
WHERE EXTRACT(month FROM request_timestamp) >= EXTRACT(MONTH FROM CONCAT(CURRENT_DATE, ' ', CURRENT_TIME)::TIMESTAMP)

-- Calculate total_revenue based on SUM of price * quantity; taking price from p (pizzas) and quantity from od (order_details) table.
-- NATURAL JOIN the pizzas and pizza_type tables.
-- GROUP the records by category from pt (pizza_type) table.
-- ORDER the details by total_revenue in descending order and LIMIT to 1 to fetch only the top revenue pizza.
SELECT 
    pt.category,
    SUM(p.price * od.quantity) total_revenue
FROM order_details AS od
NATURAL JOIN pizzas AS p 
NATURAL JOIN pizza_type AS pt
GROUP BY pt.category
ORDER BY total_revenue DESC
LIMIT 1;

-- Ensure that all orders from the orders table are included in the result, regardless of whether they have corresponding entries in the order_details table.
SELECT COUNT(o.order_id) AS total_orders
FROM orders AS o
-- Use appropriate JOIN
LEFT JOIN order_details AS od
ON o.order_id = od.order_id

-- Calculate the total revenue using price column from pizzas table and quantity column of order_details table respectively.
-- Use appropriate JOIN to include all records from the pizzas table.
SELECT COUNT(o.order_id) AS total_orders,
        AVG(p.price) AS average_price,
        SUM(p.price * od.quantity) AS total_revenue	
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
RIGHT JOIN pizzas As p
ON od.pizza_id = p.pizza_id

-- Select pizza name from pizza_type by performing a NATURAL JOIN with the pizza_type table.
SELECT COUNT(o.order_id) AS total_orders,
        AVG(p.price) AS average_price,
        SUM(p.price * od.quantity) AS total_revenue,
		pt.name AS pizza_name
FROM orders AS o
LEFT JOIN order_details AS od
ON o.order_id = od.order_id
RIGHT JOIN pizzas p
ON od.pizza_id = p.pizza_id
NATURAL JOIN pizza_type pt
GROUP BY pt.name, pt.category
ORDER BY total_revenue desc, total_orders desc

-- Complete the JOIN clauses to join the pizzas, and order_details tables appropriately.
-- Use the GROUP BY clause to group the results by name and category from the pizza_type table.
-- Fill in the subquery to find the AVG of total_quantity.
-- Order the results by total_quantity in ascending order.
SELECT 
    pt.name, 
    pt.category, 
    SUM(od.quantity) AS total_quantity
FROM pizza_type AS pt
LEFT JOIN pizzas AS pz
    ON pt.pizza_type_id = pz.pizza_type_id
RIGHT JOIN order_details AS od
    ON pz.pizza_id = od.pizza_id
-- Group by name and category
GROUP BY pt.name, pt.category
HAVING SUM(od.quantity) < (
    -- Calculate AVG of total_quantity 
    SELECT AVG(total_quantity)
    FROM (
        SELECT SUM(od2.quantity) AS total_quantity
        FROM pizzas AS pz2
        JOIN order_details AS od2
            ON pz2.pizza_id = od2.pizza_id
        GROUP BY pz2.pizza_type_id
    ) AS sub
)
-- Order  by total_quantity in ascending order
ORDER BY total_quantity;

-- Create a CTE named most_ordered and limit the results to one.
-- Create another CTE, called cheapest_pizza and filter for the cheapest pizza using a subquery to find the minimum price.
-- Complete the query to select pizza_id and total_qty aliased as metric from most_ordered CTE.
-- Include pizza_id and price aliased as metric from cheapest_pizza CTE. Note, maintain order of the columns.
-- Create a CTE named most_ordered and limit the results 
WITH most_ordered AS(
    SELECT pizza_id, SUM(quantity) AS total_qty 
    FROM order_details GROUP BY pizza_id ORDER BY total_qty DESC
    LIMIT 1
)
-- Create CTE cheapest_pizza where price is equals to min price from pizzas table
, cheapest_pizza AS(
    SELECT pizza_id, price
    FROM pizzas 
    WHERE price = (SELECT MIN(price) FROM pizzas)
    LIMIT 1
)
-- Select pizza_id and total_qty aliased as metric from first cte most_ordered
SELECT pizza_id, 'Most Ordered' AS Description, total_qty AS metric
FROM most_ordered
UNION ALL
-- Select pizza_id and price aliased as metric from second cte cheapest_pizza
SELECT pizza_id, 'Cheapest' AS Description, price AS metric
FROM cheapest_pizza

-- Use the filtered_orders CTE to select order_id and order_date from orders table, filtering to only include orders made after November 1, 2015.
-- Use the filtered_pizza_type CTE to select the name and pizza_type_id from the pizza_type table, filtering to only include pizzas in the 'Veggie' category.
-- Retrieve the records from the filtered_orders CTE.
-- Join the filtered_pizza_type CTE based on the pizza_type_id column using ON clause.
WITH filtered_orders AS (
  SELECT order_id, order_date 
  FROM orders 
  WHERE order_date > '2015-11-01'
)

, filtered_pizza_type AS (
  SELECT name, pizza_type_id 
  FROM pizza_type 
  WHERE category = 'Veggie'
)

SELECT o.order_id, o.order_date, pt.name, od.quantity
FROM filtered_orders AS o
JOIN order_details AS od ON o.order_id = od.order_id
JOIN pizzas AS p ON od.pizza_id = p.pizza_id
JOIN filtered_pizza_type AS pt ON p.pizza_type_id = pt.pizza_type_id;

-- Extract the WheelchairAccessible field from the attributes column and cast it to STRING using :: notation.
-- Extract Saturday, Sunday from hours column and cast it to STRING using :: notation.
-- Filter the query results where wheelchair_accessible is 'True' and open_on_weekend is 'true'.
-- Filter the query for categories that have 'Italian' in them.
SELECT
  name,
  categories,
  attributes:WheelchairAccessible::STRING AS wheelchair_accessible,
  (hours:Saturday::STRING IS NOT NULL OR hours:Sunday::STRING IS NOT NULL) AS open_on_weekend
FROM
  yelp_business_data
WHERE
    wheelchair_accessible = 'True' AND open_on_weekend = 'true'
    AND categories LIKE '%Italian%';

-- Create a CTE named dogs_allowed.
-- Filter businesses where the DogsAllowed attribute in the attributes column, when cast to STRING, is True.
-- From second CTE touristy_places, convert the Ambience attribute in the attributes columns into valid JSON using PARSE_JSON.
-- From the valid parsed JSON, fetch the touristy attribute and check if it is true when cast to BOOLEAN.
WITH dogs_allowed AS (
  SELECT * 
  FROM yelp_business_data
  WHERE attributes:DogsAllowed::STRING  NOT ILIKE '%None%'
  AND attributes:DogsAllowed::STRING = 'True' 
)

, touristy_places AS (
  SELECT *
  FROM yelp_business_data
  WHERE attributes:Ambience NOT ILIKE '%None%'
    AND attributes:Ambience IS NOT NULL
    AND attributes:Ambience NOT ILIKE '%u''%'
  	-- Convert Ambience attribute in the attributes columns into valid JSON using PARSE_JSON.
    -- From Valid JSON, fetch the touristy attribute and check if it is true when casted to BOOLEAN.
    AND PARSE_JSON(attributes:Ambience):touristy::BOOLEAN = true
)

SELECT
	d.business_id,
    d.name
FROM dogs_allowed d
JOIN touristy_places t
	ON d.business_id = t.business_id