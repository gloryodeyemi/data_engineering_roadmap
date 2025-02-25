--  Dimension modeling

-- Create a dimension table called route that will hold the route information.
CREATE TABLE route(
	route_id INTEGER PRIMARY KEY,
    route_name VARCHAR(160) NOT NULL,
    park_name VARCHAR(160) NOT NULL,
    distance_km FLOAT NOT NULL,
    city_name VARCHAR(160) NOT NULL
);

-- Create a dimension table called week that will hold the week information.
CREATE TABLE week(
	week_id INTEGER PRIMARY KEY,
    week INTEGER NOT NULL,
    month VARCHAR(160) NOT NULL,
    year INTEGER NOT NULL
);

-- Calculate the sum of the duration_mins column.
-- Join week_dim and runs_fact.
-- Get all the week_id's from July, 2019.
SELECT 
	SUM(duration_mins)
FROM 
	runs_fact
INNER JOIN week_dim ON runs_fact.week_id = week_dim.week_id
WHERE month = 'July' and year = '2019';

-- In the constraint called sales_book, set book_id as a foreign key.
-- In the constraint called sales_time, set time_id as a foreign key.
-- In the constraint called sales_store, set store_id as a foreign key.
