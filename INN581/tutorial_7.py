"""
Question 1

Write a Python function to find the maximum of three numbers.
Print the result of calling the function with three arguments.
"""

def max_of_two(x, y):
    if x > y:
        return x
    else:
        return y

def max_of_three(x, y, z):
    return max_of_two(x, max_of_two(y, z))

"""
Question 2

Write a Python function to sum all the numbers in a list.
Print the result of calling the 'sum' function with a tuple of numbers (8, 2, 3, 0, 7)
"""

def cal_sum(nums):
    result = 0

    for num in nums:
        result += num

    return result

"""
Question 3

Write a Python function to calculate the factorial of a number (a non-negative integer). The function
accepts the number as an argument.
Ask the user to input a number to compute its factorial and store it in variable 'n'
Print the factorial of the number entered by the user by calling the 'factorial' function
"""

def factorial(n):
    if n == 0:
        return 1

    return n * factorial(n - 1)

n = int(input("Input a number to compute the factorial: "))
print(factorial(n))

"""
Question 4

Write a Python function that accepts a string and counts the number of upper and lower case
letters.
Call the function with the input string 'The quick Brown Fox'
"""

def count_upper_and_lower(string):
    upper_count = 0
    lower_count = 0

    for chr in string:
        if chr.isupper():
            upper_count += 1
        elif chr.islower():
            lower_count += 1

    print(f"Number of upper case characters: {upper_count}, number of lower case characters: {lower_count}.")

count_upper_and_lower("The quick Brown Fox")

"""
Question 5

Define a function named 'test_prime' that checks if a number 'n' is a prime number.
Print the result of checking if a given number is a prime number by calling the function.
"""

def test_prime(n):
    is_prime = True

    if n == 1:
        is_prime = False

    for i in range(2, n):
        if n % i == 0:
            is_prime = False
            break

    if is_prime:
        print(f"{n} is a prime number.")
    else:
        print(f"{n} is not a prime number.")

print(test_prime(2))

"""
Question 6

Write a Python function to create and print a list where the values are the squares of numbers
between 1 and 20 (both included).
Call the function to generate and print the list of squares
"""

def squares_list(x, y):
    result = []

    for i in range(1, y + 1):
        result.append(i ** 2)

    return result

print(squares_list(1, 20))

"""
Question 7

Write a Python function to print the even numbers from a given list.
Call the function with a list to print the even numbers .
"""

def print_evens(num_list):
    result = []

    for item in num_list:
        if item % 2 == 0:
            result.append(item)

    return result

print(print_evens([1, 2, 3, 4, 5, 6, 7, 8, 9, 10]))
