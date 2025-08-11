"""
Python Party Day 10: App Store Ratings Performance by App Category

You are a Product Analyst for the Apple App Store team investigating app ratings data. Your focus is to clean and understand rating distributions 
across different app categories. The team wants to leverage basic statistical insights to guide app performance strategies.
"""

import pandas as pd

app_ratings = pd.DataFrame()

"""
Question 1 of 3
---------------
There are some data inconsistencies in the 'rating' column, specifically: leading or trailing white space, decimals represented by commas instead 
of decimal points (eg. 4,2 instead of 4.2), and non-numeric values. Clean up these data issues and convert the column to a numeric data type.
"""
# Remove leading and trailing whitespace
cleaned_ratings = app_ratings.copy()
cleaned_ratings['rating'] = cleaned_ratings['rating'].str.strip()

# Fix decimal separators
cleaned_ratings['rating'] = cleaned_ratings['rating'].str.replace(",", ".")

# Convert the cleaned strings to numeric values
cleaned_ratings['rating'] = pd.to_numeric(cleaned_ratings['rating'], errors='coerce')
print(cleaned_ratings)

"""
Question 2
----------
Using the cleaned dataset, display the first and last five entries to get an overview of the app ratings across different categories.
"""
# Display the first and last five entries of the cleaned data
print(f"First five entries:\n{cleaned_ratings.head()}")
print(f"\nLast five entries:\n{cleaned_ratings.tail()}")

"""
Question 3
----------
Calculate the basic summary statistics (mean, median, standard deviation) of app ratings for each category to identify variations and performance 
patterns.
"""
# Calculate the basic summary statistics
summary_stats = cleaned_ratings.groupby('category')['rating'].agg(
    mean_rating='mean',
    median_rating='median',
    std_rating='std'
).reset_index()

print(summary_stats)
