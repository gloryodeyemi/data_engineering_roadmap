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

"""
Print the categories DataFrame and take a close look at all possible correct categories of the survey columns.
Print the unique values of the survey columns in airlines using the .unique() method.
"""
# Print categories DataFrame
print(categories)

# Print unique values of survey columns in airlines
print('Cleanliness: ', airlines['cleanliness'].unique(), "\n")
print('Safety: ', airlines['safety'].unique(), "\n")
print('Satisfaction: ', airlines['satisfaction'].unique(), "\n")

"""
Create a set out of the cleanliness column in airlines using set() and find the inconsistent category by finding the difference in the 
cleanliness column of categories.
Find rows of airlines with a cleanliness value not in categories and print the output.
Print the rows with the consistent categories of cleanliness only.
"""
# Find the cleanliness category in airlines not in categories
cat_clean = set(airlines['cleanliness']).difference(categories['cleanliness'])

# Find rows with that category
cat_clean_rows = airlines['cleanliness'].isin(cat_clean)

# Print rows with inconsistent category
print(airlines[cat_clean_rows])

# Print rows with consistent categories only
print(airlines[~cat_clean_rows])


"""
Change the capitalization of all values of dest_region to lowercase.
Replace the 'eur' with 'europe' in dest_region using the .replace() method.
Strip white spaces from the dest_size column using the .strip() method.
Verify that the changes have been into effect by printing the unique values of the columns using .unique() .
"""
# Print unique values of both columns
print(airlines['dest_region'].unique())
print(airlines['dest_size'].unique())

# Lower dest_region column and then replace "eur" with "europe"
airlines['dest_region'] = airlines['dest_region'].str.lower()
airlines['dest_region'] = airlines['dest_region'].replace({'eur':'europe'})

# Remove white spaces from `dest_size`
airlines['dest_size'] = airlines['dest_size'].str.strip()

# Verify changes have been effected
print(airlines['dest_region'].unique())
print(airlines['dest_size'].unique())

"""
Create the ranges and labels for the wait_type column mentioned in the description.
Create the wait_type column by from wait_min by using pd.cut(), while inputting label_ranges and label_names in the correct arguments.
Create the mapping dictionary mapping weekdays to 'weekday' and weekend days to 'weekend'.
Create the day_week column by using .replace().
"""
# Create ranges for categories
label_ranges = [0, 60, 180, np.inf]
label_names = ['short', 'medium', 'long']

# Create wait_type column
airlines['wait_type'] = pd.cut(airlines['wait_min'], bins = label_ranges, 
                                labels = label_names)

# Create mappings and replace
mappings = {'Monday':'weekday', 'Tuesday':'weekday', 'Wednesday': 'weekday', 
            'Thursday': 'weekday', 'Friday': 'weekday', 
            'Saturday': 'weekend', 'Sunday': 'weekend'}

airlines['day_week'] = airlines['day'].replace(mappings)