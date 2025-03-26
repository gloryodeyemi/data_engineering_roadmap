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