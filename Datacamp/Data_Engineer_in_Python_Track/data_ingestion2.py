import pandas as pd
import matplotlib.pyplot as plt
"""
Import the create_engine() function from sqlalchemy.
Use create_engine() to make a database engine for data.db.
Run the last line of code to show the names of the tables in the database.
"""
# Import sqlalchemy's create_engine() function
from sqlalchemy import create_engine

# Create the database engine
engine = create_engine("sqlite:///data.db")

# View the tables in the database
print(engine.table_names())

"""
Use read_sql() to load the hpd311calls table by name, without any SQL.
Use read_sql() and a SELECT * ... SQL query to load the entire weather table.
"""
# Load hpd311calls without any SQL
hpd_calls = pd.read_sql('hpd311calls', engine)

# View the first few rows of data
print(hpd_calls.head())

# Create a SQL query to load the entire weather table
query = """
SELECT * 
  FROM weather;
"""

# Load weather with the SQL query
weather = pd.read_sql(query, engine)

# View the first few rows of data
print(weather.head())

"""
Create a database engine for data.db.
Write a SQL query that SELECTs the date, tmax, and tmin columns from the weather table.
Make a dataframe by passing the query and engine to read_sql() and assign the resulting dataframe to temperatures.
"""
# Create database engine for data.db
engine = create_engine("sqlite:///data.db")

# Write query to get date, tmax, and tmin from weather
query = """
SELECT date, 
       tmax, 
       tmin
  FROM weather;
"""

# Make a dataframe by passing query and engine to read_sql()
temperatures = pd.read_sql(query, engine)

# View the resulting dataframe
print(temperatures)

"""
Create a query that selects all columns of records in hpd311calls that have 'SAFETY' as their complaint_type.
Use read_sql() to query the database and assign the result to the variable safety_calls.
Run the last section of code to create a graph of safety call counts in each borough.
"""
# Create query to get hpd311calls records about safety
query = """
SELECT *
FROM hpd311calls
WHERE complaint_type = 'SAFETY';
"""

# Query the database and assign result to safety_calls
safety_calls = pd.read_sql(query, engine)

# Graph the number of safety calls by borough
call_counts = safety_calls.groupby('borough').unique_key.count()
call_counts.plot.barh()
plt.show()

"""
Create a query that selects records in weather where tmax is less than or equal to 32 degrees OR snow is greater than or equal to 1 inch.
Use read_sql() to query the database and assign the result to the variable wintry_days.
View summary statistics with the describe() method to make sure all records in the dataframe meet the given criteria.
"""
# Create query for records with max temps <= 32 or snow >= 1
query = """
SELECT *
  FROM weather
  WHERE tmax <= 32
    OR snow >= 1;
"""

# Query database and assign result to wintry_days
wintry_days = pd.read_sql(query, engine)

# View summary stats about the temperatures
print(wintry_days.describe())

"""
Create a query that gets DISTINCT values for borough and complaint_type (in that order) from hpd311calls.
Use read_sql() to load the results of the query to a dataframe, issues_and_boros.
Print the dataframe to check if the assumption that all issues besides literature requests appear with boroughs listed.
"""
# Create query for unique combinations of borough and complaint_type
query = """
SELECT DISTINCT borough, 
       complaint_type
  FROM hpd311calls;
"""

# Load results of query to a dataframe
issues_and_boros = pd.read_sql(query, engine)

# Check assumption about issues and boroughs
print(issues_and_boros)

"""
Create a SQL query that gets the complaint_type column and counts of all records from hpd311calls, grouped by complaint_type.
Create a dataframe with read_sql() of call counts by issue, calls_by_issue.
Run the last section of code to graph the number of calls for each housing issue.
"""
# Create query to get call counts by complaint_type
query = """
SELECT complaint_type, 
     COUNT(*)
  FROM hpd311calls
  GROUP BY complaint_type;
"""

# Create dataframe of call counts by issue
calls_by_issue = pd.read_sql(query, engine)

# Graph the number of calls for each housing issue
calls_by_issue.plot.barh(x="complaint_type")
plt.show()

"""
Create a query to pass to read_sql() that will get months and the MAX value of tmax by monthfrom weather.
Modify the query to also get the MIN tmin value for each month.
Modify the query to also get the total precipitation (prcp) for each month.
"""
# Create query to get temperature and precipitation by month
query = """
SELECT month, 
        MAX(tmax), 
        MIN(tmin),
        SUM(prcp)
  FROM weather 
 GROUP BY month;
"""

# Get dataframe of monthly weather stats
weather_by_month = pd.read_sql(query, engine)

# View weather stats by month
print(weather_by_month)

"""
Complete the query to join weather to hpd311calls by their date and created_date columns, respectively.
Query the database and assign the resulting dataframe to calls_with_weather.
Print the first few rows of calls_with_weather to confirm all columns were joined.
"""
# Query to join weather to call records by date columns
query = """
SELECT * 
  FROM hpd311calls
  JOIN weather 
  ON hpd311calls.created_date = weather.date;
"""

# Create dataframe of joined tables
calls_with_weather = pd.read_sql(query, engine)

# View the dataframe to make sure all columns were joined
print(calls_with_weather.head())

"""
Complete query to get the prcp column in weather and join weather to hpd311calls on their date and created_date columns, respectively.
Use read_sql() to load the results of the query into the leak_calls dataframe.
Modify query to get only rows that have 'WATER LEAK' as their complaint_type.
"""
# Query to get water leak calls and daily precipitation
query = """
SELECT hpd311calls.*, weather.prcp
  FROM hpd311calls
  JOIN weather
    ON hpd311calls.created_date = weather.date
  WHERE hpd311calls.complaint_type = 'WATER LEAK';"""

# Load query results into the leak_calls dataframe
leak_calls = pd.read_sql(query, engine)

# View the dataframe
print(leak_calls.head())

"""
Complete the query to get created_date and counts of records whose complaint_type is HEAT/HOT WATER from hpd311calls by date.
Create a dataframe,df, containing the results of the query.
Modify the query to join tmax and tmin from the weather table. (There is only one record per date in weather, so we do not need SQL's MAX 
and MIN functions here.) Join the tables on created_date in hpd311calls and date in weather.
"""
# Modify query to join tmax and tmin from weather by date
query = """
SELECT hpd311calls.created_date, 
	   COUNT(*), 
       weather.tmax,
       weather.tmin
  FROM hpd311calls 
       JOIN weather
       ON hpd311calls.created_date = weather.date
 WHERE hpd311calls.complaint_type = 'HEAT/HOT WATER' 
 GROUP BY hpd311calls.created_date;
 """

# Query database and save results as df
df = pd.read_sql(query, engine)

# View first 5 records
print(df.head())