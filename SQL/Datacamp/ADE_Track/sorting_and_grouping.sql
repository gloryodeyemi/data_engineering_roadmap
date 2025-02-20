-- Sorting and Grouping

-- ORDER BY
-- Select the name of each person in the people table, sorted alphabetically.
SELECT name
FROM people
ORDER BY name ASC;

-- Select the title and duration for every film, from longest duration to shortest.
SELECT title, duration
FROM films
ORDER BY duration DESC;

-- Select the release_year, duration, and title of films ordered by their release year and duration, in that order.
SELECT release_year, duration, title
FROM films
ORDER BY release_year, duration;

-- Select the certification, release_year, and title from films ordered first by certification (alphabetically) and second by release year, starting with the most recent year.
SELECT certification, release_year, title
FROM films
ORDER BY certification, release_year DESC;

-- GROUP BY
-- Select the release_year and count of films released in each year aliased as film_count.
SELECT release_year, COUNT(*) AS film_count
FROM films
GROUP BY release_year;

-- Select the release_year and average duration aliased as avg_duration of all films, grouped by release_year.
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;

-- Select the release_year, country, and the maximum budget aliased as max_budget for each year and each country; sort your results by release_year and country.
SELECT release_year, country, MAX(budget) AS max_budget
FROM films
GROUP BY release_year, country
ORDER BY release_year, country;

-- Using the films table: which release_year had the most language diversity?
SELECT release_year, COUNT(DISTINCT language) AS language_diversity
FROM films
GROUP BY release_year
ORDER BY language_diversity DESC;

-- HAVING
-- Select country from the films table, and get the distinct count of certification aliased as certification_count.
-- Group the results by country.
-- Filter the unique count of certifications to only results greater than 10.
SELECT country, COUNT(DISTINCT certification) AS certification_count
FROM films
GROUP BY country
HAVING COUNT(DISTINCT certification) > 10;

-- Select the country and the average budget as average_budget, rounded to two decimal, from films.
-- Group the results by country.
-- Filter the results to countries with an average budget of more than one billion (1000000000).
-- Sort by descending order of the average_budget.
SELECT country, ROUND(AVG(budget), 2) AS average_budget
FROM films
GROUP BY country
HAVING AVG(budget) > 1000000000
ORDER BY average_budget DESC;

-- Select the release_year for each film in the films table, filter for records released after 1990, and group by release_year.
SELECT release_year
FROM films
WHERE release_year > 1990
GROUP BY release_year;

-- Modify the query to include the average budget aliased as avg_budget and average gross aliased as avg_gross for the results we have so far.
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year;

-- Modify the query once more so that only years with an average budget of greater than 60 million are included.
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000;

-- Finally, order the results from the highest average gross and limit to one.
SELECT release_year, AVG(budget) AS avg_budget, AVG(gross) AS avg_gross
FROM films
WHERE release_year > 1990
GROUP BY release_year
HAVING AVG(budget) > 60000000
ORDER BY avg_gross DESC
LIMIT 1;