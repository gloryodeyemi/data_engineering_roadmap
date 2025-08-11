"""
Python Party Day 9: Instagram Stories Daily User Creation Patterns

You are a Product Analyst on the Instagram Stories team investigating story creation patterns. The team wants to understand the distribution of 
stories created by users daily. You will analyze user storytelling behavior to optimize engagement strategies.
"""

import pandas as pd

stories_data = pd.DataFrame()

"""
Question 1 of 3
---------------
Take a look at the data in the story_date column. Correct any data type inconsistencies in that column.
"""
# Convert date column to datetime, coerce invalid to NaT
stories_data['story_date'] = pd.to_datetime(
  stories_data['story_date'], 
  errors='coerce',
  infer_datetime_format=True
)

# Normalize user_id column 
stories_data['user_id'] = stories_data['user_id'].str.strip().str.lower()

# Drop missing values 
clean_data = stories_data.dropna().reset_index(drop=True)
print(clean_data)

"""
Question 2
----------
Calculate the 25th, 50th, and 75th percentiles of the number of stories created per user per day.
"""
# Get daily user stories
daily_user_stories = (
  clean_data.groupby(['user_id','story_date'])
  .agg(total_stories=('story_count','sum'))
  .reset_index()
)
print(f"Daily user stories:\n{daily_user_stories}")

# Calculate percentiles
percentiles = daily_user_stories['total_stories'].quantile([0.25, 0.5, 0.75])
print(f"\nPercentiles:\n{percentiles}")

"""
Question 3
----------
What percentage of users have had at least one day where they posted more than 10 stories on that day?
"""
# Number of users with > 10 stories in at least one day
high_stories_users = clean_data[clean_data['story_count'] > 10]['user_id'].unique()

# Calculate percentage
total_users = clean_data['user_id'].nunique()
percentage = (len(high_stories_users) / total_users) * 100

print(f"Total number of users: {total_users}")
print(f"Number of users with more than 10 stories: {len(high_stories_users)}")
print(f"Percentage of users with more than 10 stories: {percentage:.2f}%")