-- WHERE
-- Select and count the language field using the alias count_spanish.
-- Apply a filter to select only Spanish from the language field.
SELECT COUNT(language) AS count_spanish
FROM films
WHERE language = 'Spanish';