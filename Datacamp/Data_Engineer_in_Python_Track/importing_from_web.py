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

"""
Import the requests package.
Assign to the variable url the URL of interest in order to query 'http://www.omdbapi.com' for the data corresponding to the movie The 
Social Network. The query string should have two arguments: apikey=72bc447a and t=the+social+network. You can combine them as follows: 
apikey=72bc447a&t=the+social+network.
Print the text of the response object r by using its text attribute and passing the result to the print() function.
"""
import requests

url = 'http://www.omdbapi.com/?apikey=72bc447a&t=the+social+network'
r = requests.get(url)
print(r.text)

"""
Pass the variable url to the requests.get() function in order to send the relevant request and catch the response, assigning the resultant 
response message to the variable r.
Apply the json() method to the response object r and store the resulting dictionary in the variable json_data.
Hit submit to print the key-value pairs of the dictionary json_data to the shell.
"""
import requests

# Assign URL to variable: url
url = 'http://www.omdbapi.com/?apikey=72bc447a&t=social+network'
r = requests.get(url)
json_data = r.json()

for k in json_data.keys():
    print(k + ': ', json_data[k])

"""
Assign the relevant URL to the variable url.
Apply the json() method to the response object r and store the resulting dictionary in the variable json_data.
The variable pizza_extract holds the HTML of an extract from Wikipedia's Pizza page as a string; use the function print() to print this 
string to the shell.
"""
import requests

url = 'https://en.wikipedia.org/w/api.php?action=query&prop=extracts&format=json&exintro=&titles=pizza'
r = requests.get(url)

json_data = r.json()
pizza_extract = json_data['query']['pages']['24768']['extract']
print(pizza_extract)

"""
Create your Stream object with the credentials given.
Filter your Stream variable for the keywords "clinton", "trump", "sanders", and "cruz".
"""
# Store credentials in relevant variables
# Store credentials in relevant variables
consumer_key = ""
consumer_secret = ""
access_token = ""
access_token_secret = ""

# Create your Stream object with credentials
stream = tweepy.Stream(consumer_key, consumer_secret, access_token, access_token_secret)

# Filter your Stream variable
stream.filter(["clinton", "trump", "sanders", "cruz"])

"""
Assign the filename 'tweets.txt' to the variable tweets_data_path.
Initialize tweets_data as an empty list to store the tweets in.
Within the for loop initiated by for line in tweets_file:, load each tweet into a variable, tweet, using json.loads(), then append tweet to tweets_data using the append() method.
Hit submit and check out the keys of the first tweet dictionary printed to the shell.
"""
import json

tweets_data_path = 'tweets.txt'
tweets_data = []

# Open connection to file
tweets_file = open(tweets_data_path, "r")

# Read in tweets and store in list: tweets_data
for line in tweets_file:
    tweet = json.loads(line)
    tweets_data.append(tweet)

# Close connection to file
tweets_file.close()

# Print the keys of the first tweet dict
print(tweets_data[0].keys())

"""
Use pd.DataFrame() to construct a DataFrame of tweet texts and languages; to do so, the first argument should be tweets_data, a list of 
dictionaries. The second argument to pd.DataFrame() is a list of the keys you wish to have as columns. Assign the result of the 
pd.DataFrame() call to df.
Print the head of the DataFrame.
"""
import pandas as pd

# Build DataFrame of tweet texts and languages
df = pd.DataFrame(tweets_data, columns=["text", "lang"])
print(df.head())

"""
Within the for loop for index, row in df.iterrows():, the code currently increases the value of clinton by 1 each time a tweet (text row) 
mentioning 'Clinton' is encountered; complete the code so that the same happens for trump, sanders and cruz.
"""
[clinton, trump, sanders, cruz] = [0, 0, 0, 0]

for index, row in df.iterrows():
    clinton += word_in_text('clinton', row['text'])
    trump += word_in_text('trump', row['text'])
    sanders += word_in_text('sanders', row['text'])
    cruz += word_in_text('cruz', row['text'])

"""
Import both matplotlib.pyplot and seaborn using the aliases plt and sns, respectively.
Complete the arguments of sns.barplot:
The first argument should be the list of labels to appear on the x-axis (created in the previous step).
The second argument should be a list of the variables you wish to plot, as produced in the previous exercise (i.e. a list containing 
clinton, trump, etc).
"""
# Import packages
import matplotlib.pyplot as plt
import seaborn as sns

# Set seaborn style
sns.set(color_codes=True)

# Create a list of labels:cd
cd = ['clinton', 'trump', 'sanders', 'cruz']

# Plot the bar chart
ax = sns.barplot(cd, [clinton, trump, sanders, cruz])
ax.set(ylabel="count")
plt.show()
