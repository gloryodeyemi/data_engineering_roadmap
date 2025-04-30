"""
Factorial Formula

Given a number n, write a formula that returns n!.
"""
# Solution 1
def factorial(n):
  fact = 1
  if n >= 0:
    if n == 0:
      return fact
    else:
      for num in range(n, 1, -1):
        fact = fact * num
      return fact

# Solution 2
def factorial(n):
  fact = 1
  for num in range(n, 1, -1):
    fact = fact * num
  return fact