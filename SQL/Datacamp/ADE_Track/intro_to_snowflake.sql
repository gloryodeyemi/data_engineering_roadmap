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
