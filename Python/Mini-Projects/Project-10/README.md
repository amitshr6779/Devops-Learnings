---

# 📘 JSON Handling in Python — Complete Guide

This document explains **how to parse, read, write, and manipulate JSON data in Python** using the built-in `json` module.

---

## 📌 1. What is JSON?

**JSON (JavaScript Object Notation)** is a lightweight data format used for:

* API responses
* Configuration files
* Data exchange between applications

JSON data uses **key–value pairs**, similar to Python dictionaries.

Example JSON:

```json
{
  "name": "John",
  "age": 30,
  "city": "New York"
}
```

---

## 📌 2. Importing the JSON Module

```python
import json
```

The `json` module provides functions to convert between JSON and Python data types.

---

## 📌 3. Converting JSON String → Python Dictionary (`loads`)

```python
json_data = '{"name": "John", "age": 30, "city": "New York"}'

data = json.loads(json_data)
print(data)
```

### ✔ Output is a Python dictionary:

```python
{"name": "John", "age": 30, "city": "New York"}
```

---

## 📌 4. Accessing JSON Data

Once JSON is converted into a dictionary, access values using keys:

```python
print(data["name"])  # John
print(data["age"])   # 30
```

---

## 📌 5. Modifying JSON Data

### **Add new key-value pair**

```python
data["country"] = "USA"
```

### **Update existing value**

```python
data["age"] = 28
```

### **Print updated dictionary**

```python
print(data)
```

---

## 📌 6. Converting Python Dictionary → JSON String (`dumps`)

```python
updated_json = json.dumps(data)
print(updated_json)
```

### ✔ Output uses double quotes (JSON format):

```json
{"name": "John", "age": 28, "city": "New York", "country": "USA"}
```

---

## 📌 7. Writing Python Dictionary to JSON File (`dump`)

```python
data = {
    "name": "John",
    "age": 30,
    "city": "New York"
}

with open("output.json", "w") as file:
    json.dump(data, file)
```

✔ File created: `output.json`
✔ Data is stored in JSON format

---

## 📌 8. Reading JSON File → Python Dictionary (`load`)

```python
with open("output.json", "r") as file:
    content = json.load(file)

print(content)
```

✔ Reads entire JSON file
✔ Converts it into a Python dictionary

---

## 📌 9. Summary — `load`, `loads`, `dump`, `dumps`

| Function       | Purpose                     | Input Type  | Output Type |
| -------------- | --------------------------- | ----------- | ----------- |
| `json.load()`  | Read JSON from file         | File object | Python dict |
| `json.loads()` | Read JSON from string       | String      | Python dict |
| `json.dump()`  | Write JSON to file          | Python dict | File        |
| `json.dumps()` | Convert dict to JSON string | Python dict | String      |

### 🧠 Memory Trick:

* Functions ending with **s** → work with **strings**
* Functions **without s** → work with **files**

---

# 📝 Practice Questions

### Beginner

1. What is JSON and where is it commonly used?
2. How do you convert a JSON string to a Python dictionary?
3. What is the difference between `load` and `loads`?

### Intermediate

4. Write a Python script to add a new key `"gender"` to JSON data.
5. Convert dictionary → JSON string and print it.
6. Write JSON output into a file named `data.json`.

### Advanced

7. Read a JSON file, update a field, and save it back to the same file.
8. Build a function that takes a JSON string and returns only selected fields.

---

# 💡 Mini Project — JSON Configuration Manager

### **Goal:**

Create a Python script that can:

* Read a JSON configuration file
* Update a value (example: version, city, age)
* Add a new key
* Delete a key
* Save the updated JSON back to the file

### Example Commands:

```
python config_tool.py read config.json
python config_tool.py update config.json age 35
python config_tool.py add config.json country USA
python config_tool.py delete config.json city
```

---
