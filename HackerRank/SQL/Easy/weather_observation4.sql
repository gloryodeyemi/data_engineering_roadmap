-- Weather Observation Station 4

-- Find the difference between the total number of CITY entries in the table and the number of distinct CITY entries in the table.

/*
    Enter your query here and follow these instructions:
    1. Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
    2. The AS keyword causes errors, so follow this convention: "Select t.Field From table1 t" instead of "select t.Field From table1 AS t"
    3. Type your code immediately after comment. Don't leave any blank line.
*/
select count(CITY) - count(distinct CITY) from STATION;