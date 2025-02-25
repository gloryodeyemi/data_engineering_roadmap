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
ALTER TABLE fact_booksales ADD CONSTRAINT sales_book
    FOREIGN KEY (book_id) REFERENCES dim_book_star (book_id);
    
ALTER TABLE fact_booksales ADD CONSTRAINT sales_time
    FOREIGN KEY (time_id) REFERENCES dim_time_star (time_id);
    
ALTER TABLE fact_booksales ADD CONSTRAINT sales_store
    FOREIGN KEY (store_id) REFERENCES dim_store_star (store_id);

-- Create dim_author with a column for author.
-- Insert all the distinct authors from dim_book_star into dim_author.
CREATE TABLE dim_author (
    author VARCHAR(256)  NOT NULL
);

INSERT INTO dim_author
SELECT DISTINCT author FROM dim_book_star;

-- Alter dim_author to have a primary key called author_id.
-- Output all the columns of dim_author.
ALTER TABLE dim_author ADD COLUMN author_id SERIAL PRIMARY KEY;

SELECT * FROM dim_author;
