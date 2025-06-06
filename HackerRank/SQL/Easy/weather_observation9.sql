-- Weather Observation Station 9

-- Query the list of CITY names from STATION that do not start with vowels. Your result cannot contain duplicates.
select distinct city 
from station 
where lower(left(city, 1)) not in ('a', 'e', 'i', 'o', 'u');