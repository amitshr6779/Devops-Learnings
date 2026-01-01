---

# 📘 Object-Oriented Programming (OOPS) – Simple Notes (Python)

This document contains **easy and clear notes** on OOPS concepts in Python,
explained from a **beginner’s point of view**, with examples and plain language.

---

## 1️⃣ What is OOPS?

**Object-Oriented Programming (OOPS)** is a way of writing code where we model
real-world things using:

- Classes
- Objects (Instances)
- Attributes (Data)
- Methods (Functions)

---

## 2️⃣ Class

A **class** is a **blueprint or template**.

It defines:
- What data an object will have
- What actions an object can perform

```python
class Dog:
    pass
````

👉 This is just a design, not a real dog.

---

## 3️⃣ Object / Instance (IMPORTANT)

An **object** or **instance** is a **real thing created from a class**.

### 🔑 Instance = Object (they are the SAME)

```python
dog1 = Dog()
```

* `Dog` → class (blueprint)
* `dog1` → instance / object (real thing)

---

## 4️⃣ `__init__()` Method (Constructor)

`__init__()` is a **special method** that:

* Runs automatically when an object is created
* Sets initial (default) values for attributes

```python
class Dog:
    def __init__(self, name, age):
        self.name = name
        self.age = age
```

---

## 5️⃣ `self` Keyword

### What is `self`?

👉 `self` refers to the **current object**.

* Used in `__init__`
* Used in all instance methods
* Passed automatically by Python

```python
self.name = name
```

Means:

> Store `name` inside THIS object.

---

## 6️⃣ Creating Instances

```python
dog1 = Dog("Buddy", 3)
dog2 = Dog("Rocky", 5)
```

Each instance stores its **own data**:

```
dog1 → name=Buddy, age=3
dog2 → name=Rocky, age=5
```

---

## 7️⃣ Accessing Attributes

Syntax:

```python
object.attribute
```

Example:

```python
print(dog1.name)
print(dog1.age)
```

---

## 8️⃣ Methods (Functions inside a Class)

A **method** is a function that belongs to a class.

```python
class Dog:
    def bark(self):
        print("Woof!")
```

Calling a method:

```python
dog1.bark()
```

Internally Python does:

```
Dog.bark(dog1)
```

---

## 9️⃣ Why `self` is Required in Methods

Because Python needs to know:

> Which object is calling the method?

Without `self`, Python cannot identify the object.

---

## 🔟 Default Attribute Values

You can set default values inside `__init__`.

```python
class Dog:
    def __init__(self, name):
        self.name = name
        self.age = 1   # default value
```

---

## 1️⃣1️⃣ Modifying Attribute Values

### Way 1: Directly

```python
dog.age = 5
```

### Way 2: Using a Method (recommended)

```python
def set_age(self, age):
    self.age = age
```

---

## 1️⃣2️⃣ Incrementing Attribute Values

```python
def grow_older(self):
    self.age += 1
```

Usage:

```python
dog.grow_older()
```

---

## 1️⃣3️⃣ Inheritance

**Inheritance** means:

> A child class reuses code from a parent class.

```python
class Dog(Animal):
    pass
```

Dog **is an** Animal.

---

## 1️⃣4️⃣ `super()` Keyword

`super()` is used to call **parent class methods**.

```python
class Dog(Animal):
    def __init__(self, name, breed):
        super().__init__(name)
        self.breed = breed
```

`super().__init__(name)` calls:

```
Animal.__init__(self, name)
```

---

## 1️⃣5️⃣ Overriding Parent Methods

Child class can replace parent method.

```python
class Dog(Animal):
    def speak(self):
        print("Dog barks")
```

Child method overrides parent method.

---

## 1️⃣6️⃣ Calling Parent Method from Child

```python
def speak(self):
    super().speak()
    print("Dog barks")
```

---

## 1️⃣7️⃣ Instance as an Attribute (HAS-A relationship)

An object can **contain another object**.

```python
class Engine:
    def __init__(self, power):
        self.power = power

class Car:
    def __init__(self, brand, engine):
        self.brand = brand
        self.engine = engine
```

Usage:

```python
engine = Engine(150)
car = Car("Toyota", engine)
print(car.engine.power)
```

---

## 1️⃣8️⃣ Inheritance vs Instance as Attribute

| Concept               | Relationship |
| --------------------- | ------------ |
| Inheritance           | IS-A         |
| Instance as attribute | HAS-A        |

Example:

* Dog **is an** Animal
* Car **has an** Engine

---

## 1️⃣9️⃣ Summary Table

| Concept               | Meaning               |
| --------------------- | --------------------- |
| Class                 | Blueprint             |
| Object / Instance     | Real thing            |
| Attribute             | Data inside object    |
| Method                | Function inside class |
| `self`                | Current object        |
| `__init__`            | Object setup          |
| Inheritance           | Reuse parent code     |
| `super()`             | Call parent method    |
| Override              | Replace parent method |
| Instance as attribute | Object inside object  |

---

## 🎯 Final One-Line Summary

> OOPS models real-world things using classes and objects, where objects store data (attributes) and behavior (methods), can inherit from other classes, and can even contain other objects.

---



---

```markdown
# Python Imports – Beginner Friendly Notes

This document explains how to import classes and modules in Python in a simple and practical way.

---

## 1️⃣ What is a Module?

- A **module** is simply a Python file (`.py`)
- It can contain:
  - Classes
  - Functions
  - Variables

Example:
```

dog.py   ← module

````

---

## 2️⃣ Importing a Single Class from a Module

### dog.py
```python
class Dog:
    def bark(self):
        print("Woof!")
````

### main.py

```python
from dog import Dog

d = Dog()
d.bark()
```

✔ Imports only the `Dog` class
✔ Use the class directly (no module name needed)

---

## 3️⃣ Storing Multiple Classes in One Module

### animals.py

```python
class Dog:
    def bark(self):
        print("Woof!")

class Cat:
    def meow(self):
        print("Meow!")
```

✔ One module can contain many classes
✔ Very common practice

---

## 4️⃣ Importing Multiple Classes from a Module

```python
from animals import Dog, Cat

dog = Dog()
cat = Cat()
```

✔ Import only what you need
✔ Clean and readable

---

## 5️⃣ Importing an Entire Module

```python
import animals

dog = animals.Dog()
cat = animals.Cat()
```

✔ Safer (avoids name conflicts)
✔ Must use `module.class` syntax

---

## 6️⃣ Importing All Classes from a Module (`*`)

```python
from animals import *

dog = Dog()
cat = Cat()
```

⚠️ Not recommended for real projects
❌ Can cause name conflicts
✔ Okay for learning or small scripts

---

## 7️⃣ Importing a Module Using an Alias

```python
import animals as a

dog = a.Dog()
```

✔ Useful for long module names
✔ Makes code shorter and cleaner

---

## 8️⃣ Importing a Class Using an Alias

```python
from animals import Dog as D

dog = D()
```

✔ Useful when:

* Class names are long
* Name conflicts exist

---

## 9️⃣ Importing One Module into Another Module

### engine.py

```python
class Engine:
    pass
```

### car.py

```python
from engine import Engine

class Car:
    def __init__(self):
        self.engine = Engine()
```

### main.py

```python
from car import Car

c = Car()
```

✔ This is correct and common design
✔ Modules can import other modules

---

## 🔟 Typical Project Folder Structure

```
project/
│
├── animals.py
├── engine.py
├── car.py
└── main.py
```

✔ Imports work because files are in the same folder

---

## 1️⃣1️⃣ When to Use Which Import?

| Situation            | Recommended Import         |
| -------------------- | -------------------------- |
| Import one class     | `from module import Class` |
| Import many things   | `import module`            |
| Avoid name conflicts | `import module`            |
| Long names           | Use alias (`as`)           |
| Learning only        | `from module import *`     |

---

## 1️⃣2️⃣ Common Beginner Mistakes

❌ Forgetting module name:

```python
import animals
Dog()   # Error
```

✔ Correct:

```python
animals.Dog()
```

---

❌ Circular imports
(Two modules importing each other)

✔ Solution:

* Move shared code to a third module

---

## 1️⃣3️⃣ One-Line Summary

> A module is a Python file, and imports allow us to reuse classes and functions from that file in another file.

---

## 🧠 Final Mental Model

* File → Module
* Class → Blueprint
* Import → Bring code from another file
* Alias → Short name for module or class

---



