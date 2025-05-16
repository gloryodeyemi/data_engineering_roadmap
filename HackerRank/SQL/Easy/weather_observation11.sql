-- Weather Observation Station 11

-- Query the list of CITY names from STATION that either do not start with vowels or do not end with vowels. Your result cannot contain duplicates.
select distinct city 
from station 
where lower(left(city, 1)) not in ('a', 'e', 'i', 'o', 'u') 
    or lower(right(city, 1)) not in ('a', 'e', 'i', 'o', 'u');