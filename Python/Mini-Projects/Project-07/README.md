---

### **User Input • Conditions • Loops • Break/Continue • Dictionary Iteration**

This document provides structured notes for Day 4 of the Python-for-DevOps learning journey.
Topics covered include:

* Taking user input
* Conditional statements (`if`, `elif`, `else`)
* Nested conditions
* For & While loops
* Break and Continue
* Loop with Else
* Looping through dictionaries
* Combined examples
* Practice questions
* Mini project

---

## 📝 1. Taking Input from User

### **Basic Input**

```python
name = input("Enter a name: ")
print("User entered:", name)
```

### **Integer Input**

```python
num = int(input("Enter a number: "))
```

### **Float Input**

```python
num = float(input("Enter a floating number: "))
```

---

## 🧭 2. Conditional Statements

### **Basic If–Else**

```python
age = int(input("Enter your age: "))

if age >= 18:
    print("User is adult")
else:
    print("User is not adult")
```

### **Multiple Conditions with `elif`**

```python
score = int(input("Enter your score: "))

if score >= 90:
    print("Grade A")
elif score >= 80:
    print("Grade B")
elif score >= 70:
    print("Grade C")
else:
    print("Grade F")
```

### **Nested If**

```python
x = 10
y = 5

if x > y:
    print("x is greater than y")

    if x > 15:
        print("x is also greater than 15")
    else:
        print("x is not greater than 15")
else:
    print("y is greater")
```

---

## 🔁 3. Loops in Python

### **For Loop**

```python
fruits = ["apple", "banana", "cherry"]

for f in fruits:
    print(f)
```

### **While Loop**

```python
count = 0

while count < 5:
    print(count)
    count += 1
```

---

## ⛔ 4. Break & Continue

### **Break (exit loop completely)**

```python
for i in range(10):
    if i == 5:
        break
    print(i)
```

### **Continue (skip current iteration)**

```python
for i in range(10):
    if i == 5:
        continue
    print(i)
```

---

## 🧲 5. Loop with Else

Runs only if the loop finishes **without break**.

```python
for i in range(5):
    print(i)
else:
    print("Loop completed without break")
```

If loop contains `break`, this `else` will not run.

---

## 📘 6. Looping Through Dictionaries

```python
person = {
    "name": "John",
    "age": 35,
    "city": "New York"
}

for key, value in person.items():
    print(f"{key}: {value}")
```

---

## 🧩 7. Combined Example (Input + If + Loop)

```python
user_input = int(input("Enter a number: "))

if user_input % 2 == 0:
    print(f"{user_input} is Even")
else:
    print(f"{user_input} is Odd")

for i in range(1, user_input + 1):
    print(i)
```

---

## 🧠 8. Summary

* `input()` → reads user input
* `if/elif/else` → decision making
* `for`, `while` → iteration
* `break`, `continue` → loop control
* `for key, value in dict.items()` → dictionary iteration
* `for…else` executes only if no `break` occurs

These concepts are critical for automation, scripting, and DevOps workflows.

---

## 📝 9. Practice Questions

### **A. Input + Conditions**

1. Ask user's age → classify as Child/Teen/Adult.
2. Check if a number is positive/negative/zero.
3. Accept two numbers and print the larger one.

### **B. Loops**

4. Print numbers from 1–50 divisible by 5.
5. Print multiplication table for a number.
6. Count vowels in a string.
7. Using a while loop, print numbers until user enters 0.

### **C. Break/Continue**

8. Stop loop when number reaches 12.
9. Skip numbers divisible by 3.

### **D. Dictionary**

10. Create a dictionary of 3 employees and display details.

---

## 🚀 10. Mini Project — Menu Driven Utility

### **Project Title:**

**Python Menu-Based Utility Tool**

### **Features:**

1. Check Even/Odd
2. Print numbers from 1 to N
3. Display Student Dictionary
4. Exit the program

---




