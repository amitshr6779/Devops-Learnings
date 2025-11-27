'''
Write a function that simulates a mini calculator (add, subtract, multiply, divide) using:

A function for each operation

A main function to choose an operation


#from  operations import add, subtract, multiplication, divide
from operations import *
def calculator():
    print("Welcome to the Mini Calculator!")
    print("Select operation:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    
    while True:
        choice = input("Enter choice (1/2/3/4) or 'exit' to quit: ")
        
        if choice.lower() == 'exit':
            print("Exiting the calculator. Goodbye!")
            break
        
        if choice in ['1', '2', '3', '4']:
            num1 = float(input("Enter first number: "))
            num2 = float(input("Enter second number: "))
            
            if choice == '1':
                print(f"{num1} + {num2} = {add(num1, num2)}")
            elif choice == '2':
                print(f"{num1} - {num2} = {subtract(num1, num2)}")
            elif choice == '3':
                print(f"{num1} * {num2} = {multiplication(num1, num2)}")
            elif choice == '4':
                print(f"{num1} / {num2} = {divide(num1, num2)}")
        else:
            print("Invalid input. Please select a valid operation.")

calculator()


'''
#Build a function that logs all function calls into a file (log.txt).
from datetime import datetime

def log_function_call(func):
    log_date = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    def wrapper(*args, **kwargs):
        with open("log.txt", "a") as log_file:
            log_file.write(f"  {log_date} Function '{func.__name__}' called with args: {args}, kwargs: {kwargs}\n")
        return func(*args, **kwargs)
    return wrapper

@log_function_call
def sample_function(x, y):
    return x + y

result = sample_function(5, 10)
print(f"Result of sample_function: {result}")



from operations import *

@log_function_call
def calculator():
    print("Welcome to the Mini Calculator!")
    print("Select operation:")
    print("1. Add")
    print("2. Subtract")
    print("3. Multiply")
    print("4. Divide")
    
    while True:
        choice = input("Enter choice (1/2/3/4) or 'exit' to quit: ")
        
        if choice.lower() == 'exit':
            print("Exiting the calculator. Goodbye!")
            break
        
        if choice in ['1', '2', '3', '4']:
            num1 = float(input("Enter first number: "))
            num2 = float(input("Enter second number: "))
            
            if choice == '1':
                print(f"{num1} + {num2} = {add(num1, num2)}")
            elif choice == '2':
                print(f"{num1} - {num2} = {subtract(num1, num2)}")
            elif choice == '3':
                print(f"{num1} * {num2} = {multiplication(num1, num2)}")
            elif choice == '4':
                print(f"{num1} / {num2} = {divide(num1, num2)}")
        else:
            print("Invalid input. Please select a valid operation.")

calculator()