"""
Use the .strip() method to strip duration of "minutes" and store it in the duration_trim column.
Convert duration_trim to int and store it in the duration_time column.
Write an assert statement that checks if duration_time's data type is now an int.
Print the average ride duration.
"""


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