-- WHERE
-- Select and count the language field using the alias count_spanish.
-- Apply a filter to select only Spanish from the language field.
SELECT COUNT(language) AS count_spanish
FROM films
WHERE language = 'Spanish';

-- BETWEEN, AND, OR
-- Select the title and release_year for all German-language films released before 2000.
SELECT title, release_year
FROM films
WHERE release_year < 2000
	AND language = 'German';

-- Update the query from the previous step to show German-language films released after 2000 rather than before.
SELECT title, release_year
FROM films
WHERE release_year > 2000
	AND language = 'German';

-- Select all details for German-language films released after 2000 but before 2010 using only WHERE and AND.
SELECT *
FROM films
WHERE release_year > 2000 
    AND release_year < 2010
	AND language = 'German';