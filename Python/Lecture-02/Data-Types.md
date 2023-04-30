## Data Representation in Python
Data can be represented by :
1. Identifier/ Variables/ objects  <br>
* Identifier :  to identify some things
* Variables : value of identifier can vary i.e variables
* objects : vars are only objects
 <br>
 
**NOTE** : variables will have distinct name as we cant namae same name two diffrent variables.  <br>

2. Literal  <br>
* literals are values asigned to variables i.e  input  value apssed to the program

<br>

3. Data Type
* It assigns memory to values i.e literals

<h4> Rules for Naming Variables : </h4>
1. Variables name is combination of  alphabets, numbers, and special char i.e underscore ( _ ) <br>
2. Variables name  must start with alpahabets or unserscore , other than this nothing is allowed. <br>
3. Variables should not have  keyword name i.e for, while etc <br>
4. Variables name can have class name like int, float etc  <br>
5. Variable name are case sensitive <br>

<br> 
<b> Examples </b>

```
my-sal=1000 //error bcz - is not allowed
_$mysal=1000  //error   bcz $ is nnot allowed only unserscore 
mysal=1000
mysal#january=1000   //this is true as after # will be considerd as comment value and mysal is also defined
newsal#jan=10000 // error bcz before # newsal is undefined

```
<br>

## Data Types in Python
It allocate memory to input in the progarm i.e to the values  of variables. <br>
Python is dynamically typed  langiage  so not require to mentioned  data types to the vars. <br>  <br>
There are 14 Data Types classified as 6 Types : 

![Screenshot from 2023-04-23 21-49-44](https://user-images.githubusercontent.com/84858868/233855965-6a571225-06b3-45a3-ab79-f1ed48ced65f.png)

Here, <br>
type none mens null value defined. <br>
ex:<br>

```
x=none
```

Note: if object/values inside objectid  changes then it is immutable , otherwise if objectid chnages to store same value then it is mutable

## Int data type:
It represet whole number i.e number without point <br>
Also int data tyype other number system like <br>
* Decimal Number system
* Binary Number system
* ocata Number system
* Hexa decimal number system

* Decimal Number System
It default number system i.e 0 to 9  ( Base 10 )

**Binary number system**  <br>
Number represent binary 0,1  <br>
ex: 16 = 10000 <br>
In python it is represent 0b,0B <br>

ex: 

```
x=0b010101
print(x)  // 21
```
Note: even toght we store number in binary but when we print we will get o/p in decimal numaber sysytem  <br>

**Octal Number system** <br>
Base 8 literal number is call octal number syystem <br>
number is represented in hexa decimal form i.e 0 to 8 <br>
In Python it is represented by 0o or 0O  <br>
Ex:  <br>
3252 = 3*8^3 + 2*8^2 + 5*8^1 + 2*8^0  <br>
```
x=0o1234
print(x) //668
```
**Hexa Decimal number system**  <br>
Hexa decimal digits are 0,1,2,3,4,5,6,7,8,9,A,B,C,D,E,F  <br>
Base 16 is used to represent number <br>
In python 0x ot 0X as prefix used to represent hexa number  <br>
```
x=0x118aed6
print(x)  //  18394838
```

**Base conversion types**  <br>

3 Types of base conversion types : <br>
* bin()
it is uded to convert any other number system to binary
```
print(bin(56))  //0b111000
print(bin(0o7))  //0nb11
print(bin(0x1A02))  //0b1101000000010
```

* oct()
it is uded to convert any other number system to octal
```
print(oct(16))  //0o20
print(oct(0b111))  //0o7
print(oct(0x1AB))  //0o653

```
* hex()
It is used to convert any other number system to hexa decimal number.

```
print(hex(10))  //0xa
print(hex(0b1011))   //0xb
print(hex(0o121))  //0x51
```

**Exceptions**

```
x=0b110
y=oct(b)
print(y,id(y),type(y))
0o6 140328112655152 <class 'str'>

( It is giving class string for above octal number because  octal number start with `0o` so it consider it as string
```








