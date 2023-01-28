### Variables
A variable refers to a memory address in which data is stored. 
<br><br>
Python Variable Naming Rules :

* A variable name must start with a letter or the underscore character
* A variable name cannot start with a number
* A variable name can only contain alpha-numeric characters and underscores (A-z, 0-9, and _ )
* Variable names are case-sensitive (firstname, Firstname, FirstName and FIRSTNAME) are different variables

**Some Examples :**

```
first_name = 'Asabeneh'
last_name = 'Yetayeh'
country = 'Finland'
city = 'Helsinki'
age = 250
is_married = True
skills = ['HTML', 'CSS', 'JS', 'React', 'Python']
person_info = {
   'firstname':'Asabeneh',
   'lastname':'Yetayeh',
   'country':'Finland',
   'city':'Helsinki'
   }
```
***Note:***  <br>
 use snake_case variable naming convention. We use underscore character after each word for a variable containing more than one word(eg. first_name, last_name, engine_rotation_speed).
 
 ```
 # In quotes string type value store and without quote is int type
name = "Tom"
age = "40"

# Printing the values stored in the variables
print("There was a man named " + name + ",")
print("he was of" + age + "years")
print("He really liked the name" + name + " ," )
print("but he didn't like to be called " + age + " year" + name + " . ")
 ```
**Declaring Multiple Variable in a Line**

Example:

```
first_name, last_name, country, age, is_married = 'Asabeneh', 'Yetayeh', 'Helsink', 250, True
```
```
print(first_name, last_name, country, age, is_married)
print('First name:', first_name)
print('Last name: ', last_name)
print('Country: ', country)
print('Age: ', age)
print('Married: ', is_married)
```

Getting user input using the input() built-in function.

Example:

```
first_name = input('What is your name: ')
age = input('How old are you? ')

print(first_name)
print(age)
```

**Data Types** <br>
There are several data types in Python like str, int, float, bool, etc

#### Checking Data types and Casting
`Check Data types:` To check the data type of certain data/variable we use the type() function.

Example:

```
# Let's declare variables with various data types
first_name = 'Asabeneh'     # str
last_name = 'Yetayeh'       # str
country = 'Finland'         # str
city= 'Helsinki'            # str
age = 250                   # int, it is not my real age, don't worry about it

# Printing out types
print(type('Asabeneh'))     # str
print(type(first_name))     # str
print(type(10))             # int
print(type(3.14))           # float
print(type(1 + 1j))         # complex
print(type(True))           # bool
print(type([1, 2, 3, 4]))     # list
print(type({'name':'Asabeneh','age':250, 'is_married':250}))    # dict
print(type((1,2)))                                              # tuple
print(type(zip([1,2],[3,4])))                                   # set
```
`Casting:` Converting one data type to another data type. <br> <br>
Some Cases when we need casting :
* When we do arithmetic operations string numbers should be first converted to int or float otherwise it will return an error. 
* If we concatenate a number with a string, the number should be first converted to a string.

Example:

```
# int to float
num_int = 10
print('num_int',num_int)         # 10
num_float = float(num_int)
print('num_float:', num_float)   # 10.0

# float to int
gravity = 9.81
print(int(gravity))             # 9

# int to str
num_int = 10
print(num_int)                  # 10
num_str = str(num_int)
print(num_str)                  # '10'

# str to int or float
num_str = '10.6'
print('num_int', int(num_str))      # 10
print('num_float', float(num_str))  # 10.6

# str to list
first_name = 'Asabeneh'
print(first_name)               # 'Asabeneh'
first_name_to_list = list(first_name)
print(first_name_to_list)            # ['A', 's', 'a', 'b', 'e', 'n', 'e', 'h']
```

<br><br>

### EXERCISES:

**Q.** Using the len() built-in function, find the length of your first name

```
first_name = 'Amit'
print(len(first_name))
```

**Q.** Compare the length of your first name and your last name

```
first_name = 'Amit'
last_name = 'kumar'
len_of_first_name = int(len(first_name))
len_of_last_name = int(len(last_name))
if len_of_first_name == len_of_last_name:
   print('Length is equal')
else:
   print('Length is not equal')
```

**Q.** Declare two number in variable and perform airthematic operations

```
num1 = int(4)
num2 = int(5)
sum = num1 + num2
print('sum is: ' + str(sum))
```



