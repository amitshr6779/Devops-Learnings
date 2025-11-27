'''
#2. Check if a number is positive/negative/zero.
input_number = float(input("Enter a number: "))
if input_number > 0:
    print(f"The number {input_number} is positive.")
elif input_number < 0:
    print(f"The number {input_number} is negative.")
elif input_number == 0:
    print("The number is zero.")
else:
    print("Invalid input.")   



#4. Print numbers from 1–50 divisible by 5.
for i in range(1, 51):
    if i % 5 == 0:
        print(f'{i} is divisible by 5.')

        
#5. Print multiplication table for a number.
number = int(input("Enter a number to print its multiplication table: "))
for i in range(1, 11):
    result = number * i
    print(f"{number} x {i} = {result}")

    
#6. Count vowels in a string & dont count repetitions.
input_string = input("Enter a string: ").lower()
vowels = 'aeiou'
unique_vowels = set()
for char in input_string:
    if char in vowels:
        unique_vowels.add(char)
print(f"Unique vowels in the string: {', '.join(unique_vowels)}")
print(f"Total unique vowels: {len(unique_vowels)}")    

#8. Stop loop when number reaches 12 &  Skip numbers divisible by 3.

for i in range(1, 21):
    if i == 12:
        print("Loop stopped as number reached 12.")
        break
    if i % 3 == 0:
        print(f"Skipping number {i} as it is divisible by 3.")
        continue
    print(f"Current number: {i}")

    

#10. Create a dictionary of 3 employees and display details.

employees = {
    101: {'name': 'Alice', 'age': 30, 'department': 'HR'},
    102: {'name': 'Bob', 'age': 25, 'department': 'IT'},
    103: {'name': 'Charlie', 'age': 28, 'department': 'Finance'}
}
for key, value in employees.items():
    print(f"Employee ID: {key}")
    for detail_key, detail_value in value.items():
        print(f"  {detail_key.capitalize()}: {detail_value}")


'''






