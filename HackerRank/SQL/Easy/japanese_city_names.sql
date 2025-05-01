-- Japanese Cities' Names

-- Query the names of all the Japanese cities in the CITY table. The COUNTRYCODE for Japan is JPN.

/*
    Enter your query here and follow these instructions:
    1. Please append a semicolon ";" at the end of the query and enter your query in a single line to avoid error.
    2. The AS keyword causes errors, so follow this convention: "Select t.Field From table1 t" instead of "select t.Field From table1 AS t"
    3. Type your code immediately after comment. Don't leave any blank line.
*/
select NAME from CITY where COUNTRYCODE = 'JPN';