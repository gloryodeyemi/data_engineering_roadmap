"""
Python Party Day 3: Disney Parks Guest Spending Behavior

You are a data analyst working with the Disney Parks revenue team to understand nuanced guest spending patterns across different park experiences. 
The team wants to develop a comprehensive view of visitor purchasing behaviors. Your goal is to uncover meaningful insights that can drive 
personalized marketing strategies.
"""

import pandas as pd

fct_guest_spending = pd.DataFrame()
"""
Question 1 of 3
---------------
What is the average spending per guest per visit for each park experience type during July 2024? Ensure that park experience types with no 
recorded transactions are shown with an average spending of 0.0. This analysis helps establish baseline spending differences essential for later 
segmentation.
"""
# Unique park experience types
unique_experience_types = fct_guest_spending[['park_experience_type']].drop_duplicates() # type: ignore

# Get park experience in July 2024 alone
fct_guest_spending['visit_date'] = pd.to_datetime(fct_guest_spending['visit_date'])
july_24_visits = fct_guest_spending[
    (fct_guest_spending['visit_date'].dt.month == 7) &
    (fct_guest_spending['visit_date'].dt.year == 2024)
]

# Calculate the total spend and number of visits for each experience type
experience_spend = (
    july_24_visits.groupby('park_experience_type')
    .agg(total_spent=('amount_spent', 'sum'), total_visits=('guest_id', 'count'))
    .reset_index()
)

# Calculate the average spend for each experience type
experience_spend['avg_spending'] = experience_spend['total_spent'] / experience_spend['total_visits']

# Merge with the unique experience types to include the ones with no recorded transactions
avg_spend = pd.merge(
    unique_experience_types,
    experience_spend[['park_experience_type', 'avg_spending']],
    on='park_experience_type',
    how='left'
)

# Fill missing values with 0.0
avg_spend['avg_spending'] = avg_spend['avg_spending'].fillna(0.0)
print(avg_spend)