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