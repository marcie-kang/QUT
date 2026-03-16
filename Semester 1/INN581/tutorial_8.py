"""
Question 1

Write a Python program to create a class representing a Circle. Include methods to calculate
its area and perimeter.
(a) Prompt the user to input the radius of the circle and convert it to a floating-point
number
(b) Create a Circle object with the provided radius
(c) Calculate the area of the circle.
(d) Calculate the perimeter of the circle
(e) Display the area and perimeter of the circle
"""

import math

class Circle:
    def __init__(self, radius):
        self.radius = radius

    def calculate_area(self):
        return math.pi * self.radius ** 2

    def calculate_perimeter(self):
        return 2 * math.pi * self.radius

    def display(self):
        print(f"Area of the circle: {self.calculate_area()}")
        print(f"Perimeter of the circle: {self.calculate_perimeter()}")

radius = float(input("Enter the radius of the circle: "))
my_circle = Circle(radius)
my_circle.display()

"""
Question 2

Write a Python program to create a Person class. Include attributes like name, country and
date of birth. Implement a method to determine the person's age.
(Import the date class from the datetime module to work with dates)
(a) Create three Person objects with different attributes
(b) Access and print the attributes and calculated age for each person
"""

from datetime import date

class Person:
    def __init__(self, name, country, date_of_birth):
        self.name = name
        self.country = country
        self.date_of_birth = date_of_birth
        self.age = self.calculate_age()

    def display_details(self):
        print(f"{self.name} is from {self.country}. Date of birth is {self.date_of_birth}, {self.age} years old.")

    def calculate_age(self):
        today = date.today()
        age = today.year - self.date_of_birth.year

        if today < date(today.year, self.date_of_birth.month, self.date_of_birth.day):
            age -= 1

        return age

person1 = Person("Joo", "Korea", date(2022,9,9))
person2 = Person("Alex", "Australia", date(2024, 9,10))
person3 = Person("Sam", "Japan", date(2025, 10,21))

person1.display_details()
person2.display_details()
person3.display_details()

"""
Question 3

Write a Python program to create a Calculator class. Include methods for basic arithmetic
operations. (Addition, Subtraction, Multiplication and Division)
(a) Create an instance of the Calculator class
(b) Perform addition and print the result
(c) Perform subtraction and print the result
(d) Perform multiplication and print the result
(e) Perform division and print the result
(f) Perform division by zero and print the error message
"""

class Calculator:
    def __init__(self, x, y):
        self.x = int(x)
        self.y = int(y)

    def addition(self):
        return self.x + self.y

    def subtraction(self):
        return self.x - self.y

    def multiplication(self):
        return self.x * self.y

    def division(self):
        if self.y == 0:
            return (f"Error:{self.x} cannot divided by 0.")

        return self.x / self.y

calculator = Calculator(5, 0)
result = calculator.division()
print(result)

"""
Question 4

Write a Python program to create a class representing a bank. Include methods for managing
customer accounts and transactions.
(a) Create a new account
(b) Make a deposit
(c) Make a withdrawal
(d) Check the balance
Then
(a) Create an instance of the Bank class
(b) Create customer accounts and perform account operations
"""

class Bank:
    def __init__(self):
        self.customers = {}

    def create_account(self, account_number, initial_balance = 0):
        if account_number in self.customers:
            print("Account number already exists.")
        else:
            self.customers[account_number] = initial_balance
            print("Account created successfully.")

    def make_deposit(self, account_number, amount):
        if account_number in self.customers:
            self.customers[account_number] += amount
            print("Deposit successful.")
        else:
            print("Account number does not exist.")

    def make_withdrawal(self, account_number, amount):
        if account_number in self.customers:
            if self.customers[account_number] >= amount:
                self.customers[account_number] -= amount
                print("Withdrawal successful.")
            else:
                print(f"Error: you have not enough balance. Your current balance is ${self.balance}.")
        else:
            print("Account number does not exist.")

    def check_balance(self, account_number):
        if account_number in self.customers:
            print(f"Your current balance is ${self.customers[account_number]}.")
        else:
            print("Account number does not exist.")
