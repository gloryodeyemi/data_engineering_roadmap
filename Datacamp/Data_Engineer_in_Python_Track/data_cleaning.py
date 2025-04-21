"""
Use the .strip() method to strip duration of "minutes" and store it in the duration_trim column.
Convert duration_trim to int and store it in the duration_time column.
Write an assert statement that checks if duration_time's data type is now an int.
Print the average ride duration.
"""
ride_sharing['duration_trim'] = ride_sharing['duration'].str.strip("minutes")
ride_sharing['duration_time'] = ride_sharing['duration_trim'].astype('int')
assert ride_sharing['duration_time'].dtype == 'int'

# Print formed columns and calculate average ride duration 
print(ride_sharing[['duration','duration_trim','duration_time']])
print(ride_sharing['duration_time'].mean())

"""
Convert the tire_sizes column from category to 'int'.
Use .loc[] to set all values of tire_sizes above 27 to 27.
Reconvert back tire_sizes to 'category' from int.
Print the description of the tire_sizes.
"""
ride_sharing['tire_sizes'] = ride_sharing['tire_sizes'].astype('int')
ride_sharing.loc[ride_sharing['tire_sizes'] > 27, 'tire_sizes'] = 27
ride_sharing['tire_sizes'] = ride_sharing['tire_sizes'].astype('category')
print(ride_sharing['tire_sizes'].describe())

"""
Convert ride_date to a datetime object using to_datetime(), then convert the datetime object into a date and store it in ride_dt column.
Create the variable today, which stores today's date by using the dt.date.today() function.
For all instances of ride_dt in the future, set them to today's date.
Print the maximum date in the ride_dt column.
"""
ride_sharing['ride_dt'] = pd.to_datetime(ride_sharing['ride_date']).dt.date
today = dt.date.today()
ride_sharing.loc[ride_sharing['ride_dt'] > today, 'ride_dt'] = today
print(ride_sharing['ride_dt'].max())

"""
Find duplicated rows of ride_id in the ride_sharing DataFrame while setting keep to False.
Subset ride_sharing on duplicates and sort by ride_id and assign the results to duplicated_rides.
Print the ride_id, duration and user_birth_year columns of duplicated_rides in that order.
"""
duplicates = ride_sharing.duplicated(subset=['ride_id'], keep=False)
duplicated_rides = ride_sharing[duplicates].sort_values(by='ride_id')
print(duplicated_rides[['ride_id','duration','user_birth_year']])

"""
Drop complete duplicates in ride_sharing and store the results in ride_dup.
Create the statistics dictionary which holds minimum aggregation for user_birth_year and mean aggregation for duration.
Drop incomplete duplicates by grouping by ride_id and applying the aggregation in statistics.
Find duplicates again and run the assert statement to verify de-duplication.
"""
# Drop complete duplicates from ride_sharing
ride_dup = ride_sharing.drop_duplicates()

# Create statistics dictionary for aggregation function
statistics = {'user_birth_year': 'min', 'duration': 'mean'}

# Group by ride_id and compute new statistics
ride_unique = ride_dup.groupby('ride_id').agg(statistics).reset_index()

# Find duplicated values again
duplicates = ride_unique.duplicated(subset = 'ride_id', keep = False)
duplicated_rides = ride_unique[duplicates == True]

# Assert duplicates are processed
assert duplicated_rides.shape[0] == 0