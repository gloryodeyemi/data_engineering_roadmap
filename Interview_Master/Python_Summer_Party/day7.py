"""
Python Party Day 7: Celebrity Product Drops Sales Performance Analysis

You are a Product Analyst working on Nike's marketing performance team. Your team wants to evaluate the effectiveness of celebrity product 
collaborations by analyzing sales data. You will investigate the performance of celebrity product drops to inform future marketing strategies.
"""

import pandas as pd

fct_sales = pd.DataFrame()

"""
Question 1 of 3
---------------
For Q1 2025 (January 1st through March 31st, 2025), can you identify all records of celebrity collaborations from the sales data where the 
sale_amount is missing? This will help us flag incomplete records that could impact the analysis of Nike's product performance.
"""
# Filter for Q1 sales
fct_sales['sale_date'] = pd.to_datetime(fct_sales['sale_date'])

Q1_sales = fct_sales[
  (fct_sales['sale_date'].dt.year == 2025) &
  (fct_sales['sale_date'].dt.month.isin([1,2,3]))
]

# Find missing records
missing_sales_records = Q1_sales[Q1_sales['sale_amount'].isnull()]
print(missing_sales_records)

"""
Question 2
----------
For Q1 2025 (January 1st through March 31st, 2025), can you list the unique combinations of celebrity_id and product_id from the sales table? 
This will ensure that each collaboration is accurately accounted for in the analysis of Nike's marketing performance.
"""
# Filter for Q1 sales
Q1_sales = fct_sales[
  (fct_sales['sale_date'].dt.year == 2025) &
  (fct_sales['sale_date'].dt.month.isin([1,2,3]))
]

# Get unique combination of celebrity_id and product_id
unique_combinations = Q1_sales[['celebrity_id','product_id']].drop_duplicates()
print(unique_combinations)

"""
Question 3
----------
For Q1 2025 (January 1st through March 31st, 2025), can you rank the unique celebrity collaborations based on their total sales amounts and list 
the top 3 collaborations in descending order? This will help recommend the most successful partnerships for Nike's future product drop strategies.
"""
# Filter for Q1 sales
Q1_sales = fct_sales[
  (fct_sales['sale_date'].dt.year == 2025) &
  (fct_sales['sale_date'].dt.month.isin([1,2,3]))
]

# Get top 3 collaborations
top_collaborations = (
    Q1_sales
    .groupby(['celebrity_id', 'product_id'], as_index=False)['sale_amount']
    .sum()
    .sort_values(by='sale_amount', ascending=False)
    .head(3)
)

print(top_collaborations)
