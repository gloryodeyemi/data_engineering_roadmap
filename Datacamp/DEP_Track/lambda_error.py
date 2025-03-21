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