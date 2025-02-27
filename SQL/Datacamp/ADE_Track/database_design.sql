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

-- cars_rented holds one or more car_ids and invoice_id holds multiple values. Create a new table to hold individual car_ids and invoice_ids of the customer_ids 
-- who've rented those cars.
-- Drop two columns from customers table to satisfy 1NF
-- Create a new table to hold the cars rented by customers
CREATE TABLE cust_rentals (
  customer_id INT NOT NULL,
  car_id VARCHAR(128) NULL,
  invoice_id VARCHAR(128) NULL
);

ALTER TABLE customers
DROP COLUMN cars_rented,
DROP COLUMN invoice_id;

-- Create a new table for the non-key columns that were conflicting with 2NF criteria.
-- Drop those non-key columns from customer_rentals.
CREATE TABLE cars (
  car_id VARCHAR(256) NULL,
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128),
  condition VARCHAR(128),
  color VARCHAR(128)
);

-- Insert data into the new table
INSERT INTO cars
SELECT DISTINCT
  car_id,
  model,
  manufacturer,
  type_car,
  condition,
  color
FROM customer_rentals;

-- Drop columns in customer_rentals to satisfy 2NF
ALTER TABLE customer_rentals
DROP COLUMN model,
DROP COLUMN manufacturer, 
DROP COLUMN type_car,
DROP COLUMN condition,
DROP COLUMN color;

-- Create a new table for the non-key columns that were conflicting with 3NF criteria.
-- Drop those non-key columns from rental_cars.
CREATE TABLE car_model(
  model VARCHAR(128),
  manufacturer VARCHAR(128),
  type_car VARCHAR(128)
);

-- Drop columns in rental_cars to satisfy 3NF
ALTER TABLE rental_cars
DROP COLUMN model, 
DROP COLUMN manufacturer;

-- Query the information schema to get views.
-- Exclude system views in the results.
SELECT * FROM information_schema.views
WHERE table_schema NOT IN ('pg_catalog', 'information_schema');

-- Create a view called high_scores that holds reviews with scores above a 9.
CREATE VIEW high_scores AS
SELECT * FROM reviews
WHERE score > 9;

-- Count the number of records in high_scores that are self-released in the label field of the labels table.
SELECT COUNT(*) FROM high_scores
INNER JOIN labels ON high_scores.reviewid = labels.reviewid
WHERE label = 'self-released';

-- Create a view called top_artists_2017 with artist from artist_title.
-- To only return the highest scoring artists of 2017, join the views top_15_2017 and artist_title on reviewid.
-- Output top_artists_2017.
CREATE VIEW top_artists_2017 AS
SELECT artist_title.artist FROM artist_title
INNER JOIN top_15_2017
ON artist_title.reviewid = top_15_2017.reviewid;

SELECT * FROM top_artists_2017;

-- Revoke all database users' update and insert privileges on the long_reviews view.
REVOKE UPDATE, INSERT ON long_reviews FROM PUBLIC; 

-- Grant the editor user update and insert privileges on the long_reviews view.
GRANT UPDATE, INSERT ON long_reviews TO editor; 

-- Use CREATE OR REPLACE to redefine the artist_title view.
-- Respecting artist_title's original columns of reviewid, title, and artist, add a label column from the labels table.
-- Join the labels table using the reviewid field.
CREATE OR REPLACE VIEW artist_title AS
SELECT reviews.reviewid, reviews.title, artists.artist, labels.label
FROM reviews
INNER JOIN artists
ON artists.reviewid = reviews.reviewid
INNER JOIN labels
ON labels.reviewid = reviews.reviewid;

-- Create a materialized view called genre_count that holds the number of reviews for each genre.
-- Refresh genre_count so that the view is up-to-date.
CREATE MATERIALIZED VIEW genre_count AS
SELECT genre, COUNT(*) 
FROM genres
GROUP BY genre;

REFRESH MATERIALIZED VIEW genre_count;

-- Create a role called data_scientist.
CREATE ROLE data_scientist;

-- Create a role called marta that has one attribute: the ability to login (LOGIN).
CREATE ROLE Marta WITH LOGIN;

-- Create a role called admin with the ability to create databases (CREATEDB) and to create roles (CREATEROLE).
CREATE ROLE admin WITH CREATEDB CREATEROLE;

-- Grant the data_scientist role update and insert privileges on the long_reviews view.
GRANT UPDATE, INSERT ON long_reviews TO data_scientist;

-- Alter Marta's role to give her the provided password.
ALTER ROLE marta WITH PASSWORD 's3cur3p@ssw0rd';

-- Add Marta's user role to the data scientist group role.
GRANT data_scientist TO Marta;

-- Remove Marta's user role from the data scientist group role.
REVOKE data_scientist FROM Marta;

-- Create a new table film_descriptions containing 2 fields: film_id, which is of type INT, and long_description, which is of type TEXT.
CREATE TABLE film_descriptions (
    film_id INT,
    long_description TEXT
);

-- Occupy the new table with values from the film table.
INSERT INTO film_descriptions
SELECT film_id, long_description FROM film;

-- Drop the field long_description from the film table.
-- Join the two resulting tables to view the original table.
ALTER TABLE film DROP COLUMN long_description;

SELECT * FROM film 
JOIN film_descriptions USING(film_id);

-- Create the table film_partitioned, partitioned on the field release_year.
CREATE TABLE film_partitioned (
  film_id INT,
  title TEXT NOT NULL,
  release_year TEXT
)
PARTITION BY LIST (release_year);

-- Create three partitions: one for each release year: 2017, 2018, and 2019. Call the partition for 2019 film_2019, etc.
CREATE TABLE film_2019
	PARTITION OF film_partitioned FOR VALUES IN ('2019');
    
CREATE TABLE film_2018
	PARTITION OF film_partitioned FOR VALUES IN ('2018');
    
CREATE TABLE film_2017
	PARTITION OF film_partitioned FOR VALUES IN ('2017');

-- Occupy the new table, film_partitioned, with the three fields required from the film table.
INSERT INTO film_partitioned
SELECT film_id, title, release_year FROM film;