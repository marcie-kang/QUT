"""
Question 1

A course-management application represents information about students in a course.
Each student has a name and a list of test scores. We can use these as the attributes of a
class named Student. The Student class should allow the user to view a student’s name,
view a test score at a given position (counting from 1), reset a test score at a given
position, view the highest test score, view the average test score, and obtain a string
representation of the student’s information. When a Student object is created, the user
supplies the student’s name and the scores of test scores. Each score is initially
presumed to be 0. Assume that the Student class is defined in a file named student.py.
Write the code for the Student class.
The interface or set of methods of the Student class is described in the following table:
"""
from dotenv.parser import make_regex


class Student:
    def __init__(self, name, number):
        self.name = name
        self.scores = [0] * number

    def getName(self):
        return self.name

    def getScore(self, i):
        return self.scores[i - 1]

    def setScore(self, i, score):
        self.scores[i - 1] = score

    def getAverageScore(self):
        return sum(self.scores) / len(self.scores)

    def getHighScore(self):
        return max(self.scores)

    def __str__(self):
        return f"Name: {self.name} \nScores: {' '.join(map(str, self.scores))}"

"""
Question 2

Add three methods to the Student class (in the file student.py) that compare two
Student objects. One method should test for equality. A second method should test for
less than. The third method should test for greater than or equal to. In each case, the
method returns the result of the comparison of the two students’ names. Include a main
function that tests all of the comparison operators.
"""

class Student:
    def __init__(self, name, number):
        self.name = name
        self.scores = [0] * number

    def getName(self):
        return self.name

    def getScore(self, i):
        return self.scores[i - 1]

    def setScore(self, i, score):
        self.scores[i - 1] = score

    def getAverageScore(self):
        return sum(self.scores) / len(self.scores)

    def getHighScore(self):
        return max(self.scores)

    def __str__(self):
        return f"Name: {self.name} \nScores: {' '.join(map(str, self.scores))}"

    def __lt__(self, other):
        return self.name < other.name

    def __ge__(self, other):
        return self.name >= other.name

    def __eq__(self, other):
        if self is other:
            return True
        elif type(self) != type(other):
            return False
        else:
            return self.name == other.name

def main():
    s1 = Student("Jenny", 10)
    s2 = Student("Sam", 10)
    s3 = Student("Jenny", 10)
    print("False:", s1 == s2)
    print("True:", s1 == s3)
    print("True:", s1 == s1)
    print("False:", s1 is s3)
    print("True:", s1 < s2)
    print("True:", s2 > s1)
    print("True:", s2 >= s1)
    print("True:", s1 >= s3)
    print("True:", s1 <= s2)
    print("True:", s1 <= s3)

if __name__ == "__main__":
    main()

"""
Question 3

Build and Manage an Advanced Car Dealership System
In this exercise, you will extend the example provided in the lecture to build a Python
application that simulates the operations of a car dealership.
You will design and implement two main classes: Car and Dealership, and then write a
main() program to demonstrate and test their functionality.
Your final system should support inventory management, car sales, discounts, test
drives, and exporting the dealership inventory to a file.
Car class: Your Car class must include the following attributes and methods:
"""

class Car:
    def __init__(self, vin, brand, model, year, price):
        self.vin = vin
        self.brand = brand
        self.model = model
        self.year = year
        self.price = price
        self.sold = False
        self.mileage = 0
        self.test_driven = False

    def get_vin(self):
        return self.vin

    def get_price(self):
        return self.price

    def set_price(self, new_price):
        self.price = new_price

    def sell(self):
        if not self.sold:
            self.sold = True
            print(f"{self.brand} {self.model} sold.")

    def add_mileage(self, miles):
        self.mileage += miles

    def test_drive(self, miles):
        self.add_mileage(miles)
        self.test_driven = True

    def discount_price(self, percent):
        self.price *= ((1 - percent) / 100)

    def __eq__(self, other):
        return self.brand == other.brand and self.model == other.model and self.year == other.year

    def __str__(self):
        return (f"VIN: {self.vin}\nBrand: {self.brand}\nModel: {self.model}"
                f"\nYear: {self.year}\nPrice: {self.price}\nMileage: {self.mileage}")

class Dealership:
    def __init__(self, name, capacity):
        self.name = name
        self.capacity = capacity
        self.inventory = []

    def add_car(self, car):
        if len(self.inventory) < self.capacity:
            self.inventory.append(car)
        else:
            print("Inventory is full. You cannot add more cars.")

    def remove_car_by_vin(self, vin):
        for car_object in self.inventory:
            if car_object.get_vin() == vin:
                self.inventory.remove(car_object)
                print(f"Car with VIN {car_object.get_vin()} removed.")
                return

        print("We cannot found the car.")

    def remove_car_by_model_or_vin(self, value):
        for car_object in self.inventory:
            if car_object.get_vin() == value or car_object.model == value:
                self.inventory.remove(car_object)
                print(f"Car {car_object.model}/VIN {car_object.get_vin()} removed.")
                return

        print(f"We cannot found the car")

    def find_car_by_vin(self, vin):
        for car_object in self.inventory:
            if car_object.get_vin() == vin:
                return car_object

        return f"We don't have a car with the VIN: {vin}."

    def count_sold_cars(self):
        count = 0

        for car_object in self.inventory:
            if car_object.sold:
                count += 1

        return count

    def avg_mileage_unsold(self):
        unsold = [car_object.mileage for car_object in self.inventory if not car_object.sold]
        return sum(unsold) / len(unsold) if unsold else 0

    def filter_by_price(self, threshold):
        for car_object in self.inventory:
            if car_object.price > threshold:
                print(car_object)

    def sort_inventory_by(self, attr):
        if attr == "price":
            sorted_cars =  self.inventory.sort(key=lambda car: car.price)
        elif attr == "mileage":
            sorted_cars =  self.inventory.sort(key=lambda car: car.mileage)
        else:
            return "You entered wrong attribute. You should enter 'price' or 'mileage' to sort the car inventory."

        for car in sorted_cars:
            print(car)

    def list_inventory(self):
        for car_object in self.inventory:
            print(car_object)

    def export_inventory(self, filename = "inventory.txt"):
        with open(filename, "w") as file:
            for car_object in self.inventory:
                data = car_object.__str__()
                file.write(data)

        file.close()
        print(f"Inventory exported to {filename}.")

def input_cars_to_dealership(self, dealer):
    try:
        num = int(input("How many cars do you want to add? "))

        for i in range(num):
            print(f"\nEnter details for Car #{i + 1}:")
            vin = input("VIN: ")
            make = input("Make: ")
            model = input("Model: ")
            year = int(input("Year: "))
            price = float(input("Price: "))
            car = Car(vin, make, model, year, price)
            dealer.add_car(car)
    except ValueError:
        print("Invalid input. Please enter the correct data types.")

def main():
    car1 = Car(1001, "Hyundai", "Q223", 2025, 20000.0, )
    car2 = Car(1002, "Tesla", "T127", 2005, 10000.0, )
    car3 = Car(1003, "Toyota", "T771", 2019, 8000.0, )

    dealer1 = Dealership("The star", 10)
    dealer1.add_car(car1)
    dealer1.add_car(car2)
    dealer1.add_car(car3)

    car1.test_drive(500)
    car2.sell()
    car3.discount_price(20)

    print("\nSample Inventory: ")
    dealer1.list_inventory()
    print(f"The star dealer sold {dealer1.count_sold_cars()} cars.")

    print("\nCreate your own dealership.")
    new_dealer_name = input("Enter the dealership name: ")
    new_dealer_capacity = int(input("Enter the capacity of dealership: "))
    user_dealer = Dealership(new_dealer_name, new_dealer_capacity)

    input_cars_to_dealership(user_dealer)

    print(f"{user_dealer}'s inventory.")
    user_dealer.list_inventory()
    user_dealer.avg_mileage_unsold()
    print(f"{new_dealer_name} dealer sold {user_dealer.count_sold_cars()} cars.")
    user_dealer.filter_by_price(20000)
    user_dealer.sort_inventory_by("mileage")
    user_dealer.export_inventory("User_dealer_car_lists")

if __name__ == "__main__":
    main()

"""
Question 4 (Optional)

This exercise assumes that you have completed Programming Question 2.
Place several Student objects containing different names into a list and shuffle
it. Then run the sort method with this list and display all of the students’
information.
"""

class Student:
    def __init__(self, name, number):
        self.name = name
        self.scores = [0] * number

    def getName(self):
        return self.name

    def getScore(self, i):
        return self.scores[i - 1]

    def setScore(self, i, score):
        self.scores[i - 1] = score

    def getAverageScore(self):
        return sum(self.scores) / len(self.scores)

    def getHighScore(self):
        return max(self.scores)

    def __str__(self):
        return f"Name: {self.name} \nScores: {' '.join(map(str, self.scores))}"

    def __lt__(self, other):
        return self.name < other.name

    def __ge__(self, other):
        return self.name >= other.name

    def __eq__(self, other):
        if self is other:
            return True
        elif type(self) != type(other):
            return False
        else:
            return self.name == other.name

import random

def main():
    lyst = []

    for count in range(5):
        s = Student("Name" + str(count + 1, 10))
        lyst.append(s)

    random.shuffle(lyst)
    print("Unsorted list of students:")
    for s in lyst:
        print(s)

    lyst.sort()
    print("\nSorted list of students: ")
    for s in lyst:
        print(s)

if __name__ == "__main__":
    main()
