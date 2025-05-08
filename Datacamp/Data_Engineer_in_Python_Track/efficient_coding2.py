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

def calc_bmi_lists(sample_indices, hts, wts):

    # Gather sample heights and weights as lists
    s_hts = [hts[i] for i in sample_indices]
    s_wts = [wts[i] for i in sample_indices]

    # Convert heights from cm to m and square with list comprehension
    s_hts_m_sqr = [(ht / 100) ** 2 for ht in s_hts]

    # Calculate BMIs as a list with list comprehension
    bmis = [s_wts[i] / s_hts_m_sqr[i] for i in range(len(sample_indices))]

    return bmis

"""
Load the memory_profiler package into your IPython session.
Import calc_bmi_lists from bmi_lists.
Once you've completed the above steps, use %mprun to profile the calc_bmi_lists() function acting on your superheroes data. The hts array and 
wts array have already been loaded into your session.
"""
# %load_ext memory_profiler
# from bmi_lists import calc_bmi_lists

# %mprun -f calc_bmi_lists calc_bmi_lists(sample_indices, hts, wts)

def calc_bmi_arrays(sample_indices, hts, wts):

    # Gather sample heights and weights as arrays
    s_hts = hts[sample_indices]
    s_wts = wts[sample_indices]

    # Convert heights from cm to m and square with broadcasting
    s_hts_m_sqr = (s_hts / 100) ** 2

    # Calculate BMIs as an array using broadcasting
    bmis = s_wts / s_hts_m_sqr

    return bmis

# %load_ext memory_profiler
# from bmi_arrays import calc_bmi_arrays

# %mprun -f calc_bmi_arrays calc_bmi_arrays(sample_indices, hts, wts)

def get_publisher_heroes(heroes, publishers, desired_publisher):

    desired_heroes = []

    for i,pub in enumerate(publishers):
        if pub == desired_publisher:
            desired_heroes.append(heroes[i])

    return desired_heroes
def get_publisher_heroes_np(heroes, publishers, desired_publisher):

    heroes_np = np.array(heroes)
    pubs_np = np.array(publishers)

    desired_heroes = heroes_np[pubs_np == desired_publisher]

    return desired_heroes

"""
Use the get_publisher_heroes() function and the get_publisher_heroes_np() function to collect heroes from the Star Wars universe. 
The desired_publisher for Star Wars is 'George Lucas'.
"""
# Use get_publisher_heroes() to gather Star Wars heroes
star_wars_heroes = get_publisher_heroes(heroes, publishers, 'George Lucas')
print(star_wars_heroes)
print(type(star_wars_heroes))

# Use get_publisher_heroes_np() to gather Star Wars heroes
star_wars_heroes_np = get_publisher_heroes_np(heroes, publishers, 'George Lucas')
print(star_wars_heroes_np)
print(type(star_wars_heroes_np))

# %load_ext line_profiler
# %lprun -f get_publisher_heroes get_publisher_heroes(heroes, publishers, 'George Lucas')
# %lprun -f get_publisher_heroes_np get_publisher_heroes_np(heroes, publishers, 'George Lucas')