"""
Python Party Day 4: Search Results Page: User Interaction Patterns

You are a Product Analyst on the Google Search team investigating user engagement with search result pages. The team wants to understand how 
different numbers of search results impact user interaction time. Your analysis will help optimize the current search results presentation 
strategy.
"""

import pandas as pd

user_engagement_data = pd.DataFrame()

"""
Question 1 of 3
---------------
Identify and remove any duplicate entries in the dataset to ensure data quality. How many duplicates were found and removed?
"""
# Remove duplicates and get total removed
no_duplicates = user_engagement_data.drop_duplicates()
print(len(user_engagement_data) - len(no_duplicates))

"""
Question 2
----------
After dropping duplicates, aggregate the data to find the average user interaction time for each number of search results displayed per page. 
What are the average interaction times?
"""
# Remove duplicates
no_duplicates = user_engagement_data.drop_duplicates()

# Calculate the average user interaction time
avg_interaction = (
  no_duplicates.groupby('search_results_displayed')
  .agg(avg_interaction_time=('interaction_time','mean'))
  .reset_index()
)
print(avg_interaction)

"""
Question 3
----------
Sort the aggregated results from Q2 to determine which number of search results per page has the highest average user interaction time. What is 
the optimal number of search results per page?
"""
# Remove duplicates
no_duplicates = user_engagement_data.drop_duplicates()

# Calculate the average user interaction time
avg_interaction = (
  no_duplicates.groupby('search_results_displayed')
  .agg(avg_interaction_time=('interaction_time','mean'))
  .reset_index()
)

# Sort the result to get the highest average user interaction time
sorted_avg_interaction = avg_interaction.sort_values(by='avg_interaction_time', ascending=False)
print(sorted_avg_interaction)
