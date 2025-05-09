"""
Combine the names list and the primary_types list into a new list object (called names_type1).
Combine names, primary_types, and secondary_types (in that order) using zip() and unpack the zip object into a new list.
Use zip() to combine the first five items from the names list and the first three items from the primary_types list.
"""
names_type1 = [*zip(names, primary_types)]
print(*names_type1[:5], sep='\n')

names_types = [*zip(names, primary_types, secondary_types)]
print(*names_types[:5], sep='\n')

differing_lengths = [*zip(names[0:5], primary_types[0:3])]
print(*differing_lengths, sep='\n')

"""
Collect the count of each primary type from the sample.
Collect the count of each generation from the sample.
Use list comprehension to collect the first letter of each Pokémon in the names list. Save this as starting_letters.
Collect the count of starting letters from the starting_letters list. Save this as starting_letters_count.
"""
# Collect the count of primary types
type_count = Counter(primary_types)
print(type_count, '\n')

# Collect the count of generations
gen_count = Counter(generations)
print(gen_count, '\n')

# Use list comprehension to get each Pokémon's starting letter
starting_letters = [name[0] for name in names]

# Collect the count of Pokémon for each starting_letter
starting_letters_count = Counter(starting_letters)
print(starting_letters_count)

"""
Import combinations from itertools.
Create a combinations object called combos_obj that contains all possible pairs of Pokémon from the pokemon list. A pair has 2 Pokémon.
Unpack combos_obj into a list called combos_2.
Ash upgraded his Pokédex so that it can now store four Pokémon. Use combinations to collect all possible combinations of 4 different Pokémon. 
Save these combinations directly into a list called combos_4 using the star character (*).
"""
# Import combinations from itertools
from itertools import combinations

# Create a combination object with pairs of Pokémon
combos_obj = combinations(pokemon, 2)
print(type(combos_obj), '\n')

# Convert combos_obj to a list by unpacking
combos_2 = [*combos_obj]
print(combos_2, '\n')

# Collect all possible combinations of 4 Pokémon directly into a list
combos_4 = [*combinations(pokemon, 4)]
print(combos_4)