---

````markdown
# Python Decorators – Beginner Friendly Guide

This guide explains the core ideas behind decorators in Python:

- Higher-Order Functions  
- Inner Functions  
- Closures  
- Decorators  
- *args and **kwargs  

All concepts are explained in simple, easy-to-understand language.

---

## 1️⃣ Higher-Order Functions

A **Higher-Order Function** is a function that:
- **takes another function as input**, or
- **returns a function**.

Example:

```python
def greet():
    print("Hello!")

def call_me(func):
    func()  # func receives greet
````

Here:

* `call_me` is a higher-order function because it receives another function (`greet`) as a parameter.

---

## 2️⃣ Inner Functions

An **inner function** is a function **defined inside another function**.

Example:

```python
def outer():
    def inner():
        print("I am inside")
    inner()
```

* `inner()` is only available inside `outer()`.
* It cannot be called from outside.

---

## 3️⃣ Closures

A **closure** happens when:

* An inner function **remembers values** from the outer function,
* Even after the outer function has finished running.

Example:

```python
def outer(msg):
    def inner():
        print(msg)  # inner remembers msg
    return inner

say_hi = outer("Hi")
say_hi()  # prints "Hi"
```

Here:

* `inner()` remembers the value `"Hi"` even though `outer()` has exited.
* This memory effect is called a **closure**.

---

## 4️⃣ Decorators

A **decorator** adds extra functionality to a function **without modifying the function's code**.

Example:

```python
def my_decorator(func):
    def wrapper():
        print("Before function")
        func()
        print("After function")
    return wrapper

@my_decorator
def hello():
    print("Hello!")

hello()
```

Output:

```
Before function
Hello!
After function
```

### How it works:

`@my_decorator` is the same as:

```python
hello = my_decorator(hello)
```

So `hello()` actually calls `wrapper()`.

---

## 5️⃣ *args and **kwargs

These allow your function to accept **any number** of parameters.

### `*args` → positional values

```python
def test(*args):
    print(args)

test(1, 2, 3)   # (1, 2, 3)
```

### `**kwargs` → keyword arguments

```python
def test(**kwargs):
    print(kwargs)

test(name="Amit", age=25)
# {'name': 'Amit', 'age': 25}
```

Decorators need *args and **kwargs so they can wrap any function.

Example:

```python
def log(func):
    def wrapper(*args, **kwargs):
        print("Function called:", func.__name__)
        return func(*args, **kwargs)
    return wrapper
```

---

## 6️⃣ Putting It All Together (Logging Decorator)

```python
import datetime

def log_calls(func):
    def wrapper(*args, **kwargs):
        timestamp = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")
        log_entry = f"[{timestamp}] Called function: {func.__name__}\n"

        with open("log.txt", "a") as f:
            f.write(log_entry)

        return func(*args, **kwargs)

    return wrapper


@log_calls
def say_hello():
    print("Hello!")
```

Explanation:

* `log_calls` → higher-order function
* `wrapper` → inner function
* `wrapper` remembers `func` → closure
* `@log_calls` → decorator
* `*args`, `**kwargs` → support any function parameters

---

## ⭐ Summary Table

| Concept               | Meaning                                            |
| --------------------- | -------------------------------------------------- |
| Higher-Order Function | Function that receives or returns another function |
| Inner Function        | A function inside another function                 |
| Closure               | Inner function remembering outer variables         |
| Decorator             | Adds extra behavior to a function                  |
| *args                 | Collects multiple positional arguments             |
| **kwargs              | Collects multiple keyword arguments                |

---



