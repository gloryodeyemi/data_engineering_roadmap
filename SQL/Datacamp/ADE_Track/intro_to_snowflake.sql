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