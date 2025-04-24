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

"""
Remove "Dr.", "Mr.", "Miss" and "Ms." from full_name by replacing them with an empty string "" in that order.
Run the assert statement using .str.contains() that tests whether full_name still contains any of the honorifics.
"""
# Replace "Dr." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Dr.","")

# Replace "Mr." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Mr.","")

# Replace "Miss" with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Miss","")

# Replace "Ms." with empty string ""
airlines['full_name'] = airlines['full_name'].str.replace("Ms.","")

# Assert that full_name has no honorifics
assert airlines['full_name'].str.contains('Ms.|Mr.|Miss|Dr.').any() == False

"""
Using the airlines DataFrame, store the length of each instance in the survey_response column in resp_length by using .str.len().
Isolate the rows of airlines with resp_length higher than 40.
Assert that the smallest survey_response length in airlines_survey is now bigger than 40.
"""
# Store length of each row in survey_response column
resp_length = airlines['survey_response'].str.len()

# Find rows in airlines where resp_length > 40
airlines_survey = airlines[resp_length > 40]

# Assert minimum survey_response length is > 40
assert airlines_survey['survey_response'].str.len().min() > 40

# Print new survey_response column
print(airlines_survey['survey_response'])

"""
Find the rows of acct_cur in banking that are equal to 'euro' and store them in the variable acct_eu.
Find all the rows of acct_amount in banking that fit the acct_eu condition, and convert them to USD by multiplying them with 1.1.
Find all the rows of acct_cur in banking that fit the acct_eu condition, set them to 'dollar'.
"""
# Find values of acct_cur that are equal to 'euro'
acct_eu = banking['acct_cur'] == 'euro'

# Convert acct_amount where it is in euro to dollars
banking.loc[acct_eu, 'acct_amount'] = banking.loc[acct_eu, 'acct_amount'] * 1.1

# Unify acct_cur column by changing 'euro' values to 'dollar'
banking.loc[acct_eu, 'acct_cur'] = 'dollar'

# Assert that only dollar currency remains
assert banking['acct_cur'].unique() == 'dollar'

"""
Convert the account_opened column to datetime, while making sure the date format is inferred and that erroneous formats that raise error 
return a missing value.
Extract the year from the amended account_opened column and assign it to the acct_year column.
Print the newly created acct_year column.
"""
banking['account_opened'] = pd.to_datetime(banking['account_opened'],
                                           # Infer datetime format
                                           infer_datetime_format = True,
                                           # Return missing value for error
                                           errors = 'coerce') 

# Get year of account opened
banking['acct_year'] = banking['account_opened'].dt.strftime('%Y')

# Print acct_year
print(banking['acct_year'])

"""
Find the rows where the sum of all rows of the fund_columns in banking are equal to the inv_amount column.
Store the values of banking with consistent inv_amount in consistent_inv, and those with inconsistent ones in inconsistent_inv.
"""
# Store fund columns to sum against
fund_columns = ['fund_A', 'fund_B', 'fund_C', 'fund_D']

# Find rows where fund_columns row sum == inv_amount
inv_equ = banking[['fund_A', 'fund_B', 'fund_C', 'fund_D']].sum(axis=1) == banking['inv_amount']

# Store consistent and inconsistent data
consistent_inv = banking[inv_equ]
inconsistent_inv = banking[~inv_equ]

# Store consistent and inconsistent data
print("Number of inconsistent investments: ", inconsistent_inv.shape[0])

"""
Store today's date into today, and manually calculate customers' ages and store them in ages_manual.
Find all rows of banking where the age column is equal to ages_manual and then filter banking into consistent_ages and inconsistent_ages.
"""
# Store today's date and find ages
today = dt.date.today()
ages_manual = today.year - banking['birth_date'].dt.year

# Find rows where age column == ages_manual
age_equ = banking['age'] == ages_manual

# Store consistent and inconsistent data
consistent_ages = banking[age_equ]
inconsistent_ages = banking[~age_equ]

# Store consistent and inconsistent data
print("Number of inconsistent ages: ", inconsistent_ages.shape[0])

"""
Print the number of missing values by column in the banking DataFrame.
Plot and show the missingness matrix of banking with the msno.matrix() function.
Isolate the values of banking missing values of inv_amount into missing_investors and with non-missing inv_amount values into investors.
Sort the banking DataFrame by the age column and plot the missingness matrix of banking_sorted.
"""
print(banking.isna().sum())

# Visualize missingness matrix
msno.matrix(banking)
plt.show()

# Isolate missing and non missing values of inv_amount
missing_investors = banking[banking['inv_amount'].isna()]
investors = banking[~banking['inv_amount'].isna()]

# Sort banking by age and visualize
banking_sorted = banking.sort_values(by='age')
msno.matrix(banking_sorted)
plt.show()

"""
Use .dropna() to drop missing values of the cust_id column in banking and store the results in banking_fullid.
Use inv_amount to compute the estimated account amounts for banking_fullid by setting the amounts equal to inv_amount * 5, and assign the 
results to acct_imp.
Impute the missing values of acct_amount in banking_fullid with the newly created acct_imp using .fillna().
"""
# Drop missing values of cust_id
banking_fullid = banking.dropna(subset=['cust_id'])

# Compute estimated acct_amount
acct_imp = banking_fullid['inv_amount'] * 5

# Impute missing acct_amount with corresponding acct_imp
banking_imputed = banking_fullid.fillna({'acct_amount': acct_imp})

# Print number of missing values
print(banking_imputed.isna().sum())

"""
Import process from thefuzz.
Store the unique cuisine_types into unique_types.
Calculate the similarity of 'asian', 'american', and 'italian' to all possible cuisine_types using process.extract(), while returning all 
possible matches.
"""
# Import process from thefuzz
from thefuzz import process

# Store the unique values of cuisine_type in unique_types
unique_types = restaurants['cuisine_type'].unique()

# Calculate similarity of 'asian' to all values of unique_types
print(process.extract('asian', unique_types, limit = len(unique_types)))

# Calculate similarity of 'american' to all values of unique_types
print(process.extract('american', unique_types, limit = len(unique_types)))

# Calculate similarity of 'italian' to all values of unique_types
print(process.extract('italian', unique_types, limit = len(unique_types)))

"""
As a first step, create a list of all possible matches, comparing 'italian' with the restaurant types listed in the cuisine_type column.
"""
# Create a list of matches, comparing 'italian' with the cuisine_type column
matches = process.extract('italian', restaurants['cuisine_type'], limit=len(restaurants))
print(matches[0:5])

"""
Within the for loop, use an if statement to check whether the similarity score in each match is greater than or equal to 80.
If it is, use .loc to select rows where cuisine_type in restaurants is equal to the current match (which is the first element of match), and 
reassign them to be 'italian'.
"""
# Create a list of matches, comparing 'italian' with the cuisine_type column
matches = process.extract('italian', restaurants['cuisine_type'], limit=len(restaurants.cuisine_type))

# Iterate through the list of matches to italian
for match in matches:
  # Check whether the similarity score is greater than or equal to 80
  if match[1] >= 80:
    # Select all rows where the cuisine_type is spelled this way, and set them to the correct cuisine
    restaurants.loc[restaurants['cuisine_type'] == match[0], 'cuisine_type'] = 'italian'


"""
Using the variable cuisine to iterate through categories, embed your code from the previous step in an outer for loop.
"""
# Iterate through categories
for cuisine in categories:  
  # Create a list of matches, comparing cuisine with the cuisine_type column
  matches = process.extract(cuisine, restaurants['cuisine_type'], limit=len(restaurants.cuisine_type))

  # Iterate through the list of matches
  for match in matches:
     # Check whether the similarity score is greater than or equal to 80
    if match[1] >= 80:
      # If it is, select all rows where the cuisine_type is spelled this way, and set them to the correct cuisine
      restaurants.loc[restaurants['cuisine_type'] == match[0]] = cuisine
      
# Inspect the final result
print(restaurants['cuisine_type'].unique())

"""
Instantiate an indexing object by using the Index() function from recordlinkage.
Block your pairing on cuisine_type by using indexer's' .block() method.
Generate pairs by indexing restaurants and restaurants_new in that order.
"""
# Create an indexer and object and find possible pairs
indexer = recordlinkage.Index()

# Block pairing on cuisine_type
indexer.block('cuisine_type')

# Generate pairs
pairs = indexer.index(restaurants, restaurants_new)

"""
Instantiate a comparison object using the recordlinkage.Compare() function.
Use the appropriate comp_cl method to find exact matches between the city and cuisine_type columns of both DataFrames.
Use the appropriate comp_cl method to find similar strings with a 0.8 similarity threshold in the rest_name column of both DataFrames.
Compute the comparison of the pairs by using the .compute() method of comp_cl.
"""
# Create a comparison object
comp_cl = recordlinkage.Compare()

# Create a comparison object
comp_cl = recordlinkage.Compare()

# Find exact matches on city, cuisine_types 
comp_cl.exact('city', 'city', label='city')
comp_cl.exact('cuisine_type', 'cuisine_type', label = 'cuisine_type')

# Find similar matches of rest_name
comp_cl.string('rest_name', 'rest_name', label='name', threshold = 0.8) 

# Get potential matches and print
potential_matches = comp_cl.compute(pairs, restaurants, restaurants_new)
print(potential_matches)

"""
Isolate instances of potential_matches where the row sum is above or equal to 3 by using the .sum() method.
Extract the second column index from matches, which represents row indices of matching record from restaurants_new by using the .get_level_values() method.
Subset restaurants_new for rows that are not in matching_indices.
Append non_dup to restaurants.
"""
# Isolate potential matches with row sum >=3
matches = potential_matches[potential_matches.sum(axis = 1) >= 3]

# Get values of second column index of matches
matching_indices = matches.index.get_level_values(1)

# Subset restaurants_new based on non-duplicate values
non_dup = restaurants_new[~restaurants_new.index.isin(matching_indices)]

# Append non_dup to restaurants
full_restaurants = restaurants.append(non_dup)
print(full_restaurants)