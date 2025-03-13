-- Write three SQL queries to answer the following questions:

-- What are the most popular transport types, measured by the total number of journeys? The output should contain two columns, 1) JOURNEY_TYPE and 2) TOTAL_JOURNEYS_MILLIONS, 
-- and be sorted by the second column in descending order. Save the query as most_popular_transport_types.
SELECT journey_type, SUM(journeys_millions) AS total_journeys_millions
FROM TFL.JOURNEYS
GROUP BY journey_type
ORDER BY SUM(journeys_millions) DESC;

-- Which five months and years were the most popular for the Emirates Airline? Return an output containing MONTH, YEAR, and JOURNEYS_MILLIONS, with the latter rounded to two decimal 
-- places and aliased as ROUNDED_JOURNEYS_MILLIONS. Exclude null values and save the result as emirates_airline_popularity.
SELECT month, year, ROUND(SUM(journeys_millions), 2) AS rounded_journeys_millions
FROM TFL.JOURNEYS
WHERE journey_type = 'Emirates Airline'
AND journeys_millions IS NOT NULL
GROUP BY month, year
ORDER BY rounded_journeys_millions desc
LIMIT 5;

-- Find the five years with the lowest volume of Underground & DLR journeys, saving as least_popular_years_tube. The results should contain the columns YEAR, JOURNEY_TYPE, and 
-- TOTAL_JOURNEYS_MILLIONS.
SELECT year, journey_type, SUM(journeys_millions) AS total_journeys_millions
FROM TFL.JOURNEYS
WHERE journey_type = 'Underground & DLR'
GROUP BY year, journey_type
ORDER BY total_journeys_millions
LIMIT 5;