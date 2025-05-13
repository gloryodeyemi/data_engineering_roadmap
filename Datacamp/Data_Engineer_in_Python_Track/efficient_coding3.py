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

"""
Convert both lists (ash_pokedex and misty_pokedex) to sets called ash_set and misty_set respectively.
Find the Pokémon that both Ash and Misty have in common using a set method.
Find the Pokémon that are within Ash's Pokédex but are not within Misty's Pokédex with a set method.
Use a set method to find the Pokémon that are unique to either Ash or Misty (i.e., the Pokémon that exist in exactly one of the Pokédexes but not both).
"""
# Convert both lists to sets
ash_set = set(ash_pokedex)
misty_set = set(misty_pokedex)

# Find the Pokémon that exist in both sets
both = ash_set.intersection(misty_set)
print(both)

# Find the Pokémon that Ash has and Misty does not have
ash_only = ash_set.difference(misty_set)
print(ash_only)

# Find the Pokémon that are in only one set (not both)
unique_to_set = ash_set.symmetric_difference(misty_set)
print(unique_to_set)

"""
Convert Brock's Pokédex list (brock_pokedex) to a set called brock_pokedex_set.
Check if 'Psyduck' is in Ash's Pokédex list (ash_pokedex) and if 'Psyduck' is in Brock's Pokédex set (brock_pokedex_set).
Check if 'Machop' is in Ash's Pokédex list (ash_pokedex) and if 'Machop' is in Brock's Pokédex set (brock_pokedex_set).
"""
# Convert Brock's Pokédex to a set
brock_pokedex_set = set(brock_pokedex)
print(brock_pokedex_set)

# Check if Psyduck is in Ash's list and Brock's set
print('Psyduck' in ash_pokedex)
print('Psyduck' in brock_pokedex_set)

# Check if Machop is in Ash's list and Brock's set
print('Machop' in ash_pokedex)
print('Machop' in brock_pokedex_set)

"""
Use the provided function to collect the unique Pokémon in the names list. Save this as uniq_names_func.
Use a set data type to collect the unique Pokémon in the names list. Save this as uniq_names_set.
Use the most efficient approach for gathering unique items to collect the unique Pokémon types (from the primary_types list) and Pokémon generations (from the generations list).
"""
def find_unique_items(data):
    uniques = []

    for item in data:
        if item not in uniques:
            uniques.append(item)

    return uniques

# Use find_unique_items() to collect unique Pokémon names
uniq_names_func = find_unique_items(names)
print(len(uniq_names_func))

# Convert the names list to a set to collect unique Pokémon names
uniq_names_set = set(names)
print(len(uniq_names_set))

# Check that both unique collections are equivalent
print(sorted(uniq_names_func) == sorted(uniq_names_set))

# Use the best approach to collect unique primary types and generations
uniq_types = set(primary_types) 
uniq_gens = set(generations)
print(uniq_types, uniq_gens, sep='\n') 

"""Eliminating Loops"""
gen1_gen2_name_lengths_loop = []

for name,gen in zip(poke_names, poke_gens):
    if gen < 3:
        name_length = len(name)
        poke_tuple = (name, name_length)
        gen1_gen2_name_lengths_loop.append(poke_tuple)

"""
Eliminate the above for loop using list comprehension and the map() function:

Use list comprehension to collect each Pokémon that belongs to generation 1 or generation 2. Save this as gen1_gen2_pokemon.
Use the map() function to collect the number of letters in each Pokémon's name within the gen1_gen2_pokemon list. Save this map object as name_lengths_map.
Combine gen1_gen2_pokemon and name_lengths_map into a list called gen1_gen2_name_lengths.
"""
# Collect Pokémon that belong to generation 1 or generation 2
gen1_gen2_pokemon = [name for name,gen in zip(poke_names, poke_gens) if gen < 3]

# Create a map object that stores the name lengths
name_lengths_map = map(len, gen1_gen2_pokemon)

# Combine gen1_gen2_pokemon and name_lengths_map into a list
gen1_gen2_name_lengths = [*zip(gen1_gen2_pokemon, name_lengths_map)]

print(gen1_gen2_name_lengths_loop[:5])
print(gen1_gen2_name_lengths[:5])

# Loop 2
poke_list = []

for pokemon,row in zip(names, stats):
    total_stats = np.sum(row)
    avg_stats = np.mean(row)
    poke_list.append((pokemon, total_stats, avg_stats))

"""
Replace the above for loop using NumPy:
Create a total stats array (total_stats_np) using the .sum() method and specifying the correct axis.
Create an average stats array (avg_stats_np) using the .mean() method and specifying the correct axis.
Create a final output list (poke_list_np) by combining the names list, the total_stats_np array, and the avg_stats_np array.
"""
# Create a total stats array
total_stats_np = np.sum(stats, axis=1)

# Create an average stats array
avg_stats_np = np.mean(stats, axis=1)

# Combine names, total_stats_np, and avg_stats_np into a list
poke_list_np = [*zip(names, total_stats_np, avg_stats_np)]

print(poke_list_np == poke_list, '\n')
print(poke_list_np[:3])
print(poke_list[:3], '\n')
top_3 = sorted(poke_list_np, key=lambda x: x[1], reverse=True)[:3]
print('3 strongest Pokémon:\n{}'.format(top_3))