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
