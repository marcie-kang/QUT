"""
Question1

The tax calculator program of the case study outputs a floating-point number that
might show more than two digits of precision. Use the round function to modify the
program in the file taxform.py (lecture 3, slide 7) to display at most two digits of
precision in the output number.
"""

TAX_RATE = 0.20
STANDARD_DEDUCTION = 10000.0
DEPENDENT_DEDUCTION = 3000.0

gross_income = float(input("Enter the income: "))
num_of_dependents = int(input("Enter the number of dependents: "))

net_income = gross_income - STANDARD_DEDUCTION - (DEPENDENT_DEDUCTION * num_of_dependents)
income_tax = round(net_income * TAX_RATE, 2)

print("The income tax is $",str(income_tax))

"""
Question2

You can calculate the surface area of a cube if you know the length of an edge. Write
a program in the file cube.py that takes the length of an edge (an integer) as input and
prints the cube’s surface area as output.
"""

edge_length = float(input("Enter the length of an edge: "))
cube_surface_area = (edge_length * edge_length) * 6

print(f"Cube's surface area is {cube_surface_area}.")

"""
Question3

Five Star Retro Video rents VHS tapes and DVDs to the same connoisseurs who like
to buy LP record albums. The store rents new videos for $3.00 a night and oldies for
$2.00 a night. Write a program in the file fivestar.py that the clerks at Five Star Retro
Video can use to calculate the total charge for a customer’s video rentals. The
program should prompt the user for the number of each type of video and output the
total cost.
"""

NEW_VID_PRICE = 3.0
OLD_VID_PRICE = 2.0

num_of_new = int(input("How many new videos do you want to rent?: "))
num_of_old = int(input("How many old videos do you want to rent?: "))
day_of_rent = int(input("How long do you want to rent?: "))
total_cost = ((num_of_old * NEW_VID_PRICE) + (num_of_old * OLD_VID_PRICE)) * day_of_rent

print(f"You rent {num_of_new} new videos, {num_of_old} old videos. So the total price is ${str(round(total_cost, 2))}.")

"""
Question4

Write a program in the file sphere.py that takes the radius of a sphere (a floating-
point number) as input and then outputs the sphere’s diameter, circumference, surface
area, and volume.
"""

import math

radius = float(input("Enter the radius: "))
diameter = 2 * radius
circumstance = diameter * 3.14
surface_area = 4 * math.pi * radius * radius
volume = 4/3 * math.pi * radius * radius * radius

print(f"Diameter: {diameter}")
print(f"Circumstance: {circumstance}")
print(f"Surface area: {surface_area}")
print(f"Volume: {volume}")

"""
Question5

An object’s momentum is its mass multiplied by its velocity. Write a program in the
file momentum.py that accepts an object’s mass (in kilograms) and velocity (in
meters per second) as inputs and then outputs its momentum.
"""

mass = float(input("Enter the object's mass: "))
velocity = float(input("Enter the object's velocity: "))
momentum = mass * velocity

print(f"The object's momentum is {momentum}.")

"""
Question6

The kinetic energy of a moving object is given by the formula KE = (1/ 2)mv2 where
m is the object’s mass and v is its velocity. Modify the program you created in
Programming Exercise 5 so that it prints the object’s kinetic energy as well as its
momentum
"""

kinetic_energy = (mass * velocity ** 2) / 2

print(f"The object's kinetic energy is {kinetic_energy}.")

"""
Question7

Write a program in the file minutes.py that takes as input a number of years and
calculates and prints the number of minutes in that period of time.
"""

MINUTES_PER_YEAR = 525600

num_of_year = float(input("Enter the number of years: "))
total_minutes = num_of_year * MINUTES_PER_YEAR

print(f"Number of minutes in {num_of_year} is {total_minutes}.")

"""
Question8

Light travels at 3 * 108 meters per second. A light-year is the distance a light beam
travels in one year. Write a program in the file lightyear.py that expects a number of
years as input and calculates and displays the value of the distance traveled in meters.
"""

import math

LIGHT_TRAVEL_DISTANCE = 3 * math.pow(10, 8)
SECONDS = 365 * 24 * 60 * 60

light_year = int(input("Enter the number of year: "))
total_light_travel = light_year * SECONDS * LIGHT_TRAVEL_DISTANCE

print(f"Light travels {total_light_travel} meters in {light_year} years.")
