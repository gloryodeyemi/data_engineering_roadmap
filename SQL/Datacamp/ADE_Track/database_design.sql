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

-- Select state from the appropriate table and the total sales_amount.
-- Complete the JOIN on book_id.
-- Complete the JOIN to connect the dim_store_star table
-- Conditionally select for books with the genre novel.
-- Group the results by state.
-- Output each state and their total sales_amount
SELECT dim_store_star.state, SUM(sales_amount)
FROM fact_booksales
    JOIN dim_book_star ON fact_booksales.book_id = dim_book_star.book_id
    JOIN dim_store_star ON fact_booksales.store_id = dim_store_star.store_id
WHERE  
    dim_book_star.genre = 'novel'
GROUP BY
    dim_store_star.state;

-- Select state from the appropriate table and the total sales_amount.
-- Complete the two JOINS to get the genre_id's.
-- Complete the three JOINS to get the state_id's.
-- Conditionally select for books with the genre novel.
-- Group the results by state.
SELECT dim_state_sf.state, SUM(sales_amount)
FROM fact_booksales
    -- Joins for genre
    JOIN dim_book_sf on fact_booksales.book_id = dim_book_sf.book_id
    JOIN dim_genre_sf on dim_book_sf.genre_id = dim_genre_sf.genre_id
    -- Joins for state 
    JOIN dim_store_sf on fact_booksales.store_id = dim_store_sf.store_id 
    JOIN dim_city_sf on dim_store_sf.city_id = dim_city_sf.city_id
	JOIN dim_state_sf on  dim_city_sf.state_id = dim_state_sf.state_id
-- Get all books with in the novel genre and group the results by state
WHERE  
    dim_genre_sf.genre = 'novel'
GROUP BY
    dim_state_sf.state;

-- Output all the records that need to be updated in the star schema so that countries are represented by their abbreviations.
SELECT * FROM dim_store_star
WHERE country != 'USA' AND country !='CA';

-- Add a continent_id column to dim_country_sf with a default value of 1. Note thatNOT NULL DEFAULT(1) constrains a value from being null and defaults its value to 1.
-- Make that new column a foreign key reference to dim_continent_sf's continent_id.
ALTER TABLE dim_country_sf
ADD COLUMN continent_id int NOT NULL DEFAULT(1);

ALTER TABLE dim_country_sf ADD CONSTRAINT country_continent
   FOREIGN KEY (continent_id) REFERENCES dim_continent_sf(continent_id);
