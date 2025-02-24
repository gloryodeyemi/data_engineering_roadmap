-- Get information on all table names in the current database, while limiting your query to the 'public' table_schema.
SELECT table_name 
FROM information_schema.tables
WHERE table_schema = 'public';