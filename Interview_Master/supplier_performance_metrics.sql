-- Supplier Performance Metrics

-- As a Data Analyst on the Supply Chain Procurement Team, you are tasked with assessing supplier performance to ensure reliable delivery of critical components. 
-- Your goal is to identify the most active suppliers, understand which suppliers dominate in specific manufacturing regions, and pinpoint any gaps in supply to 
-- the Asia region. By leveraging data, you will help optimize vendor selection strategies and mitigate potential supply chain risks.

-- Question 1 of 3
-- We need to know who our most active suppliers are. Identify the top 5 suppliers based on the total volume of components delivered in October 2024.
SELECT supplier_name, SUM(component_count) AS total_volume
FROM supplier_deliveries
LEFT JOIN suppliers
USING(supplier_id)
WHERE delivery_date BETWEEN '2024-10-01' AND '2024-10-31'
GROUP BY supplier_name
ORDER BY total_volume DESC
LIMIT 5;

-- Question 2
-- For each region, find the supplier that delivered the highest number of components in November 2024. This will help us understand which supplier is handling the most volume per market.
WITH supplier_totals AS (
    SELECT 
        manufacturing_region, 
        supplier_id, 
        SUM(component_count) AS total_components
    FROM supplier_deliveries
    WHERE delivery_date BETWEEN '2024-11-01' AND '2024-11-30'
    GROUP BY manufacturing_region, supplier_id
), ranked_suppliers AS (
    SELECT 
        s.manufacturing_region, 
        s.supplier_id, 
        s.total_components, 
        sp.supplier_name,
        ROW_NUMBER() OVER (PARTITION BY s.manufacturing_region ORDER BY s.total_components DESC) AS row_num
    FROM supplier_totals s
    JOIN suppliers sp
    USING(supplier_id)
)
SELECT manufacturing_region, supplier_id, supplier_name, total_components
FROM ranked_suppliers
WHERE row_num = 1;

-- """ Test
-- SELECT manufacturing_region, supplier_id, supplier_name, MAX(total_components)
-- FROM (
--   SELECT manufacturing_region, supplier_id, SUM(component_count) AS total_components
--   FROM supplier_deliveries
--   WHERE delivery_date BETWEEN '2024-11-01' AND '2024-11-30'
--   GROUP BY manufacturing_region, supplier_name
-- )
-- LEFT JOIN suppliers
-- USING(supplier_id)
-- GROUP BY manufacturing_region;
-- """

-- Question 3
-- We need to identify potential gaps in our supply chain for Asia. List all suppliers by name who have not delivered any components to the 'Asia' manufacturing region in December 2024.
SELECT s.supplier_name
FROM suppliers s
LEFT JOIN supplier_deliveries sd 
    ON s.supplier_id = sd.supplier_id 
    AND sd.manufacturing_region = 'Asia'
    AND sd.delivery_date BETWEEN '2024-12-01' AND '2024-12-31'
WHERE sd.supplier_id IS NULL;

-- Option 2
SELECT supplier_name
FROM suppliers
WHERE supplier_id NOT IN (
    SELECT DISTINCT supplier_id
    FROM supplier_deliveries
    WHERE manufacturing_region = 'Asia'
    AND delivery_date BETWEEN '2024-12-01' AND '2024-12-31'
);