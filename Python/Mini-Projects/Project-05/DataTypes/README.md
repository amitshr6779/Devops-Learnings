
---


## 📝 Introduction

This module covers:

* Installing Python
* Writing your first Python program
* Understanding Python syntax
* Variables
* Core data types
* Example programs
* A full consolidated script
* Practice questions
* A mini-project

These fundamentals are essential for Python-based DevOps automation.

---

# ⚙️ 1. Installing Python (Windows)

### Steps

1. Search **Install Python Windows**
2. Open the official Python site
3. Download **Python 3.12.x**
4. Run installer → **Install**
5. Verify installation:

```bash
python --version
```

---

# 🧪 2. First Python Program – Hello World

Create a file:

```
hello.py
```

Add:

```python
print("Hello World")
```

Run:

```bash
python hello.py
```

---

# 🧱 3. Python Syntax Basics

## 3.1 Indentation

Python uses **indentation (spaces/tabs)** instead of `{ }`.

```python
if x > 5:
    print("Greater")
else:
    print("Smaller")
```

## 3.2 Comments

```python
# This is a comment
```

## 3.3 Variables (Dynamically Typed)

```python
a = 45
b = "Tom"
c = 3.14
```

---

# 🔢 4. Python Data Types

## 4.1 Numeric Data Types

### Integer

```python
x = 10
```

### Float

```python
pi = 3.14
```

---

## 4.2 String Data Type

```python
name = "Aditya"
language = 'Python'
```

When your string contains `'`:

```python
sentence = "This bat is Aditya's"
```

Multi-line string:

```python
text = """Line 1
Line 2
Line 3"""
```

---

## 4.3 Boolean Data Type

```python
is_valid = True
is_admin = False
```

---

## 4.4 List (Ordered, Mutable, Allows Duplicates)

```python
my_list = [1, 2, 3, "Tom", True]
```

Access:

```python
print(my_list[3])
```

Modify:

```python
my_list[0] = "DevOps"
```

---

## 4.5 Tuple (Ordered, Immutable)

```python
my_tuple = (1, 2, 3, "Tom")
```

Cannot modify:

```python
my_tuple[0] = 10   # ❌ Error
```

---

## 4.6 Dictionary (Key-Value Pairs)

```python
person = {
    "name": "John",
    "age": 30,
    "city": "New York"
}
```

Access:

```python
print(person["name"])
```

Add:

```python
person["education"] = "BTech"
```

---

## 4.7 Set (Unique, Unordered Items)

```python
my_set = {1, 2, 2, 3, 3, 4}
print(my_set)   # {1, 2, 3, 4}
```

---

# 🧪 5. Examples

## 5.1 Basic Arithmetic

```python
x = 5
y = 7

addition = x + y
sub = y - x
multiply = x * y
division = y / x

print("Addition:", addition)
print("Subtraction:", sub)
print("Multiplication:", multiply)
print("Division:", division)
```

---

## 5.2 List Example

```python
my_list = [1, 2, 3, 4, 5, "Amit"]

print(my_list)
print(my_list[3])

my_list[0] = "DevOps"
print(my_list)
```

---

## 5.3 Tuple Example

```python
my_tuple = (1, 2, 3, 4, "Amit")
print(my_tuple)
print(my_tuple[4])
```

---

## 5.4 Dictionary Example

```python
person = {
    "name": "Alice",
    "age": 25,
    "city": "London"
}

print(person)
print(person["name"])

person["education"] = "BTech"
print(person)
```

---

## 5.5 Set Example

```python
my_set = {1, 2, 2, 3, 4}
print(my_set)
```

---

# 🧱 6. Consolidated Program (All Data Types)

```python
# Integer
num = 42
print("Integer:", num)

# Float
flt = 3.14
print("Float:", flt)

# String
msg = "Hello World"
print("String:", msg)

# List
my_list = [1, 2, 3]
my_list.append(6)
my_list.remove(2)
print("List:", my_list)

# Tuple
my_tuple = (1, 2, 3, 4)
print("Tuple:", my_tuple)

# Dictionary
my_dict = {"a": 1, "b": 2}
my_dict["c"] = 3
del my_dict["a"]
print("Dictionary:", my_dict)

# Set
my_set = {1, 2, 3}
my_set.add(6)
my_set.remove(2)
print("Set:", my_set)
```

---

# 📝 7. Practice Questions

## Theory

1. What is indentation in Python?
2. Difference between list and tuple?
3. What does “dynamically typed” mean?
4. Why do dictionaries use key-value pairs?
5. Why do sets remove duplicates automatically?

## Coding

1. Store and print your name, age, and city.
2. Create a fruit list → add item → remove item → print.
3. Create a dictionary for a student and add “grade”.
4. Convert a list of skills into a tuple.
5. Create a set and show that it removes duplicates.

---

# 🚀 8. Mini Project — User Profile Manager

### Objective

Build a small program using **all data types**.

### Requirements

1. Create a dictionary for a user:

   * name
   * age
   * skills (list)
   * is_employed (boolean)

2. Add a new skill dynamically

3. Convert list of skills → tuple

4. Create a set of unique achievement IDs

5. Print clean profile output

### Expected Output

```
Name: Amit
Age: 25
Skills: ['Python', 'DevOps', 'Docker']
Immutable Skills: ('Python', 'DevOps', 'Docker')
Achievements: {101, 102, 103}
```

---


