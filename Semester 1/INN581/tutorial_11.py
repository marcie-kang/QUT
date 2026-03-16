"""
Question1

Create a Python program named PaintingDemo that instantiates a list of eight Room objects
and demonstrates the Room class methods. The Room constructor requires parameters for
length, width, and height attributes; use a variety of values when constructing the objects.
The Room class includes attributes for the wall area and the number of gallons of paint
needed, computed by public methods (compute_area and compute_gallons). Provide
public methods to set length, width, height, and update area and gallons accordingly. A
room has four walls, with no need to account for windows, doors, or the ceiling. A room
requires one gallon of paint per 350 square feet, with an extra gallon for any remaining
square feet greater than 350 (e.g., a 12×10 room with 9-foot ceilings has 396 square feet,
requiring two gallons). Demonstrate updating room dimensions and recalculating area and
gallons using these methods.
"""

import math

class Room:
    ONE_GALLON = 350

    def __init__(self, length, width, height):
        self.length = length
        self.width = width
        self.height = height
        self.wall_area = 0
        self.gallons_needed = 0
        self.compute_area()
        self.compute_gallons()

    def set_length(self, value):
        self.length = value
        self.compute_area()
        self.compute_gallons()

    def set_width(self, value):
        self.width = value
        self.compute_area()
        self.compute_gallons()

    def set_height(self, value):
        self.height = value
        self.compute_area()
        self.compute_gallons()

    def compute_area(self):
        perimeter = (self.length * self.width) * 2
        self.wall_area = perimeter * self.height

    def compute_gallons(self):
        self.gallons_needed = math.ceil(self.wall_area / 350)

    def __str__(self):
        return (f"Room: {self.length}×{self.width}×{self.height} ft | "
                f"Wall Area: {self.wall_area} sq ft | "
                f"Paint Needed: {self.gallons_needed} gallons")

def main():
    rooms = [
        Room(12, 10, 9),
        Room(8, 8, 9),
        Room(15, 12, 10),
        Room(6, 4, 8),
        Room(19, 20, 19),
        Room(18, 18, 18),
        Room(14, 14, 10),
        Room(16, 11, 10),
    ]

    #Display initial room information
    print("Initial Room Configurations: ")
    print("-" * 60)

    for i, room in enumerate(rooms, 1):
        print(f"Room {1}: {room}")

    print("-" * 60)

    #Demonstrate undating room dimensions and recalculating
    print("\nDemonstrating Room Updates: ")
    print("-" * 40)

    print(f"\nRoom 1 BEFORE update: {rooms[0]}")
    rooms[0].set_length(15)  # Change length from 12 to 15
    print(f"Room 1 AFTER length change (12→15): {rooms[0]}")

    # Update Room 2 dimensions
    print(f"\nRoom 2 BEFORE update: {rooms[1]}")
    rooms[1].set_width(12)  # Change width from 8 to 12
    rooms[1].set_height(10)  # Change height from 8 to 10
    print(f"Room 2 AFTER width (8→12) & height (8→10) changes: {rooms[1]}")

    # Update Room 3 dimensions
    print(f"\nRoom 3 BEFORE update: {rooms[2]}")
    rooms[2].set_height(8)  # Change height from 10 to 8
    print(f"Room 3 AFTER height change (10→8): {rooms[2]}")

    # Show calculation details for verification
    print("\n" + "=" * 60)
    print("Calculation Verification (using updated Room 1):")
    print("-" * 50)
    room = rooms[0]  # 15×10×9 room after update
    perimeter = 2 * (room.length + room.width)
    print(f"Room dimensions: {room.length} × {room.width} × {room.height} ft")
    print(f"Perimeter: 2 × ({room.length} + {room.width}) = {perimeter} ft")
    print(f"Wall area: {perimeter} × {room.height} = {room.wall_area} sq ft")
    print(f"Paint needed: ceil({room.wall_area} ÷ 350) = {room.gallons_needed} gallons")

    print("\n" + "=" * 60)
    print("Final Room Summary:")
    print("-" * 30)
    total_area = sum(room.wall_area for room in rooms)
    total_gallons = sum(room.gallons_needed for room in rooms)

    for i, room in enumerate(rooms, 1):
        print(f"Room {i}: {room}")

    print(f"\nTotal wall area for all rooms: {total_area} sq ft")
    print(f"Total paint needed for all rooms: {total_gallons} gallons")


if __name__ == "__main__":
    main()

"""
Question2

Create a Python program named LetterDemo that instantiates objects of two classes, Letter
and CertifiedLetter, and demonstrates their methods. The classes track letters mailed to
clients by a company. The Letter class includes attributes for the recipient’s name and date
mailed, with public methods to set these values. Include a __str__ method that returns a
string with the class name (using type(self).__name__) and attribute values. Create a child
class CertifiedLetter that inherits from Letter and includes an attribute for a tracking
number, with a method to set it. Demonstrate updating attributes using these methods.
"""

class Letter:
    def __init__(self, recipient_name, mailed_date, ):