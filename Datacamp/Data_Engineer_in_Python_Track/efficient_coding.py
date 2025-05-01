names = ['Jerry', 'Kramer', 'Elaine', 'George', 'Newman']

# Print the list, new_list, that was created using a Non-Pythonic approach.
i = 0
new_list= []
while i < len(names):
    if len(names[i]) >= 6:
        new_list.append(names[i])
    i += 1
print(new_list)

# A more Pythonic approach would loop over the contents of names, rather than using an index variable. Print better_list.
better_list = []
for name in names:
    if len(name) >= 6:
        better_list.append(name)
print(better_list)

# The best Pythonic way of doing this is by using list comprehension. Print best_list.
best_list = [name for name in names if len(name) >= 6]
print(best_list)

"""
Create a range object that starts at zero and ends at five. Only use a stop argument.
Convert the nums variable into a list called nums_list.
Create a new list called nums_list2 that starts at one, ends at eleven, and increments by two by unpacking a range object using the star character (*).
"""
nums = range(6)
print(type(nums))

# Convert nums to a list
nums_list = list(nums)
print(nums_list)

# Create a new list of odd numbers from 1 to 11 by unpacking a range object
nums_list2 = [*range(1,12,2)]
print(nums_list2)

"""
Instead of using for i in range(len(names)), update the for loop to use i as the index variable and name as the iterator variable and use enumerate().
Rewrite the previous for loop using enumerate() and list comprehension to create a new list, indexed_names_comp.
Create another list (indexed_names_unpack) by using the star character (*) to unpack the enumerate object created from using enumerate() on names. This time, start the 
index for enumerate() at one instead of zero.
"""
# Rewrite the for loop to use enumerate
indexed_names = []
for i,name in enumerate(names):
    index_name = (i,name)
    indexed_names.append(index_name) 
print(indexed_names)

# Rewrite the above for loop using list comprehension
indexed_names_comp = [(i,name) for i,name in enumerate(names)]
print(indexed_names_comp)

# Unpack an enumerate object with a starting index of one
indexed_names_unpack = [*enumerate(names, 1)]
print(indexed_names_unpack)

"""
Use map() and the method str.upper() to convert each name in the list names to uppercase. Save this to the variable names_map.
Print the data type of names_map.
Unpack the contents of names_map into a list called names_uppercase using the star character (*).
Print names_uppercase and observe its contents.
"""
# Use map to apply str.upper to each element in names
names_map  = map(str.upper, names)

# Print the type of the names_map
print(type(names_map))

# Unpack names_map into a list
names_uppercase = [*list(names_map)]

# Print the list created above
print(names_uppercase)

"""
Print the second row of nums.
Print the items of nums that are greater than six.
Create nums_dbl that doubles each number in nums.
Replace the third column in nums with a new column that adds 1 to each item in the original column.
"""
import numpy as np

nums = np.arange(1, 11).reshape(2, 5)

# Print second row of nums
print(nums[1])

# Print all elements of nums that are greater than six
print(nums[nums > 6])

# Double every element of nums
nums_dbl = nums * 2
print(nums_dbl)

# Replace the third column of nums
nums[:, 2] = nums[:, 2] + 1

print(nums)

"""
Use range() to create a list of arrival times (10 through 50 incremented by 10). Create the list arrival_times by unpacking the range object.

You realize your clock is three minutes fast. Convert the arrival_times list into a numpy array (called arrival_times_np) and use NumPy broadcasting to subtract three 
minutes from each arrival time.

Use list comprehension with enumerate() to pair each guest in the names list to their updated arrival time in the new_times array. You'll need to use the index variable 
created from using enumerate() on new_times to index the names list.

A function named welcome_guest() has been pre-loaded into your session. Use map() to apply this function to each element of the guest_arrivals list and save it as the variable welcome_map.
"""
arrival_times = [*range(10, 60, 10)]

# Convert arrival_times to an array and update the times
arrival_times_np = np.array(arrival_times)
new_times = arrival_times_np - 3

# Use list comprehension and enumerate to pair guests to new times
guest_arrivals = [(names[i],time) for i,time in enumerate(new_times)]

# Map the welcome_guest function to each (guest,time) pair
welcome_map = map(welcome_guest, guest_arrivals)

guest_welcomes = [*welcome_map]
print(*guest_welcomes, sep='\n')