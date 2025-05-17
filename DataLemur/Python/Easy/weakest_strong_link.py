"""
Weakest Strong Link

You know that phrase, how a chain is only as strong as its weakest link?

Imagine you had a chain-link fence, represented as a matrix. For the chain-link at position (i, j), the input matrix strength[i][j] indicates how strong the chain 
is at that position (where stronger means a higher number). The numbers in the matrix are unique.

The Weakest Strong Link is defined as the weakest chain-link in its row but also the strongest link in its column.

Given a matrix strength, return the weakest strong link if it exists; otherwise, return -1. If a weakest strong link exists, it is always exactly one, 
and it can be proven that no other link will satisfy both conditions simultaneously.

Example #1
Input: strength = [[1, 2, 3],[4, 5, 6],[7, 8, 9]]
Output: 7

Explanation:
7 is the weakest in its row [7, 8, 9] and the strongest in its column [1, 4, 7], making it the Weakest Strong Link.

Weakest Strong Link Example 1

Example #2
Input: strength = [[9, 8, 10],[6, 15, 4]]
Output: -1

Explanation:
No chain-link satisfies the criteria of being the weakest in its row and the strongest in its column.
"""
def weakest_strong_link(strength):
  rows = len(strength)
  cols = len(strength[0])

  for i in range(rows):
    # Find the weakest (min) link in the row
    min_val = min(strength[i])
    min_i = strength[i].index(min_val)
        
    # Check if it is also the strongest (max) in its column
    col_values = [strength[j][min_i] for j in range(rows)]
    if min_val == max(col_values):
      return min_val
  return -1
