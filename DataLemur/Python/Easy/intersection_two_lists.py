"""
Intersection of Two Lists

Write a function to get the intersection of two lists.

For example, if A = [1, 2, 3, 4, 5], and B = [0, 1, 3, 7] then you should return [1, 3].
"""
def intersection(a, b):
  intersect = []
  for val in a:
    for sec_val in b:
      if val == sec_val:
        intersect.append(val)
  return intersect
