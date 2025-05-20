"""
List Comprehensions

Let's learn about list comprehensions! You are given three integers x, y, and z representing the dimensions of a cuboid along with an integer n. 
Print a list of all possible coordinates given by (i,j,k) on a 3D grid where the sum of i+j+k is not equal to n. Here, 0<=i<=x; 0<=k<=y; 0<=k<=z. 
Please use list comprehensions rather than multiple loops, as a learning exercise.

Input Format
Four integers x,y,z and n, each on a separate line.

Constraints
Print the list in lexicographic increasing order.

Sample Input 0
1
1
1
2

Sample Output 0
[[0, 0, 0], [0, 0, 1], [0, 1, 0], [1, 0, 0], [1, 1, 1]]

Explanation 0
Each variable  and  will have values of  or . All permutations of lists in the form .
Remove all arrays that sum to  to leave only the valid permutations.

Sample Input 1
2
2
2
2

Sample Output 1
[[0, 0, 0], [0, 0, 1], [0, 1, 0], [0, 1, 2], [0, 2, 1], [0, 2, 2], [1, 0, 0], [1, 0, 2], [1, 1, 1], [1, 1, 2], [1, 2, 0], [1, 2, 1], [1, 2, 2], 
[2, 0, 1], [2, 0, 2], [2, 1, 0], [2, 1, 1], [2, 1, 2], [2, 2, 0], [2, 2, 1], [2, 2, 2]]
"""
if __name__ == '__main__':
    x = int(input())
    y = int(input())
    z = int(input())
    n = int(input())
    
    perm_list = [[i,j,k] for i in range(x+1) for j in range(y+1) for k in range(z+1)]
    filtered_perm_list = [lst for lst in perm_list if sum(lst) != n]
    print(filtered_perm_list)