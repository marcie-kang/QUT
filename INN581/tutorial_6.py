"""
Question1

Assume that the variable data refers to the list [5, 3, 7]. Write the values of the
following expressions:
a. data[2]
b. data[-1]
c. len(data)
d. data[0:2]
e. 0 in data
f. data + [2, 10, 5]
g. tuple(data)
"""
from numpy.ma.extras import median

"""
Answer to the Question1

a. 7
b. 7
c. 3
d. [5, 3]
e. False
f. [5, 3, 7, 2, 10, 5]
g. (5, 3, 7)
"""

"""
Question2

Assume that the variable data refers to the list [5, 3, 7]. Write the expressions that
perform the following tasks:
a. Replace the value at position 0 in data with that value’s negation.
b. Add the value 10 to the end of data.
c. Insert the value 22 at position 2 in data.
d. Remove the value at position 1 in data.
e. Add the values in the list newData to the end of data.
f. Locate the index of the value 7 in data, safely.
g. Sort the values in data.
"""

"""
Answer to the Question2

a. data[0] = -data[0]
b. data.append(10)
c. data.insert(2, 22)
d. data.pop(1)
e. data.extend(newData)
f. if 7 in data:
      position = data.index(7)
   else:
       position = -1
g. data.sort()
"""

"""
Question3

What is a mutator method? Explain why mutator methods usually return the value
None.
"""

"""
Answer to the Question3

A mutator method modifies the internal state of an object. 
A mutator metthod returns the value None because its purpose is just to modify the state of an object.
"""

"""
Question4

Write a loop that accumulates the sum of the numbers in a list named data
"""

data = [1, 2, 3, 4]
num_sum = 0

for item in data:
    num_sum += item

"""
Question5

Assume that data refers to a list of numbers, and result refers to an empty list. Write
a loop that adds the nonzero values in data to the result list, keeping them in their
relative positions.
"""

data = [1, 2, 3, 4]
result = []

for item in data:
    if item != 0:
        result.append(item)

"""
Question6

Write a loop that replaces each number in a list named data with its absolute value.
"""

for item in data:
    if item < 0:
        data[item] = abs(item)

"""
Question7

Assume that the variable data refers to the dictionary {'b':20, 'a':35}. Write the
values of the following expressions:
a. data['a']
b. data.get('c', None)
c. len(data)
d. data.keys()
e. data.values()
f. data.pop('b')
g. data # After the pop above
"""

"""
Answer to the question7

a. 35
b. None
c. 2
d. ["b", "a"]
e. [20, 35]
f. 20
g. {"a": 35}
"""

"""
Question8

Define a function named summation. This function expects two numbers, named low
and high, as arguments. The function computes and returns the sum of the numbers
between low and high, inclusive.
"""

def summation(low, high):
    result = 0

    for digit in range(low, high + 1):
        result += digit

    return result

"""
Question9

A group of statisticians at a local college has asked you to create a set of functions
that compute the median and mode of a set of numbers.
Define these functions in a module named stats.py. Also include a function named
mean, which computes the average of a set of numbers. Each function should expect
a list of numbers as an argument and return a single number. Each function should
return 0 if the list is empty. Include a main function that tests the three statistical
functions with a given list.
"""

def mean(num_list):
    if len(num_list) == 0:
        return 0

    total = sum(num_list)
    result = total / len(num_list)

    return result

def mode(num_list):
    if len(num_list) == 0:
        return 0

    num_dict = {}

    for num in num_list:
        freq = num_dict.get(num, None)

        if freq == None:
            num_dict[num] = 1
        else:
            num_dict[num] = freq + 1

    max_value = max(num_dict.values())

    for key in num_dict:
        if num_dict[key] == max_value:
            return key

def mode(num_list):
    if len(num_list) == 0:
        return 0

    numbers = [number for number in num_list]
    numbers.sort()
    midpoint = len(num_list) // 2

    if len(numbers) % 2 == 1:
        return numbers[midpoint]
    else:
        return numbers[midpoint + numbers[midpoint-1]] / 2


def main():
    nums = [3, 1, 7, 1, 4, 10]
    print("List", nums)
    print("Mode", mode(nums))
    print("Median", median(nums))
    print("Mean", mean(nums))

if __name__ == "__main__":
    main()

"""
Question10

Write a program in the file navigate.py that allows the user to navigate the lines of
text in a file. The program should prompt the user for a filename and input the lines of
text into a list. The program then enters a loop in which it prints the number of lines in
the file and prompts the user for a line number. Actual line numbers range from 1 to
the number of lines in the file. If the input is 0, the program quits. Otherwise, the
program prints the line associated with that number.
"""

file_name = input("Enter the name of file: ")
input_file = open(file_name, "r")

lines = []

for line in input_file:
    lines.append(line)

while True:
    print(f"The file has {len(lines)} lines")

    if len(lines) == 0:
        break

    line_num = int(input("Enter a line number [0 to quit]: "))

    if line_num == 0:
        break
    elif line_num >= len(lines) + 1:
        print(f"Error: line number must be less than {len(lines)}")
    else:
        print(f"{line_num}: {lines[line_num - 1]}")

