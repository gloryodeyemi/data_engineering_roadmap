"""
Python Party Day 12: E-commerce Returns Customer Segmentation Model

You are a Data Analyst on the Walmart.com Insights team investigating customer return patterns. The team aims to develop a predictive approach to understanding customer return behaviors across different time periods. Your goal is to leverage transaction data to create a comprehensive view of customer return likelihood.
"""

import pandas as pd

customer_returns = pd.DataFrame()

"""
Question 1 of 2
---------------
Identify and list all unique customer IDs who have made returns between July 1st 2024 and June 30th 2025. This will help us understand the base set of customers involved in returns during the specified period.
"""
# Filter the data to get returned orders only
returns = customer_returns[customer_returns['return_flag'] == True]

# Get all returns between July 1st 2024 and June 30th 2025
returns['order_date'] = pd.to_datetime(returns['order_date'])
jul_jun_returns = returns[
  (returns['order_date'] >= '2024-07-01') & 
  (returns['order_date'] <= '2025-06-30')
]

# Identify unique customers 
unique_customers = jul_jun_returns['customer_id'].unique()

print(f"List of unique customer IDs:\n{unique_customers}")

"""
Question 2
----------
Convert the 'order_date' column to a datetime format and create a MultiIndex with 'customer_id' and 'order_date'. Then, calculate the total number of returns per customer for each month. This will provide insights into monthly return patterns for each customer.
"""

# Convert the order date to a datetime format
customer_returns['order_date'] = pd.to_datetime(
  customer_returns['order_date'],
  format='mixed',
  errors='coerce'
)

# Create a MultiIndex with customer_id and order_date
multi_indexed = customer_returns.set_index(['customer_id', 'order_date'])

# Filter for returns data only
returns_only = multi_indexed[multi_indexed['return_flag'] == True]

# Calculate the total returns by customer and month
returns_only['month'] = returns_only.index.get_level_values('order_date').month_name()

customer_return_agg = (
  returns_only.groupby(['customer_id','month'])
  .agg(total_returns=('order_id','count'))
  .reset_index()
)

print(customer_return_agg)
