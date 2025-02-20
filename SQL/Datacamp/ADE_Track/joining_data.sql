-- INNER JOIN and USING

-- Perform an inner join with the cities table on the left and the countries table on the right; you do not need to alias tables here.
-- Join ON the country_code and code columns, making sure you identify them with the correct table.
SELECT * 
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;

-- Complete the SELECT statement to keep three columns: the name of the city, the name of the country, and the region the country is located in (in this order).
-- Alias the name of the city AS city and the name of the country AS country.
SELECT cities.name AS city, countries.name AS country, region
FROM cities
INNER JOIN countries
ON cities.country_code = countries.code;