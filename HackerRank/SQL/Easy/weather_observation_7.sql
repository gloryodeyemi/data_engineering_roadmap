-- Weather Observation Station 7

-- Query the list of CITY names ending with vowels (a, e, i, o, u) from STATION. Your result cannot contain duplicates.
SELECT DISTINCT city
FROM station
WHERE UPPER(RIGHT(city, 1)) IN ('A', 'E', 'I', 'O', 'U');