"""
Question 1

Create a Python class for a Soccer Player. The Soccer Player has attributes for the
player's name, jersey number, goals scored, and assists. Write a short main
method that creates a Soccer Player object and tests its attributes.
"""

class Player:
    def __init__(self, name, jersey_num, goals, assists):
        self.name = name
        self.jersey_num = jersey_num
        self.goals = goals
        self.assists = assists

def main():
    player1 = Player("Tom", 18, 20, 4)
    print(f"Name: {player1.name}")
    print(f"Jersey number: {player1.jersey_num}")
    print(f"Goals: {player1.goals}")
    print(f"Assists: {player1.assists}")

if __name__ == "__main__":
    main()

"""
Question 2

Write a Python class for a Job to use in a program for Harold’s Home Services. The
Job class should contain attributes for description (e.g., “Wash windows”), time
required to complete the job (in hours), per-hour rate charged (e.g., $23.00), and
the total fee (per-hour rate multiplied by the time required to complete the job).
Include methods to get and set each attribute except for the total fee. The total
fee should be read-only and calculated every time the per-hour rate or time
required changes. The Job class should also contain a method to change the per-
hour rate by adding an amount to the current per-hour rate if the per-hour rate is
less than $20.00. You should also override the __str__ method to display all
information for the Job. Write a short main method that creates several Job
objects and demonstrates all methods for all the Job objects.
"""

class Harold_home_service:
    def __init__(self, description, time, hourly_rate):
        self.description = description
        self.time = time
        self.hourly_rate = hourly_rate
        self.calculate_total_Fee()

    def calculate_total_Fee(self):
        self.total_fee = self.get_time() * self.get_hourly_rate()

    def get_description(self):
        return self.description

    def set_description(self, value):
        self.description = value

    def get_time(self):
        return self.time

    def set_time(self, value):
        self.time = value
        self.calculate_total_Fee()

    def get_hourly_rate(self):
        return self.hourly_rate

    def set_hourly_rate(self, value):
        self.houlry_rate = value
        self.calculate_total_Fee()

    def increase_hourly_rate(self, value):
        if self.get_hourly_rate() < 20:
            self.set_hourly_rate(self.get_hourly_rate() + value)
            print(f"Per hour rate increased to {self.get_hourly_rate()}.")
        else:
            print("Cannot increase per hour rate if it is over $20.")

    def __str__(self):
        print(f"\nJob description: {self.get_description()}\nRequired_hour: {self.get_time()}"
              f"\nHourly rate: {self.get_hourly_rate()}\nTotal fee: {self.total_fee}")

def main():
    job1 = Harold_home_service("Wash windows", 5, 23)
    job2 = Harold_home_service("Wash dishes", 3, 20)
    job3 = Harold_home_service("Vacuum", 3, 15)

    job1.__str__()
    job2.__str__()
    job3.__str__()

if __name__ == "__main__":
    main()

"""
Question 3

Create a Python class that represents a Sales Transaction. The class should
contain attributes for the salesperson's name, sales amount, commission rate,
and commission. Include get and set methods for the salesperson's name and
sales amount. The commission rate and commission should be read-only. Write
the __init__ function so that it can accept any of the following scenarios:

a. All three parameters (salesperson’s name, sales amount and commission rate) are specified.
b. Only the salesperson’s name and sales amount are specified, and the commission rate is set to the default of 0.
c. Only the salesperson’s name is specified, and the sales amount and commission rate are set to the default of 0.

Write a main method that creates three Sales Transaction objects using the
scenarios above, and check that all attribute values are calculated correctly.
"""

class SalesPerson:
    def __init__(self, name, amount = 0, commission_rate = 0):
        self.name = name
        self.amount = amount
        self.commission_rate = commission_rate
        self.total_commission()

    def get_name(self):
        return self.name

    def set_name(self, value):
        self.name = value

    def get_amount(self):
        return self.amount

    def set_amount(self, value):
        self.amount = value
        self.total_commission()

    def get_commission_rate(self) -> int:
        return self.commission_rate
    
    def get_commission(self):
        return self.commission

    def total_commission(self):
        self.commission = self.get_amount() * self.get_commission_rate()

def main():
    paperSale = SalesPerson('John', 23000, 0.05)
    print(f'Paper Sale: {paperSale.get_name()}, ${paperSale.get_amount():.2f}, {paperSale.get_commission_rate() * 100}%, ${paperSale.get_commission():.2f}')

    paperSale.set_amount(50000)
    print(f'Paper Sale: {paperSale.get_name()}, ${paperSale.get_amount():.2f}, {paperSale.get_commission_rate() * 100}%, ${paperSale.get_commission():.2f}')

    printerSale = SalesPerson('John', 10000)
    print(f'Printer Sale: {printerSale.get_name()}, ${printerSale.get_amount():.2f}, {printerSale.get_commission_rate()}%, ${printerSale.get_commission():.2f}')

    shredderSale = SalesPerson('John')
    print(f'Shredder Sale: {shredderSale.get_name()}, ${shredderSale.get_amount():.2f}, {shredderSale.get_commission_rate()}%, ${shredderSale.get_commission():.2f}')

if __name__ == "__main__":
    main()

"""
Question 4

Write a Python class for a Sale. The class should have attributes for the inventory
number, the amount of sale and the tax owed. Include get and set methods for the
inventory number and the amount of sale. The tax owed should be read-only. The
tax is calculated whenever the amount of sale is set. Assume the tax rate is 8% for
the first $100 and 6% for any amount greater than $100. Write a main method that
creates a list of 5 Sale objects. Prompt the user to enter the inventory number and
the amount of sale for each object. Finally, display all the Sale objects in the list.
"""

class Sale:
    taxLimit = 100
    baseTaxRate = 0.08
    extraTaxRate = 0.06

    def __init__(self, inventory_num, amount):
        self.inventory_num = inventory_num
        self.amount = amount
        self.cal_tax()

    def get_inventory_num(self):
        return self.inventory_num

    def set_inventory_num(self, value):
        self.inventory_num = value

    def get_amount(self):
        return self.amount

    def set_amount(self, value):
        self.amount = value
        self.cal_tax()

    def get_tax(self):
        return self.tax

    def cal_tax(self):
        if self.get_amount() > Sale.taxLimit:
            self.tax = (Sale.taxLimit * Sale.baseTaxRate) + ((self.get_amount() - 100) * Sale.extraTaxRate)
        else:
            self.tax = self.get_amount() * Sale.baseTaxRate

def main():
    daily_sale = []

    for i in range(5):
        inventory_number = input('Please enter the inventory number: ')
        sale_amount = float(input('Please enter the sale amount: '))
        daily_sale.append(Sale(inventory_number, sale_amount))

    for sale in daily_sale:
        print(f"Sold: {sale.get_inventory_num()} for ${sale.get_amount()}. Tax owed: {sale.get_tax()}")

if __name__ == "__main__":
    main()
