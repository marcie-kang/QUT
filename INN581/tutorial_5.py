"""
Exercise 1

Write a code segment that opens a file named myfile.txt for input and prints the number of lines in the
file.
"""

count = 0
input_file = open("myfile.txt", "r")

for line in input_file:
    count += 1

print(f"There are {count} lines.")

"""
Exercise 2

Write a code segment that opens a file for input and prints the number of four-letter words in the file.
"""

count = 0
input_file = open("myfile.txt", "r")

for line in input_file:
    word_list = line.split()

    for word in word_list:
        if len(word) == 4:
            count += 1

print(f"There are {count} four-letter words.")

"""
Exercise 3
Assume that a file contains integers separated by newlines. Write a code segment that opens the file and
prints the average value of the integers.
"""

num_count = 0
num_sum = 0
input_file = open("myfile.txt", "r")

for num in input_file:
    num_sum += int(num.strip())
    num_count += 1

if count == 0:
    average = 0
else:
    average = num_sum / num_count

print(f"The average value of the integer is {average}")

"""
Exercise 4

Write a code segment that prompts the user for a filename. If the file exists, the program should print
its contents on the terminal. Otherwise, it should print an error message.
"""

from os.path import exists

file_name = input("Enter the file name: ")

if not exists(file_name):
    print("Error: the file does not exist.")
else:
    input_file = open(file_name, "r")
    print(input_file.read())

"""
Exercise 5

Write a script named copyfile.py. This script should prompt the user for the names of two text files.
The contents of the first file should be input and written to the second file.
"""

first_file_name = input("Enter the first file's name: ")
second_file_name = input("Enter the second file's name: ")

first_file = open(first_file_name, "r")
second_file = open(second_file_name, "w")

"""
Exercise 6

Write a script named numberlines.py. This script creates a program listing from a source program.
This script should prompt the user for the names of two files. The input filename could be the name of
the script itself, but be careful to use a different output filename! The script copies the lines of text from
the input file to the output file, numbering each line as it goes. The line numbers should be right-justified
in four columns, so that the format of a line in the output file looks like this example: (LO: 4.5)
"""

in_name = input("Enter the input file name: ")
out_name = input("Enter the output file name: ")

input_file = open(in_name, "r")
output_file = open(out_name, "w")

line_number = 0

for line in input_file:
    line_number += 1
    output_file.write("%4d> %s" % (line_number, line))

output_file.close()

"""
Exercise 7

Write a code segment that prints the names of all of the items in the current working directory.its contents on the terminal. Otherwise, it should print an error message.
"""

from os import getcwd, listdir

dirList = listdir(getcwd())

for name in dirList:
    print(name)

"""
Exercise 8

Write a script in the file encrypt.py that inputs a line of plaintext and a distance value and outputs an
encrypted text using a Caesar cipher. The script should work for any printable characters.
"""

plain_text = input("Enter the message: ")
distance = int(input("Enter the distance value: "))
code = ""

for ch in plain_text:
    if "a" <= ch.lower() <= "z":
        ord_value = ord(ch.lower())
        cipher_value = ord_value + distance

        if cipher_value > 122:
            cipher_value = distance - 126 - ord_value + 1

        code += chr(cipher_value)
    else:
        code += ch

print(code)

"""
Exercise 9

Write a script in the file decrypt.py that inputs a line of encrypted text and a distance value and outputs
plaintext using a Caesar cipher. The script should work for any printable characters.
"""

code = input("Enter the coded text: ")
distance = int(input("Enter the distance value: "))
plain_text = ""

for ch in code:
    ord_value = ord(ch)
    cipher_value = ord_value - distance

    if cipher_value < 0:
        cipher_value = 127 - (distance - (1 - ord_value))

    plain_text += chr(cipher_value)

print(plain_text)

"""
Exercise 10

Write a script named dif.py. This script should prompt the user for the names of two text files and
compare the contents of the two files to see if they are the same. If they are, the script should simply
output "Yes". If they are not, the script should output "No", followed by the first lines of each file that
differ from each other. The input loop should read and compare lines from each file. The loop should
break as soon as a pair of different lines is found.
"""

first_file_name = input("Enter the first file's name: ")
second_file_name = input("Enter the second file's name: ")

first_file = open(first_file_name, "r")
second_file = open(second_file_name, "r")

first_file_lines = first_file.readlines()
second_file_lines = second_file.readlines()
is_same = True

if len(first_file_lines) != len(second_file_lines):
    print("No")
    is_same = False
else:
    for i in range(len(first_file_lines)):
        if first_file_lines[i] != second_file_lines[i]:
            print("No")
            is_same = False
            break

if is_same:
    print("Yes")
