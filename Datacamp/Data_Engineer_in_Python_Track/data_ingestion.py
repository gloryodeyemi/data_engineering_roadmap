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