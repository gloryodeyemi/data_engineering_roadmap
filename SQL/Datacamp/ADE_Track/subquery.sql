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