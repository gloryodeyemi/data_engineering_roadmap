"""
Import the function create_engine from the module sqlalchemy.
Create an engine to connect to the SQLite database 'Chinook.sqlite' and assign it to engine.
"""
from sqlalchemy import create_engine

engine = create_engine('sqlite:///Chinook.sqlite')

"""
Import the function create_engine from the module sqlalchemy.
Create an engine to connect to the SQLite database 'Chinook.sqlite' and assign it to engine.
Using the method .table_names() on the engine engine, assign the table names of 'Chinook.sqlite' to the variable table_names.
Print the object table_names to the shell
"""
from sqlalchemy import create_engine

engine = create_engine('sqlite:///Chinook.sqlite')
table_names = engine.table_names()
print(table_names)

"""
Open the engine connection as con using the method .connect() on the engine.
Execute the query that selects ALL columns from the Album table. Store the results in rs.
Store all of your query results in the DataFrame df by applying the .fetchall() method to the results rs.
Close the connection!
"""
from sqlalchemy import create_engine
import pandas as pd

# Create engine
engine = create_engine('sqlite:///Chinook.sqlite')n
con = engine.connect()

# Perform query: rs
rs = con.execute("SELECT * FROM Album")

# Save results of the query to DataFrame: df
df = pd.DataFrame(rs.fetchall())

# Close connection
con.close()

# Print head of DataFrame df
print(df.head())

"""
Execute the SQL query that selects the columns LastName and Title from the Employee table. Store the results in the variable rs.
Apply the method fetchmany() to rs in order to retrieve 3 of the records. Store them in the DataFrame df.
Using the rs object, set the DataFrame's column names to the corresponding names of the table columns.
"""
with engine.connect() as con:
    rs = con.execute("SELECT LastName, Title FROM Employee")
    df = pd.DataFrame(rs.fetchmany(size=3))
    df.columns = rs.keys()

# Print the length and head of the DataFrame df
print(len(df))
print(df.head())

"""
Complete the argument of create_engine() so that the engine for the SQLite database 'Chinook.sqlite' is created.
Execute the query that selects all records from the Employee table where 'EmployeeId' is greater than or equal to 6. Use the >= operator and 
assign the results to rs.
Apply the method fetchall() to rs in order to fetch all records in rs. Store them in the DataFrame df.
Using the rs object, set the DataFrame's column names to the corresponding names of the table columns.
"""
engine = create_engine('sqlite:///Chinook.sqlite')

with engine.connect() as con:
    rs = con.execute("SELECT * FROM Employee WHERE EmployeeId >= 6")
    df = pd.DataFrame(rs.fetchall())
    df.columns = rs.keys()

# Print the head of the DataFrame df
print(df.head())

"""
Using the function create_engine(), create an engine for the SQLite database Chinook.sqlite and assign it to the variable engine.
In the context manager, execute the query that selects all records from the Employee table and orders them in increasing order by the column 
BirthDate. Assign the result to rs.
In a call to pd.DataFrame(), apply the method fetchall() to rs in order to fetch all records in rs. Store them in the DataFrame df.
Set the DataFrame's column names to the corresponding names of the table columns.
"""
engine = create_engine('sqlite:///Chinook.sqlite')

# Open engine in context manager
with engine.connect() as con:
    rs = con.execute("SELECT * FROM Employee ORDER BY BirthDate")
    df = pd.DataFrame(rs.fetchall())
    df.columns = rs.keys()

# Print head of DataFrame
print(df.head())
