-- Semi join, Anti join (Subquries)

-- Select country code as a single field from the countries table, filtering for countries in the 'Middle East' region.
SELECT code
FROM countries
WHERE region = 'Middle East';

-- Write a second query to SELECT the name of each unique language appearing in the languages table; do not use column aliases here.
-- Order the result set by name in ascending order.
SELECT DISTINCT name
FROM languages
ORDER BY name;

-- Create a semi join out of the two queries you've written, which filters unique languages returned in the first query for only those languages spoken in the 'Middle East'.
SELECT DISTINCT name
FROM languages
WHERE code IN
    (SELECT code
    FROM countries
    WHERE region = 'Middle East')
ORDER BY name;

-- Begin by writing a query to return the code and name (in order, not aliased) for all countries in the continent of Oceania from the countries table.
-- Observe the number of records returned and compare this with the provided INNER JOIN, which returns 15 records.
SELECT code, name
FROM countries
WHERE continent = 'Oceania'
-- Now, build on your query to complete your anti join, by adding an additional filter to return every country code that is not included in the currencies table.
  AND code NOT IN
    (SELECT code
    FROM currencies);

-- Subqueries in WHERE and SELECT
-- Begin by calculating the average life expectancy from the populations table.
-- Filter your answer to use records from 2015 only.
SELECT AVG(life_expectancy)
FROM populations
WHERE year = 2015;

-- The answer from your query has now been nested into another query; use this calculation to filter populations for all records where life_expectancy is 1.15 
-- times higher than average.
SELECT *
FROM populations
WHERE year = 2015
-- Filter for only those populations where life expectancy is 1.15 times higher than average
  AND life_expectancy > 1.15 * 
  (SELECT AVG(life_expectancy)
   FROM populations
   WHERE year = 2015);

-- Return the name, country_code and urbanarea_pop for all capital cities (not aliased).
-- Select relevant fields from cities table
SELECT name, country_code, urbanarea_pop
FROM cities
WHERE name IN
    (SELECT capital
    FROM countries)
ORDER BY urbanarea_pop DESC;

-- Write a LEFT JOIN with countries on the left and the cities on the right, joining on country code.
-- In the SELECT statement of your join, include country names as country, and count the cities in each country, aliased as cities_num.
-- Sort by cities_num (descending), and country (ascending), limiting to the first nine records.
-- Find top nine countries with the most cities
SELECT countries.name AS country, COUNT(cities.name) AS cities_num
FROM countries
LEFT JOIN cities
    ON countries.code = cities.country_code
GROUP BY countries.name
ORDER BY cities_num DESC
LIMIT 9;

-- Complete the subquery to return a result equivalent to your LEFT JOIN, counting all cities in the cities table as cities_num.
-- Use the WHERE clause to enable the correct country codes to be matched in the cities and countries columns
SELECT countries.name AS country,
  (SELECT COUNT(name)
   FROM cities
   WHERE cities.country_code = countries.code) AS cities_num
FROM countries
ORDER BY cities_num DESC, country
LIMIT 9;

-- Subquery inside FROM
-- Begin with a query that groups by each country code from languages, and counts the languages spoken in each country as lang_num.
-- In your SELECT statement, return code and lang_num (in that order).
SELECT code, COUNT(name) AS lang_num
FROM languages
GROUP BY code;

-- Select local_name from countries, with the aliased lang_num from your subquery (which has been nested and aliased for you as sub).
-- Use WHERE to match the code field from countries and sub.
SELECT local_name, lang_num
FROM countries,
  (SELECT code, COUNT(*) AS lang_num
  FROM languages
  GROUP BY code) AS sub
WHERE countries.code = sub.code
ORDER BY lang_num DESC;