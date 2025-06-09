"""
Import the pandas library as pd.
Use read_csv() to load vt_tax_data_2016.csv and assign it to the variable data.
View the first few lines of the dataframe with the head() method. This code has been written for you.
"""
# Import pandas as pd
import pandas as pd

# Read the CSV and assign it to the variable data
data = pd.read_csv("vt_tax_data_2016.csv")

# View the first few lines of data
print(data.head())

"""
Import pandas with the alias pd.
Load vt_tax_data_2016.tsv, making sure to set the correct delimiter with the sep keyword argument.
"""
# Import pandas with the alias pd
import pandas as pd

# Load TSV using the sep keyword argument to set delimiter
data = pd.read_csv('vt_tax_data_2016.tsv', sep='\t')

# Plot the total number of tax returns by income group
counts = data.groupby("agi_stub").N1.sum()
counts.plot.bar()
plt.show()

"""
Create a list of columns to use: zipcode, agi_stub (income group), mars1 (number of single households), MARS2 (number of households filing as 
married), and NUMDEP (number of dependents).
Create a dataframe from vt_tax_data_2016.csv that uses only the selected columns.
"""
# Create list of columns to use
cols = ["zipcode", "agi_stub", "mars1", "MARS2", "NUMDEP"]

# Create dataframe from csv using only selected columns
data = pd.read_csv("vt_tax_data_2016.csv", usecols=cols)

# View counts of dependents and tax returns by income level
print(data.groupby("agi_stub").sum())

"""
Use nrows and skiprows to make a dataframe, vt_data_next500, with the next 500 rows.
Set the header argument so that pandas knows there is no header row.
Name the columns in vt_data_next500 by supplying a list of vt_data_first500's columns to the names argument.
"""
# Create dataframe of next 500 rows with labeled columns
vt_data_next500 = pd.read_csv("vt_tax_data_2016.csv", 
                       		  nrows=500,
                       		  skiprows=500,
                       		  header=None,
                       		  names=list(vt_data_first500))

# View the Vermont dataframes to confirm they're different
print(vt_data_first500.head())
print(vt_data_next500.head())

"""
Load vt_tax_data_2016.csv with no arguments and view the dataframe's dtypes attribute. Note the data types of zipcode and agi_stub.
"""
# Load csv with no additional arguments
data = pd.read_csv("vt_tax_data_2016.csv")

# Print the data types
print(data.dtypes)

"""
Create a dictionary, data_types, specifying that agi_stub is "category" data and zipcode is string data.
Reload the CSV with the dtype argument and the dictionary to set the correct column data types.
View the dataframe's dtypes attribute.
"""
# Create dict specifying data types for agi_stub and zipcode
data_types = {"agi_stub":"category",
			  "zipcode":str}

# Load csv using dtype to set correct data types
data = pd.read_csv("vt_tax_data_2016.csv", dtype=data_types)

# Print data types of resulting frame
print(data.dtypes.head())

"""
Create a dictionary, null_values, specifying that 0s in the zipcode column should be considered NA values.
Load vt_tax_data_2016.csv, using the na_values argument and the dictionary to make sure invalid ZIP codes are treated as missing.
"""
# Create dict specifying that 0s in zipcode are NA values
null_values = {"zipcode": 0}

# Load csv using na_values keyword argument
data = pd.read_csv("vt_tax_data_2016.csv", 
                   na_values=null_values)

# View rows with NA ZIP codes
print(data[data.zipcode.isna()])

"""
Try to import the file vt_tax_data_2016_corrupt.csv without any keyword arguments.
Import vt_tax_data_2016_corrupt.csv with the error_bad_lines parameter set to skip bad records.
Update the import with the warn_bad_lines parameter set to issue a warning whenever a bad record is skipped.
"""
try:
  # Set warn_bad_lines to issue warnings about bad records
  data = pd.read_csv("vt_tax_data_2016_corrupt.csv", 
                     error_bad_lines=False, 
                     warn_bad_lines=True)
  
  # View first 5 records
  print(data.head())
  
except pd.errors.ParserError:
    print("Your data contained rows that could not be parsed.")