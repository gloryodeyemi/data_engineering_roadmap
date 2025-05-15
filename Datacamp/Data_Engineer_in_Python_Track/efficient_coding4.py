"""
Use .iterrows() to loop over pit_df and print each row. Save the first item from .iterrows() as i and the second as row.
Add two lines to the loop: one before print(row) to print each index variable and one after to print each row's type.
Instead of using i and row in the for statement to store the output of .iterrows(), use one variable named row_tuple.
Add a line in the for loop to print the type of each row_tuple.
"""
for i,row in pit_df.iterrows():
    print(i)
    print(row)
    print(type(row))

for row_tuple in pit_df.iterrows():
    print(row_tuple)
    print(type(row_tuple))

"""
You've been hired by the San Francisco Giants as an analyst—congrats! The team's owner wants you to calculate a metric called the run differential 
for each season from the year 2008 to 2012. This metric is calculated by subtracting the total number of runs a team allowed in a season from the 
team's total number of runs scored in a season. 'RS' means runs scored and 'RA' means runs allowed.

The below function calculates this metric:
"""
def calc_run_diff(runs_scored, runs_allowed):

    run_diff = runs_scored - runs_allowed

    return run_diff

# Create an empty list called run_diffs that will be used to store the run differentials you will calculate.
run_diffs = []

# Write a for loop that uses .iterrows() to loop over giants_df and collects each row's runs scored and runs allowed.
for i,row in giants_df.iterrows():
    runs_scored = row['RS']
    runs_allowed = row['RA']

    # Add a line to the for loop that uses the provided function to calculate each row's run differential.
    run_diff = calc_run_diff(runs_scored, runs_allowed)

    # Add a line to the loop that appends each row's run differential to the run_diffs list.
    run_diffs.append(run_diff)

giants_df['RD'] = run_diffs
print(giants_df)

"""
Use .itertuples() to loop over rangers_df and print each row.
Loop over rangers_df with .itertuples() and save each row's Index, Year, and Wins (W) attribute as i, year, and wins.
Now, loop over rangers_df and print these values only for those rows where the Rangers made the playoffs.
"""
for row_tuples in rangers_df.itertuples():
  print(row_tuples)

# Loop over the DataFrame and print each row's Index, Year and Wins (W)
for row in rangers_df.itertuples():
  i = row.Index
  year = row.Year
  wins = row.W
  print(i, year, wins)

  # Check if rangers made Playoffs (1 means yes; 0 means no)
  if row.Playoffs == 1:
    print(i, year, wins)

# Use .itertuples() to loop over yankees_df and grab each row's runs scored and runs allowed values.
run_diffs = []

# Loop over the DataFrame and calculate each row's run differential
for row in yankees_df.itertuples():
    
    runs_scored = row.RS
    runs_allowed = row.RA

    run_diff = calc_run_diff(runs_scored, runs_allowed)
    
    run_diffs.append(run_diff)

# Append a new column called 'RD' to the yankees_df DataFrame that contains the run differentials you calculated.
yankees_df['RD'] = run_diffs
print(yankees_df)

