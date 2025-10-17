"""
Question.1
Write a Python program in a file named myinfo.py that prints (displays) your name,
address, and telephone number.
"""
print("Marcie")
print("My address.st")
print("04-123-4555")

"""
Question.2
Open an IDLE window and enter the program from Figure 1-7 that computes the area
of a rectangle. Save the program to a file named rectangle.py and load it into the shell
by pressing the F5 key and correct any errors that occur. Test the program with
different inputs by running it at least three times.
"""
width = float(input("Enter the width: "))
height = float(input("Enter the height: "))
rectangle_area = width * height
print("The area is", rectangle_area, "square units.")

"""
Question3
Write a program in a file named triangle.py to compute the area of a triangle. Issue
the appropriate prompts for the triangle’s base and height. Then, use the formula .5 *
base * height to compute the area. Test the program from an IDLE window.
"""
base = float(input("Enter the base: "))
height = float(input("Enter the height: "))
triangle_area = base * height * 0.5
print("The area is", triangle_area, "square units.")

"""
Question4
Write and test a program in a file named circle.py that computes the area of a circle.
This program should request a number representing a radius as input from the user. It
should use the formula 3.14 * radius ** 2 to compute the area and then output this
result suitably labeled.
"""
radius = float(input("Enter the radius: "))
radius_area = 3.14 * radius ** 2
print("The area of radius is", radius_area, "square units.")

"""
Question5
A cuboid is a solid figure bounded by six rectangular faces. Its dimensions are its
height, width, and depth. Write a Python program in a file named cuboid.py that
computes and prints the volume of a cuboid, given its height, width, and depth as
inputs. The volume is just the product of these three inputs. The output should be
labeled as “cubic units.”
"""
height = float(input("Enter the height: "))
width = float(input("Enter the width: "))
depth = float(input("Enter the depth: "))
cuboid_volume = height * width * depth
print("The area of cuboid is", cuboid_volume, "cubic units")

"""
Question6
Consider the following interaction at the Python shell:

>>> first = input("Enter the first integer: ")
Enter the first number: 23
>>> second = input("Enter the second integer: ")
Enter the second number: 44
>>> print("The sum is", first + second)

The sum of the two integers is 2344
The expected output is 67, but the output of this computation is 2344. Explain what causes
this error and describe how to correct it.
"""

"""
Answer of Q6.
Since the input is a string (meaning 'first' and 'second' are both strings), adding them will
result in string concatenation. If you want to perform a calculation instead, you'll need to
explicitly convert the data type to an integer using the int() function.

>>> first = input("Enter the first integer: ")
Enter the first number: 23
>>> second = input("Enter the second integer: ")
Enter the second number: 44
>>> print("The sum is", int(first) + int(second))
"""
