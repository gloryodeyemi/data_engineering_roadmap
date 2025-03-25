"""
Open the file moby_dick.txt as read-only using a with statement and bind it to the variable file. Make sure to pass the filename enclosed in quotation marks ''.
Print the contents of the file to the shell using the print() function. As Hugo showed in the video, you'll need to apply the method .read() to the object 
file and print the result.
"""
with open('moby_dick.txt', 'r') as file:
    print(file.read())

"""
Open moby_dick.txt using the with context manager and the variable file.
Print the first three lines of the file to the shell by using .readline() three times within the context manager.
"""
with open('moby_dick.txt') as file:
    print(file.readline())
    print(file.readline())
    print(file.readline())

"""
Fill in the arguments of np.loadtxt() by passing file and a comma ',' for the delimiter.
Fill in the argument of print() to print the type of the object digits. Use the function type().
Execute the rest of the code to visualize one of the rows of the data.
"""
import numpy as np

file = 'digits.csv'
digits = np.loadtxt(file, delimiter=',')
print(type(digits))

# Select and reshape a row
im = digits[21, 1:]
im_sq = np.reshape(im, (28, 28))

# Plot reshaped data (matplotlib.pyplot already loaded as plt)
plt.imshow(im_sq, cmap='Greys', interpolation='nearest')
plt.show()

"""
Complete the arguments of np.loadtxt(): the file you're importing is tab-delimited, you want to skip the first row and you only want to import the first and third columns.
Complete the argument of the print() call in order to print the entire array that you just imported.
"""
import numpy as np

file = 'digits_header.txt'
data = np.loadtxt(file, delimiter='\t', skiprows=1, usecols=[0, 2])
print(data)

"""
Complete the first call to np.loadtxt() by passing file as the first argument.
Execute print(data[0]) to print the first element of data.
Complete the second call to np.loadtxt(). The file you're importing is tab-delimited, the datatype is float, and you want to skip the first row.
Print the 10th element of data_float by completing the print() command. Be guided by the previous print() call.
Execute the rest of the code to visualize the data.
"""
data = np.loadtxt(file, delimiter='\t', dtype=str)
print(data[0])

data_float = np.loadtxt(file, delimiter='\t', dtype=float, skiprows=1)
print(data_float[9])

# Plot a scatterplot of the data
plt.scatter(data_float[:, 0], data_float[:, 1])
plt.xlabel('time (min.)')
plt.ylabel('percentage of larvae')
plt.show()

"""
Import the pandas package using the alias pd.
Read titanic.csv into a DataFrame called df. The file name is already stored in the file object.
In a print() call, view the head of the DataFrame.
"""
import pandas as pd

file = 'titanic.csv'
df = pd.read_csv(file)
print(df.head())

"""
Import the first 5 rows of the file into a DataFrame using the function pd.read_csv() and assign the result to data. You'll need to use the arguments nrows and header. 
Note that there is no header row in this file.
Build a numpy array from the resulting DataFrame in data and assign to data_array.
Execute print(type(data_array)) to print the datatype of data_array.
"""
file = 'digits.csv'
data = pd.read_csv(file, nrows=5, header=None)
data_array = data.to_numpy()
print(type(data_array))

"""
Complete the arguments of pd.read_csv() to import titanic_corrupt.txt correctly using pandas:
    - sep sets the delimiter to use, and works the same way as np.loadtxt()'s delimiter argument. Note that the file you're importing is tab-delimited.
    - comment takes characters that comments occur after in the file, which in this case is '#'.
    - na_values takes a list of strings to be treated as NA/NaN, in this case the string 'Nothing'.
Execute the rest of the code to print the head of the resulting DataFrame and plot the histogram of the 'Age' of passengers aboard the Titanic.
"""
import matplotlib.pyplot as plt

file = 'titanic_corrupt.txt'
data = pd.read_csv(file, sep='\t', comment='#', na_values=['Nothing'])
print(data.head())

# Plot 'Age' variable in a histogram
pd.DataFrame.hist(data[['Age']])
plt.xlabel('Age (years)')
plt.ylabel('count')
plt.show()

"""
Import the pickle package.
Complete the second argument of open() so that it is read only for a binary file. This argument will be a string of two letters, one signifying 'read only', the other 'binary'.
Pass the correct argument to pickle.load(); it should use the variable that is bound to open.
Print the data, d.
Print the datatype of d; take your mind back to your previous use of the function type().
"""
import pickle
with open('data.pkl', 'rb') as file:
    d = pickle.load(file)
print(d)
print(type(d))

"""
Assign the spreadsheet filename (provided above) to the variable file.
Pass the correct argument to pd.ExcelFile() to load the file using pandas, assigning the result to the variable xls.
Print the sheetnames of the Excel spreadsheet by passing the necessary argument to the print() function.
"""
import pandas as pd
file = 'battledeath.xlsx'
xls = pd.ExcelFile(file)
print(xls.sheet_names)

"""
Load the sheet '2004' into the DataFrame df1 using its name as a string.
Print the head of df1 to the shell.
Load the sheet 2002 into the DataFrame df2 using its index (0).
Print the head of df2 to the shell.
"""
df1 = xls.parse('2004')
print(df1.head())
df2 = xls.parse(0)
print(df2.head())

"""
Parse the first sheet by index. In doing so, skip the first row of data and name the columns 'Country' and 'AAM due to War (2002)' using the 
argument names. The values passed to skiprows and names all need to be of type list.
Parse the second sheet by index. In doing so, parse only the first column with the usecols parameter, skip the first row and rename the 
column 'Country'. The argument passed to usecols also needs to be of type list.
"""
df1 = xls.parse(0, skiprows=1, names=['Country', 'AAM due to War (2002)'])
print(df1.head())
df2 = xls.parse(1, usecols=[0], skiprows=1, names=['Country'])
print(df2.head())

"""
Import the module SAS7BDAT from the library sas7bdat.
In the context of the file 'sales.sas7bdat', load its contents to a DataFrame df_sas, using the method .to_data_frame() on the object file.
Print the head of the DataFrame df_sas.
Execute your entire script to produce a histogram plot!
"""
from sas7bdat import SAS7BDAT

with SAS7BDAT('sales.sas7bdat') as file:
    df_sas = file.to_data_frame()

print(df_sas.head())

# Plot histogram of DataFrame features (pandas and pyplot already imported)
pd.DataFrame.hist(df_sas[['P']])
plt.ylabel('count')
plt.show()

"""
Use pd.read_stata() to load the file 'disarea.dta' into the DataFrame df.
Print the head of the DataFrame df.
Visualize your results by plotting a histogram of the column disa10. We’ve already provided this code for you, so just run it!
"""
import pandas as pd

df = pd.read_stata('disarea.dta')
print(df.head())

# Plot histogram of one column of the DataFrame
pd.DataFrame.hist(df[['disa10']])
plt.xlabel('Extent of disease')
plt.ylabel('Number of countries')
plt.show()

"""
Import the package h5py.
Assign the name of the file to the variable file.
Load the file as read only into the variable data.
Print the datatype of data.
Print the names of the groups in the HDF5 file 'LIGO_data.hdf5'.
"""
import numpy as np
import h5py

file = 'LIGO_data.hdf5'
data = h5py.File(file, 'r')
print(type(data))

# Print the keys of the file
for key in data.keys():
    print(key)

"""
Assign the HDF5 group data['strain'] to group.
In the for loop, print out the keys of the HDF5 group in group.
Assign the time series data data['strain']['Strain'] to a NumPy array called strain.
Set num_samples equal to 10000, the number of time points we wish to sample.
Execute the rest of the code to produce a plot of the time series data in LIGO_data.hdf5.
"""
group = data['strain']

# Check out keys of group
for key in group.keys():
    print(key)

# Set variable equal to time series data: strain
strain = np.array(data['strain']['Strain'])

# Set number of time points to sample: num_samples
num_samples = 10000

# Set time vector
time = np.arange(0, 1, 1/num_samples)

# Plot data
plt.plot(time, strain[:num_samples])
plt.xlabel('GPS Time (s)')
plt.ylabel('strain')
plt.show()