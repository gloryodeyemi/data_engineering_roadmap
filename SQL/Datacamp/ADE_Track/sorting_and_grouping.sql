-- Sorting and Grouping

-- Select the name of each person in the people table, sorted alphabetically.
SELECT name
FROM people
ORDER BY name ASC;

-- Select the title and duration for every film, from longest duration to shortest.
SELECT title, duration
FROM films
ORDER BY duration DESC;