"""
Python Party Day 1: WhatsApp Group Size Engagement Analysis

You are a Product Analyst on the WhatsApp team investigating group messaging dynamics. Your team wants to understand how large groups are being 
used and their messaging patterns. You'll leverage data to uncover insights about group participation and communication behaviors.
"""

import pandas as pd

dim_groups = pd.DataFrame()

# Question 1 of 3
# What is the maximum number of participants among WhatsApp groups that were created in October 2024? This metric will help us understand the 
# largest group size available.
oct_groups = dim_groups[(dim_groups['created_date'] >= '2024-10-01') & (dim_groups['created_date'] <= '2024-10-31')]
max_participant = oct_groups['participant_count'].max()
print(max_participant)

# Question 2:
# What is the average number of participants in WhatsApp groups that were created in October 2024? This number will indicate the typical group 
# size and inform our group messaging feature considerations.
oct_groups = dim_groups[(dim_groups['created_date'] >= '2024-10-01') & (dim_groups['created_date'] <= '2024-10-31')]
avg_participant = oct_groups['participant_count'].mean()
print(avg_participant)

# Question 3:
# For WhatsApp groups with more than 50 participants that were created in October 2024, what is the average number of messages sent? This insight 
# will help assess engagement in larger groups and support recommendations for group messaging features.
oct_groups = dim_groups[(dim_groups['created_date'] >= '2024-10-01') & (dim_groups['created_date'] <= '2024-10-31')]
more_than_50_groups = oct_groups[oct_groups['participant_count'] > 50]
avg_message = more_than_50_groups['total_messages'].mean()
print(avg_message)