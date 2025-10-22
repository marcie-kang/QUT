"""Question1

Modify the guessing-game program from Slide 29 in the file guess.py so that the
user thinks of a number that the computer must guess. The computer must make
no more than the minimum number of guesses, and it must prevent the user from
cheating by entering misleading hints. (Hint: Use the math.log function to
compute the minimum number of guesses needed after the lower and upper
bounds are entered).
"""

import math

smaller = int(input("Enter the smaller number: "))
larger = int(input("Enter the larger number: "))
count = 0
maxGuesses = round(math.log(larger - smaller + 1, 2))

while True:
    count += 1
    print(smaller, larger)

    your_number = (smaller + larger) // 2
    print(f"Your number is {your_number}")
    answer = input("Enter =, <, or >: ")

    if answer == "=":
        print(f"Hooray, I've got it! {count} tries!")
        break
    elif count == maxGuesses:
        print("I'm out of guesses, and you cheated!")
        break
    elif answer == "<":
        larger = your_number - 1
    else:
        smaller = your_number + 1

"""
Question2

A standard science experiment is to drop a ball and see how high it bounces. Once
the “bounciness” of the ball has been determined, the ratio gives a bounciness
index. For example, if a ball dropped from a height of 10 feet bounces 6 feet high,
the index is 0.6, and the total distance traveled by the ball is 16 feet after one
bounce. If the ball were to continue bouncing, the distance after two bounces
would be 10 ft + 6 ft + 6 ft + 3.6 ft = 25.6 ft. Note that the distance traveled for
each successive bounce is the distance to the floor plus 0.6 of that distance as the
ball comes back up. Write a program in the file bouncy.py that lets the user enter
the initial height from which the ball is dropped and the number of times the ball
is allowed to continue bouncing. Output should be the total distance traveled by
the ball
"""

height = float(input("Enter the height from which the ball is dropped: "))
bounciness = float(input("Enter the bounciness index of the ball: "))
distance = 0
bounces = int(input("Enter the number of times the ball is allowed to continue bouncing: "))

for eachPass in range(bounces):
    distance += height
    height *= bounciness
    distance += height

print(f"Total distance traveled is {distance} units.")

"""
Question3

A local biologist needs a program to predict population growth. The inputs would
be the initial number of organisms, the rate of growth (a real number greater than
0), the number of hours it takes to achieve this rate, and a number of hours during
which the population grows. For example, one might start with a population of
500 organisms, a growth rate of 2, and a growth period to achieve this rate of 6
hours. Assuming that none of the organisms die, this would imply that this
population would double in size every 6 hours. Thus, after allowing 6 hours for
growth, we would have 1000 organisms, and after 12 hours, we would have 2000
organisms. Write a program in the file population.py that takes these inputs and
displays a prediction of the total population.
"""

initial_organisms = int(input("Enter the initial nuber of organisms: "))
growth_rate = float(input("Enter the rate of growth: "))
cycle_hours = int(input("Enter the number of hours to achieve this rate: "))
total_hours = int(input("Enter the number of hours: "))
cycles = total_hours // cycle_hours

for eachPass in range(cycles):
    initial_organisms = initial_organisms * growth_rate

print(f"The total population is {initial_organisms}.")

"""
Question4

The German mathematician Gottfried Leibniz developed the following method to
approximate the value of π:
π/4 = 1 - 1/3 + 1/5 - 1/7 + . . .
Write a program in the file leibniz.py that allows the user to specify the number of
iterations used in this approximation and that displays the resulting value.
"""

import math

iterations = int(input("Enter the numbef of iterations: "))
pioverfour = 0
numerator = 1
denominator = 1

for count in range(iterations):
    pioverfour += numerator / denominator
    numerator = - numerator
    denominator += 2

print(f"The approximation of pi is {pioverfour * 4}.")
print(f"Compare this to the computer's estimation: {math.pi}")

"""
Question5

Teachers in most school districts are paid on a schedule that provides a salary
based on their number of years of teaching experience. For example, a beginning
teacher in the Lexington School District might be paid $30,000 the first year. For
each year of experience after this first year, up to 10 years, the teacher receives a
2% increase over the preceding value. Write a program in the file salary.py that
displays a salary schedule, in tabular format, for teachers in a school district. The
inputs are the starting salary, the percentage increase, and the number of years in
the schedule. Each row in the schedule should contain the year number and the
salary for that year.
"""

starting_salary = float(input("Enter the starting salary: $"))
increase_percentage = float(input("Enter the percentage increase: "))
scheduled_years = int(input("Enter the number of years in the schedule: "))

multiplier = 1 + increase_percentage / 100
salary = starting_salary

print("   year salary   \n---------------------")

for year in range(1, scheduled_years + 1):
    print(f"  {year}    ${round(salary, 2)}")
    salary += salary * (increase_percentage * 0.01)

"""
Question6

The greatest common divisor of two positive integers, A and B, is the largest
number that can be evenly divided into both of them. Euclid’s algorithm can be
used to find the greatest common divisor (GCD) of two positive integers. You can
use this algorithm in the following manner:
a. Compute the remainder of dividing the larger number by the smaller number.
b. Replace the larger number with the smaller number and the smaller number with
the remainder.
c. Repeat this process until the smaller number is zero.
d. The larger number at this point is the GCD of A and B. Write a program in the file
gcd.py that lets the user enter two integers and then prints each step in the process
of using the Euclidean algorithm to find their GCD.
"""

first = int(input("Enter the smaller number: "))
second = int(input("Enter the bigger number: "))

while first > 0:
    remainder = second % first
    second = first
    first = remainder

"""
Question7

Write a program in the file sum.py that receives a series of numbers from the user
and allows the user to press the enter key to indicate that he or she is finished
providing inputs. After the user presses the enter key, the program should print the
sum of the numbers and their average.
"""

num_sum = 0
count = 0

while True:
    number = input("Enter the number of press 'Enter' to quit: ")

    if number == "":
        break

    num_sum += float(number)
    count += 1

print(f"The sum is {num_sum}.")

if count > 0:
    print(f"The average is {num_sum / count}")