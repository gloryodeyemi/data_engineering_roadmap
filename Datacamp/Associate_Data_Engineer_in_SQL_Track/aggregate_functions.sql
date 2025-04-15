-- Aggregate Functions

-- Use the SUM() function to calculate the total duration of all films and alias with total_duration.
SELECT SUM(duration) AS total_duration
FROM films;

-- Calculate the average duration of all films and alias with average_duration.
SELECT AVG(duration) AS average_duration
FROM films;

-- Find the most recent release_year in the films table, aliasing as latest_year.
SELECT MAX(release_year) AS latest_year
FROM films;

-- Find the duration of the shortest film and use the alias shortest_film.
SELECT MIN(duration) AS shortest_film
FROM films;

-- Use SUM() to calculate the total gross for all films made in the year 2000 or later, and use the alias total_gross.
SELECT SUM(gross) AS total_gross
FROM films
WHERE release_year >= 2000;

-- Calculate the average amount grossed by all films whose titles start with the letter 'A' and alias with avg_gross_A.
SELECT AVG(gross) AS avg_gross_A
FROM films
WHERE title LIKE 'A%';

-- Calculate the lowest gross film in 1994 and use the alias lowest_gross.
SELECT MIN(gross) AS lowest_gross
FROM films
WHERE release_year = 1994;

-- Calculate the highest gross film between 2000 and 2012, inclusive, and use the alias highest_gross.
SELECT MAX(gross) AS highest_gross
FROM films
WHERE release_year BETWEEN 2000 AND 2012;

-- Calculate the average facebook_likes to one decimal place and assign to the alias, avg_facebook_likes.
SELECT ROUND(AVG(facebook_likes), 1) AS avg_facebook_likes
FROM reviews;

-- Calculate the average budget from the films table, aliased as avg_budget_thousands, and round to the nearest thousand.
SELECT ROUND(AVG(budget), -3) AS avg_budget_thousands
FROM films;

-- Select the title and duration in hours for all films and alias as duration_hours; since the current durations are in minutes, you'll need to divide duration by 60.0.
SELECT title, (duration/60.0) AS duration_hours
FROM films;

-- Calculate the percentage of people who are no longer alive and alias the result as percentage_dead.
SELECT COUNT(deathdate) * 100.0 / COUNT(*) AS percentage_dead
FROM people;

-- Find how many decades (period of ten years) the films table covers by using MIN() and MAX(); alias as number_of_decades.
SELECT (MAX(release_year) - MIN(release_year)) / 10.0 AS number_of_decades
FROM films;

-- Update the query by adding ROUND() around the calculation and round to two decimal places.
SELECT title, ROUND(duration / 60.0, 2) AS duration_hours
FROM films;