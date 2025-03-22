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