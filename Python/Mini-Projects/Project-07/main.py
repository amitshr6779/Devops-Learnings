# 🚀 10. Mini Project — Menu Driven Utility

print(f"""
Welcome to the Menu Driven Utility!
Please select an option:
    1. Print numbers from 1 to N.
    2. Check Even or Odd.
    3. Get student details.
    4. To exits the menu driven utility type 'exit'. 
""")

students = {
    1: {'name': 'john doe', 'age': 20 , 'course': 'Computer Science'},
    2: {'name': 'jane smith', 'age': 22 , 'course': 'Mathematics'},
    3: {'name': 'alice jones', 'age': 19 , 'course': 'Physics'}
}

while True:
    choice = input("Enter your choice (1-4):")
    if choice == '1':
        n = int(input("Enter a number N to print numbers from 1 to N: "))
        for i in range(1, n + 1):
            print(i)
    elif choice == '2':
        number = int(input("Enter a number to check if it's Even or Odd: "))
        if number % 2 == 0:
            print(f"The number {number} is Even.")
        else:
            print(f"The number {number} is Odd.")
    elif choice == '3':
         student_id = int(input("Enter student ID (1-3) to get details: "))
         student = students.get(student_id)
         print(student)
         if student:
             print(f"student Name: {student['name'].title()}")
             print(f"student Age: {student['age']}")
             print(f"student Course: {student['course']}")
         else:
             print("Student not found. Please enter a valid ID (1-3).")
 
    elif choice == '4' or choice.lower() == 'exit':                          
        print("Exiting the Menu Driven Utility. Goodbye!")
        break
    else:
        print("Invalid choice. Please select a valid option (1-4).")
