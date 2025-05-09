-- Weather Observation Station 5

/*
Query the two cities in STATION with the shortest and longest CITY names, as well as their respective lengths (i.e.: number of characters in the name). 
If there is more than one smallest or largest city, choose the one that comes first when ordered alphabetically.
*/
(
  SELECT city, LENGTH(city) AS name_length
  FROM station
  ORDER BY LENGTH(city) ASC, city ASC
  LIMIT 1
)
UNION
(
  SELECT city, LENGTH(city) AS name_length
  FROM station
  ORDER BY LENGTH(city) DESC, city ASC
  LIMIT 1
);