-- Cards Issued Difference

/*
Your team at JPMorgan Chase is preparing to launch a new credit card, and to gain some insights, you're analyzing how many credit cards were issued 
each month.

Write a query that outputs the name of each credit card and the difference in the number of issued cards between the month with the highest 
issuance cards and the lowest issuance. Arrange the results based on the largest disparity.

monthly_cards_issued Table:
Column Name	Type
card_name	string
issued_amount	integer
issue_month	integer
issue_year	integer

monthly_cards_issued Example Input:
card_name	issued_amount	issue_month	issue_year
Chase Freedom Flex	55000	1	2021
Chase Freedom Flex	60000	2	2021
Chase Freedom Flex	65000	3	2021
Chase Freedom Flex	70000	4	2021
Chase Sapphire Reserve	170000	1	2021
Chase Sapphire Reserve	175000	2	2021
Chase Sapphire Reserve	180000	3	2021

Example Output:
card_name	difference
Chase Freedom Flex	15000
Chase Sapphire Reserve	10000

Chase Freedom Flex's best month was 70k cards issued and the worst month was 55k cards, so the difference is 15k cards.

Chase Sapphire Reserve’s best month was 180k cards issued and the worst month was 170k cards, so the difference is 10k cards.
*/
SELECT 
  card_name, 
  MAX(issued_amount) - MIN(issued_amount) AS difference
FROM monthly_cards_issued
GROUP BY card_name
ORDER BY difference DESC;

-- Solution 2
WITH min_card AS (
  SELECT 
    card_name,
    MIN(issued_amount) AS min_amount
  FROM monthly_cards_issued
  GROUP BY card_name
),
max_card AS (
  SELECT 
    card_name,
    MAX(issued_amount) AS max_amount
  FROM monthly_cards_issued
  GROUP BY card_name
)
SELECT 
  min_card.card_name,
  max_amount - min_amount AS difference
FROM min_card
JOIN max_card
 ON min_card.card_name = max_card.card_name
ORDER BY difference DESC;