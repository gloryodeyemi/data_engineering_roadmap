-- Weather Observation Station 8

/*
Query the list of CITY names from STATION which have vowels (i.e., a, e, i, o, and u) as both their first and last characters. Your result cannot contain duplicates.
*/
select distinct city 
from station 
where lower(left(city, 1)) in ('a', 'e', 'i', 'o', 'u') 
    and lower(right(city, 1)) in ('a', 'e', 'i', 'o', 'u');