-- Revising the Select Query I

/*
Query all columns for all American cities in the CITY table with populations larger than 100000. The CountryCode for America is USA.
*/
SELECT *
FROM city
WHERE population > 100000
AND countrycode = 'USA';