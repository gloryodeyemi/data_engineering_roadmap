"""
Use list comprehension and range() to create a list of integers from 0 to 50 called nums_list_comp.
Use range() to create a list of integers from 0 to 50 and unpack its contents into a list called nums_unpack.
"""
nums_list_comp = [num for num in range(51)]
print(nums_list_comp)

nums_unpack = [*range(51)]
print(nums_unpack)

# %timeit nums_list_comp = [num for num in range(51)]
# %timeit nums_unpack = [*range(51)]

"""
Create an empty list called formal_list using the formal name (list()).
Create an empty list called literal_list using the literal syntax ([]).
Print out the type of formal_list and literal_list to show that both naming conventions create a list.
"""
formal_list = list()
print(formal_list)

literal_list = []
print(literal_list)

print(type(formal_list))
print(type(literal_list))

"""
What percentage of time is spent on the new_hts array broadcasting line of code relative to the total amount of time spent in the 
convert_units_broadcast() function?
"""
def convert_units_broadcast(heroes, heights, weights):

    # Array broadcasting instead of list comprehension
    new_hts = heights * 0.39370
    new_wts = weights * 2.20462

    hero_data = {}

    for i,hero in enumerate(heroes):
        hero_data[hero] = (new_hts[i], new_wts[i])

    return hero_data

# %load_ext line_profiler
# %lprun -f convert_units_broadcast convert_units_broadcast(heroes, hts, wts)