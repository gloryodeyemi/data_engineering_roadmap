-- Weather Observation Station 6

-- Query the list of CITY names starting with vowels (i.e., a, e, i, o, or u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE city LIKE 'A%'
    OR city LIKE 'E%'
    OR city LIKE 'I%'
    OR city LIKE 'O%'
    OR city LIKE 'u%';

-- Solution 2
SELECT DISTINCT city
FROM station
WHERE UPPER(LEFT(city, 1)) IN ('A', 'E', 'I', 'O', 'U');

-- Solution 3
SELECT DISTINCT city
FROM station
WHERE UPPER(SUBSTR(city, 1, 1)) IN ('A', 'E', 'I', 'O', 'U');