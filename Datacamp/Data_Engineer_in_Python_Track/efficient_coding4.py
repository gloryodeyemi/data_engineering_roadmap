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

"""
Analyzing baseball stats with .apply()
The Tampa Bay Rays want you to analyze their data.

They'd like the following metrics:
The sum of each column in the data
The total amount of runs scored in a year ('RS' + 'RA' for each year)
The 'Playoffs' column in text format rather than using 1's and 0's
The below function can be used to convert the 'Playoffs' column to text:
"""
def text_playoffs(num_playoffs): 
    if num_playoffs == 1:
        return 'Yes'
    else:
        return 'No' 
    
"""
Apply sum() to each column of rays_df to collect the sum of each column. Be sure to specify the correct axis.
Apply sum() to each row of rays_df, only looking at the 'RS' and 'RA' columns, and specify the correct axis.
Use .apply() and a lambda function to apply text_playoffs() to each row's 'Playoffs' value of the rays_df DataFrame.
"""
# Gather sum of all columns
stat_totals = rays_df.apply(sum, axis=0)
print(stat_totals)

# Gather total runs scored in all games per year
total_runs_scored = rays_df[['RS', 'RA']].apply(sum, axis=1)
print(total_runs_scored)

# Convert numeric playoffs to text by applying text_playoffs()
textual_playoffs = rays_df.apply(lambda row: text_playoffs(row['Playoffs']), axis=1)
print(textual_playoffs)

"""
Word has gotten to the Arizona Diamondbacks about your awesome analytics skills. They'd like for you to help settle a debate amongst the managers. 
One manager claims that the team has made the playoffs every year they have had a win percentage of 0.50 or greater. Another manager says this is 
not true.
Let's use the below function and the .apply() method to see which manager is correct.
"""
def calc_win_perc(wins, games_played):
    win_perc = wins / games_played
    return np.round(win_perc,2)

# Print the first five rows of the dbacks_df DataFrame to see what the data looks like.
print(dbacks_df.head())

# Create a pandas Series called win_percs by applying the calc_win_perc() function to each row of the DataFrame with a lambda function.
win_percs = dbacks_df.apply(lambda row: calc_win_perc(row['W'], row['G']), axis=1)
print(win_percs, '\n')

# Create a new column in dbacks_df called WP that contains the win percentages you calculated in the above step.
dbacks_df['WP'] = win_percs
print(dbacks_df, '\n')

# Display dbacks_df where WP is greater than 0.50
print(dbacks_df[dbacks_df['WP'] >= 0.50])

"""
Use the right method to collect the underlying 'W' and 'G' arrays of baseball_df and pass them directly into the calc_win_perc() function. 
Store the result as a variable called win_percs_np.
Create a new column in baseball_df called 'WP' that contains the win percentages you just calculated.
"""
# Use the W array and G array to calculate win percentages
win_percs_np = calc_win_perc(baseball_df['W'].values, baseball_df['G'].values)

# Append a new column to baseball_df that stores all win percentages
baseball_df['WP'] = win_percs_np

print(baseball_df.head())

"""
Use timeit in cell magic mode within your IPython console to compare the runtimes between the old code block using .iloc and the new code you 
developed using NumPy arrays.
"""
"""# %%timeit"""
win_percs_list = []
for i in range(len(baseball_df)):
    row = baseball_df.iloc[i]
    wins = row['W']
    games_played = row['G']
    win_perc = calc_win_perc(wins, games_played)
    win_percs_list.append(win_perc)
baseball_df['WP'] = win_percs_list

"""# %%timeit"""
win_percs_np = calc_win_perc(baseball_df['W'].values, baseball_df['G'].values)
baseball_df['WP'] = win_percs_np

"""
OrderedDict([('Team', 'Abbreviated team name'),
             ('League', 'Specifies National League or American League'),
             ('Year', "Each season's year"),
             ('RS', 'Runs scored in a season'),
             ('RA', 'Runs allowed in a season'),
             ('W', 'Wins in a season'),
             ('G', 'Games played in a season'),
             ('Playoffs', '`1` if a team made the playoffs; `0` if they did not'),
             ('WP', 'True win percentage for a season')])
"""
def predict_win_perc(RS, RA):
    prediction = RS ** 2 / (RS ** 2 + RA ** 2)
    return np.round(prediction, 2)

"""
Use a for loop and .itertuples() to predict the win percentage for each row of baseball_df with the predict_win_perc() function. 
Save each row's predicted win percentage as win_perc_pred and append each to the win_perc_preds_loop list.
"""
win_perc_preds_loop = []

# Use a loop and .itertuples() to collect each row's predicted win percentage
for row in baseball_df.itertuples():
    runs_scored = row.RS
    runs_allowed = row.RA
    win_perc_pred = predict_win_perc(runs_scored, runs_allowed)
    win_perc_preds_loop.append(win_perc_pred)

# Apply predict_win_perc to each row of the DataFrame
win_perc_preds_apply = baseball_df.apply(lambda row: predict_win_perc(row['RS'], row['RA']), axis=1)

# Calculate the win percentage predictions using NumPy arrays
win_perc_preds_np = predict_win_perc(baseball_df['RS'].values, baseball_df['RA'].values)
baseball_df['WP_preds'] = win_perc_preds_np
print(baseball_df.head())
