-- LIKE, NOT LIKE, IN

-- Select the names of all people whose names begin with 'B'.
SELECT name
FROM people
WHERE name LIKE 'B%';

-- Select the names of people whose names have 'r' as the second letter.
SELECT name
FROM people
WHERE name LIKE '_r%';

-- Select the names of people whose names don't start with 'A'.
SELECT name
FROM people
WHERE name NOT LIKE 'A%';

-- Select the title and release_year of all films released in 1990 or 2000 that were longer than two hours.
SELECT title, release_year
FROM films
WHERE release_year IN (1990, 2000)
    AND duration > 120;

-- Select the title and language of all films in English, Spanish, or French using IN.
SELECT title, language
FROM films
WHERE language IN ('English', 'Spanish', 'French');

-- Select the title, certification and language of all films certified NC-17 or R that are in English, Italian, or Greek.
SELECT title, certification, language
FROM films
WHERE certification IN ('NC-17', 'R')
    AND language IN ('English', 'Italian', 'Greek');

-- Combining filtering and selecting
