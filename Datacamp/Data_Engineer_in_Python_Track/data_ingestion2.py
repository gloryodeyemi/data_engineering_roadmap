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