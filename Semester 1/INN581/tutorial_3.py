"""
Question1

Write a program in the file equilateral.py that accepts the lengths of three sides of
a triangle as inputs. The program output should indicate whether or not the
triangle is an equilateral triangle.
"""
from threading import activeCount

first_side = float(input("Enter the first side of the triangle: "))
second_side = float(input("Enter the second side of the triangle: "))
third_side = float(input("Enter the third side of the triangle: "))

if first_side == second_side and first_side == third_side:
    print(f"This triangle is an equilateral triangle.")
else:
    print(f"This triangle is not an equilateral triangle.")

"""
Question2

Write a program in the file right.py that accepts the lengths of three sides of a
triangle as inputs. The program output should indicate whether or not the triangle
is a right triangle. Recall from the Pythagorean theorem that in a right triangle, the
square of one side equals the sum of the squares of the other two sides. (LO: 3.3)
"""

first_side = float(input("Enter the first side of the triangle: "))
second_side = float(input("Enter the second side of the triangle: "))
third_side = float(input("Enter the third side of the triangle: "))

longest_side = max(first_side, second_side, third_side)
is_triangle = False

if longest_side == first_side:
    if first_side ** 2 == second_side ** 2 + third_side ** 2:
        is_triangle = True
elif longest_side == first_side:
    if second_side ** 2 == first_side ** 2 + third_side ** 2:
        is_triangle = True
else:
    if third_side ** 2 == second_side ** 2 + first_side ** 2:
        is_triangle = True

if is_triangle:
    print("This is a right triangle.")
else:
    print("This is not a triangle.")

"""
Question3

Write a program named Twitter that accepts a user’s message and determines
whether it is short enough for a social networking service that does not accept
messages of more than 140 characters.
"""

message = input("Enter the message: ")

if len(message) <= 140:
    print("Your message posted successfully!")
else:
    print(f"You cannot write message more than 140 characters. Your current message length is {len(message)}.")

"""
Question4

Write a program named Admission for a college’s admissions office. The user
enters a numeric high school grade point average (for example, 3.2) and an
admission test score. Display the message Accept if the student meets either of the
following requirements:
A grade point average of 3.0 or higher, and an admission test score of at least 60
A grade point average of less than 3.0, and an admission test score of at least 80
If the student does not meet either of the qualification criteria, display Reject.
"""

high_school_grade = float(input("Enter the high school grade: "))
admission_test_score = float(input("Enter the admission test score: "))

if (high_school_grade >= 3.0 and admission_test_score >= 60) or (high_school_grade < 3.0 and admission_test_score >= 80):
    print("Accept")
else:
    print("Reject")

"""
Question5

Write a program named CheckMonth that prompts a user to enter a birth month.
If the value entered is greater than 12 or less than 1, display an error message;
otherwise, display the valid month with a message such as 3 is a valid month.
"""

birth_month = int(input("Enter a birth month: "))

if 1 <= birth_month <= 12:
    print(f"{birth_month} is a valid month.")
else:
    print("Error: You have to enter a valid month.")

"""
Question6

Account numbers sometimes contain a check digit that is the result of a
mathematical calculation. The inclusion of the digit in an account number helps
ascertain whether the number is a valid one. Write an application named
CheckDigit that asks a user to enter a four-digit account number and determines
whether it is a valid number. The number is valid if the fourth digit is the
remainder when the number represented by the first three digits of the four-digit
number is divided by 7. For example, 7770 is valid, because 0 is the remainder
when 777 is divided by 7.
"""

account_number = input("Enter a 4-digit account number: ")

if len(account_number) == 4 and account_number.isdigit():
    first_three = account_number[:3]
    check_digit = account_number[3]

    if first_three % 7 == check_digit:
        print("Your account number is valid.")
    else:
        print("Your account number is invalid.")
else:
    print("Error: Please enter a 4-digit number.")
