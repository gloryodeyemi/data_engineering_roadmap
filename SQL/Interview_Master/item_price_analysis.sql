-- Facebook Marketplace Item Price Analyses

-- Question 1 of 2
-- Can you find the average price of items listed in each category on Facebook Marketplace? We want to understand the pricing trends across different categories.
SELECT category, AVG(price)
FROM Listings
GROUP BY category;

-- Question 2
-- Which city has the lowest average price? This will help us identify the most affordable cities for buyers.
SELECT city, AVG(price)
FROM Listings
GROUP BY city
ORDER BY AVG(price)
LIMIT 1;