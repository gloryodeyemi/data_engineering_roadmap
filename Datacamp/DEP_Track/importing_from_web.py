"""
Import the function urlretrieve from the subpackage urllib.request.
Assign the URL of the file to the variable url.
Use the function urlretrieve() to save the file locally as 'winequality-red.csv'.
Execute the remaining code to load 'winequality-red.csv' in a pandas DataFrame and to print its head to the shell.
"""
from urllib.request import urlretrieve
import pandas as pd

url = 'https://assets.datacamp.com/production/course_1606/datasets/winequality-red.csv'
urlretrieve(url, 'winequality-red.csv')

# Read file into a DataFrame and print its head
df = pd.read_csv('winequality-red.csv', sep=';')
print(df.head())

"""
Assign the URL of the file to the variable url.
Read file into a DataFrame df using pd.read_csv(), recalling that the separator in the file is ';'.
Print the head of the DataFrame df.
Execute the rest of the code to plot histogram of the first feature in the DataFrame df.
"""
import matplotlib.pyplot as plt
import pandas as pd

url = 'https://assets.datacamp.com/production/course_1606/datasets/winequality-red.csv'

df = pd.read_csv(url, ';')
print(df.head())

# Plot first column of df
df.iloc[:, 0].hist()
plt.xlabel('fixed acidity (g(tartaric acid)/dm$^3$)')
plt.ylabel('count')
plt.show()

"""
Assign the URL of the file to the variable url.
Read the file in url into a dictionary xls using pd.read_excel() recalling that, in order to import all sheets you need to pass None to the 
argument sheet_name.
Print the names of the sheets in the Excel spreadsheet; these will be the keys of the dictionary xls.
Print the head of the first sheet using the sheet name, not the index of the sheet! The sheet name is '1700'
"""
import pandas as pd

url = 'https://assets.datacamp.com/course/importing_data_into_r/latitude.xls'

xls = pd.read_excel(url, sheet_name=None)
print(xls.keys())
print(xls['1700'].head())

"""
Import the functions urlopen and Request from the subpackage urllib.request.
Package the request to the url "https://campus.datacamp.com/courses/1606/4135?ex=2" using the function Request() and assign it to request.
Send the request and catch the response in the variable response with the function urlopen().
Run the rest of the code to see the datatype of response and to close the connection!
"""
from urllib.request import urlopen, Request

# Specify the url
url = "https://campus.datacamp.com/courses/1606/4135?ex=2"

# This packages the request: request
request = Request(url)

# Sends the request and catches the response: response
response = urlopen(request)
print(type(response))
response.close()

"""
Send the request and catch the response in the variable response with the function urlopen(), as in the previous exercise.
Extract the response using the read() method and store the result in the variable html.
Print the string html.
Hit submit to perform all of the above and to close the response: be tidy!
"""
from urllib.request import urlopen, Request

url = "https://campus.datacamp.com/courses/1606/4135?ex=2"
request = Request(url)
response = urlopen(request)

html = response.read()
print(html)
response.close()

"""
Import the package requests.
Assign the URL of interest to the variable url.
Package the request to the URL, send the request and catch the response with a single function requests.get(), assigning the response to the 
variable r.
Use the text attribute of the object r to return the HTML of the webpage as a string; store the result in a variable text.
Hit submit to print the HTML of the webpage.
"""
import requests

url = "http://www.datacamp.com/teach/documentation"
r = requests.get(url)

text = r.text
print(text)

"""
Import the function BeautifulSoup from the package bs4.
Assign the URL of interest to the variable url.
Package the request to the URL, send the request and catch the response with a single function requests.get(), assigning the response to the 
variable r.
Use the text attribute of the object r to return the HTML of the webpage as a string; store the result in a variable html_doc.
Create a BeautifulSoup object soup from the resulting HTML using the function BeautifulSoup().
Use the method prettify() on soup and assign the result to pretty_soup.
Hit submit to print to prettified HTML to your shell!
"""
# Import packages
import requests
from bs4 import BeautifulSoup

# Specify url: url
url = 'https://www.python.org/~guido/'
r = requests.get(url)

# Extracts the response as html: html_doc
html_doc = r.text
soup = BeautifulSoup(html_doc)
pretty_soup = soup.prettify()
print(pretty_soup)

"""
In the sample code, the HTML response object html_doc has already been created: your first task is to Soupify it using the function 
BeautifulSoup() and to assign the resulting soup to the variable soup.
Extract the title from the HTML soup soup using the attribute title and assign the result to guido_title.
Print the title of Guido's webpage to the shell using the print() function.
Extract the text from the HTML soup soup using the method get_text() and assign to guido_text.
Hit submit to print the text from Guido's webpage to the shell.
Use the method find_all() to find all hyperlinks in soup, remembering that hyperlinks are defined by the HTML tag <a> but passed to 
find_all() without angle brackets; store the result in the variable a_tags.
The variable a_tags is a results set: your job now is to enumerate over it, using a for loop and to print the actual URLs of the hyperlinks; 
to do this, for every element link in a_tags, you want to print() link.get('href').
"""
import requests
from bs4 import BeautifulSoup

# Specify url: url
url = 'https://www.python.org/~guido/'
r = requests.get(url)
html_doc = r.text

soup = BeautifulSoup(html_doc)
guido_title = soup.title
print(guido_title)

guido_text = soup.text
print(guido_text)

a_tags = soup.find_all('a')

for link in a_tags:
    print(link.get('href'))

"""
Load the JSON 'a_movie.json' into the variable json_data within the context provided by the with statement. To do so, use the function 
json.load() within the context manager.
Use a for loop to print all key-value pairs in the dictionary json_data. Recall that you can access a value in a dictionary using the 
syntax: dictionary[key].
"""
# Load JSON: json_data
with open("a_movie.json") as json_file:
    json_data = json.load(json_file)

# Print each key-value pair in json_data
for k in json_data.keys():
    print(k + ': ', json_data[k])