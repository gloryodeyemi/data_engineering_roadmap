-- Sorting and Grouping

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

-- Select the release_year and count of films released in each year aliased as film_count.
SELECT release_year, COUNT(*) AS film_count
FROM films
GROUP BY release_year;

-- Select the release_year and average duration aliased as avg_duration of all films, grouped by release_year.
SELECT release_year, AVG(duration) AS avg_duration
FROM films
GROUP BY release_year;