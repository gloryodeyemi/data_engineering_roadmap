"""
Define the add_tax lambda function to multiply the argument provided to it, x, by 1.2.
Call add_tax() on the sale_price variable."
"""
sale_price = 29.99
add_tax = lambda x: x * 1.2
print(add_tax(sale_price))

"""In a single line of code, make a lambda function that multiplies sale_price by 1.2 and returns the results"""
sale_price = 29.99
print((lambda x: x * 1.2)(sale_price))

"""
Create add_taxes, which multiplies each value in sales_prices by 20%.
Print a list using add_taxes to update values in sales_prices.
"""
sales_prices = [29.99, 9.95, 14.50, 39.75, 60.00]
add_taxes = map(lambda x: x * 1.2, sales_prices)
print(list(add_taxes))

"""
Use a keyword allowing you to attempt to run code that cleans text.
Swap a space for a single underscore in the text argument.
Use another keyword that prints a helpful message if an error occurs when calling the snake_case() function.
"""
def snake_case(text):
  try:
    clean_text = text.replace(" ", "_")
    clean_text = clean_text.lower()
  except:
    print("The snake_case() function expects a string as an argument, please check the data type provided.")
    
snake_case("User Name 187")

"""
Check whether the data type of the text argument is a string str.
Inside the else block, produce a TypeError() to prevent the script running and return a descriptive message.
"""
def snake_case(text):
  if type(text) == str:
    clean_text = text.replace(" ", "_")
    clean_text = clean_text.lower()
  else:
    raise TypeError("The snake_case() function expects a string as an argument, please check the data type provided.")
    
snake_case("User Name 187")