### **File Handling • Read/Write/Append • Directory Operations • OS Module • shutil Module**

This document provides a complete summary of Day 3 of Python-for-DevOps training.
Topics covered include:

* Reading and writing files
* File modes (`r`, `w`, `a`)
* Line-by-line reading
* Closing files
* Creating, listing, and removing folders
* Checking existence of files/folders
* Removing directories (recursive delete)
* Using `os`, `os.path`, and `shutil` modules

---

# 📝 1. Introduction

File and directory handling is essential for DevOps automation.
You will use these concepts for:

* Log file processing
* Working with configuration files
* Creating backup scripts
* Automated folder cleanup
* Managing files in CI/CD pipelines
* Preparing deployment artifacts

---

# 📂 2. Opening & Reading Files

Python uses the built-in `open()` function:

```python
file = open("a.txt", "r")
```

The second argument `"r"` sets **read mode**.

---

## ✔ Read Entire File

```python
content = file.read()
print(content)
```

## ✔ Read One Line

```python
line = file.readline()
print(line)
```

## ✔ Read All Lines (List)

```python
lines = file.readlines()
print(lines)
```

---

## ✔ Closing the File (Important)

```python
file.close()
```

Always close files to avoid file locks and memory issues.

---

# ✍️ 3. Writing to Files (`w` Mode)

`"w"` = **Write mode**

* Overwrites existing content
* Creates file if it doesn't exist

```python
file = open("a.txt", "w")
file.write("I am working in Deloitte\n")
file.close()
```

---

# ➕ 4. Appending to Files (`a` Mode)

`"a"` = **Append mode**

* Adds content at the end
* Does NOT erase previous content

```python
file = open("a.txt", "a")
file.write("My home is in India\n")
file.close()
```

---

# 📌 5. Summary of File Modes

| Mode            | Meaning      | Behavior               |
| --------------- | ------------ | ---------------------- |
| `"r"`           | Read         | Reads existing content |
| `"w"`           | Write        | Overwrites file        |
| `"a"`           | Append       | Adds content to end    |
| `"rb"` / `"wb"` | Binary modes | For images, PDFs, etc. |

---

# 🧱 6. Directory (Folder) Handling

Python provides:

### ✔ `os` module → create, list, delete directories

### ✔ `os.path` module → check path existence

### ✔ `shutil` module → delete directory with all contents

---

# 📁 7. Creating a Folder

```python
import os

os.mkdir("folder1")
```

A new directory named **folder1** is created.

---

# 📂 8. Listing All Files/Folders

```python
items = os.listdir(".")  # "." = current directory
print(items)
```

Example output:

```
['a.txt', 'day3.py', 'folder1']
```

---

# 🔍 9. Checking If a File/Folder Exists

```python
import os.path

exists = os.path.exists("a.txt")
print(exists)
```

Works for both files and directories.

---

# 🗑 10. Deleting a File

```python
import os
os.remove("a.txt")
```

Permanently deletes the file.

---

# ❌ 11. Deleting an Empty Folder

```python
os.rmdir("folder1")
```

⚠️ Only works if folder is EMPTY.

---

# 🧹 12. Deleting a Folder With All Contents

Use `shutil.rmtree()` for recursive deletion.

```python
import shutil

shutil.rmtree("sam")
```

Deletes:

* Folder
* All files inside
* All subfolders

Useful for DevOps cleanup tasks (build directories, logs, temp artifacts).

---

# 🧠 13. Summary of Directory Commands

| Task                     | Module    | Command            |
| ------------------------ | --------- | ------------------ |
| Create folder            | `os`      | `os.mkdir()`       |
| List directory contents  | `os`      | `os.listdir()`     |
| Check existence          | `os.path` | `os.path.exists()` |
| Delete empty folder      | `os`      | `os.rmdir()`       |
| Delete folder + contents | `shutil`  | `shutil.rmtree()`  |
| Delete file              | `os`      | `os.remove()`      |

---

# 📘 14. Full Example: Combined File Handling

```python
# Read file
file = open("a.txt", "r")
print(file.read())
file.close()

# Overwrite file
file = open("a.txt", "w")
file.write("New content written here.\n")
file.close()

# Append to file
file = open("a.txt", "a")
file.write("Appending this line.\n")
file.close()
```

---

# 📁 15. Full Example: Directory Handling

```python
import os
import shutil

# create folder
os.mkdir("demo")

# list contents
print(os.listdir("."))

# check existence
print(os.path.exists("demo"))

# remove file
os.remove("sample.txt")

# recursive delete
shutil.rmtree("demo")
```

---


