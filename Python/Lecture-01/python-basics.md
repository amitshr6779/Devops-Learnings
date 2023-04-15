## What is Python ?
Python is General purpose, high level, object oriented and Interpreted Programming Language.

Here,  <br>
*General Purpose* means widely used in diffrent general task.  <br>
*High leve*l means lanuguage understood by the users



* Python Software has 2 Versions:
1. python 2.x  ( outdated )
2. python 3.x  ( Currently used )

NOTE : `Python does not support backward compatbility ` <br>
It means that python3 code cant run with python2 software 


### Features of Python 

* Web App Developmnet :  django, flask, etc
* GUI App Development : tkinter
* Console Bases Application : like Calculator
* Software Development Building tool : like Zoom , Browser package manger, etc
* Business Application : Ecom app
* Standard Application : like Ms-office
* AI/ML : Data Processing
* Audio/Video Application : like vlc

1. **Simple and Easy Learn** <br>
Python provide rich set of module or api
Ex:
```
import math
print(math.sqrt(25))
```
```
import calender
print(calender.calender(2023))
```

Python also provide inbuilt-facility called <b>garbage collector</b> which is responsible for memory management i.e clear unused memory space.

2. **Freeware & Opensource** <br>
Freeware means python can installed or used free without any license. While Opesource means Python source code is free , anyone can use it modify and create distribution. <br>
Distribution means new things that has been made using modifiction  of opensource code. <br> <br>
*List of Python Distribution:* <br> 
Jpython: Used to Java Appliction <br>
Ipython: Used to run c# .net applications

<br> <br>

3. **Python in Interpereted Langauge**

``Compiler and Interpreter``  <br>

Both are program that convert sorce code i.e HLL to Machine Code i.e LLL <br>
**Compiler** <br>
It Convert Source Code to object code then from byte code to machine code. <br>
It run the whole code  at once and check whole code & give error if any line there is error after checking whole code. <br>
It require high memory <br>
Ex: C, C#, Java <br>
<br>
**Interpreter** <br>
It Convert Source Code to byte code then to machine code. <br>
It run the whole code line by line and give o/p of each line and stops whenever found error at that line <br>
It require less memory <br>
Ex: Python <br>

<b>How Python in Interpereted Langauge ? </b>

![Screenshot from 2023-04-15 14-33-16](https://user-images.githubusercontent.com/84858868/232202946-0d24ca61-ee23-4248-bd89-120ee2338cc8.png)

<br> <br>
*Python program works on 2 execution phase* <br>
1. Compilation Phase. <br>
    Python read souce code line by line and convert it to intermediate code called as byte code. <br>
    i.e file.py ---> COMPILED ----->  file.pyc
<br> <br>
2. Execution Phase <br>
PVM i.e python virtual machine  read byte code line by line and convert it to machine code  that is ready by OS & Processor  and Give O/p of the program <br>

<br>

4. **Python is platform Independent**

It is platform independent beacause of data type. <br>
*Data type* is  allocating memory space to our input.  <br>
So, in python memory allocated to diffrent types is  same across all OS. <br> <br>
Example: <br>
In C, C++

```
Data Type    DOS     UNIX
int          2byte   4byte
float        4byte   8byte
double       8byte   16byte
char         1byte   2byte
```
But In Python same bytes of space allocated to data types accross diffrent OS.
* In Python all value are stored in the form of objects
* Each Object can store unlimited sized independent of OS
* Pre Defined Datat type can store multiple value
```
a=99.999999999999999999999999999999999999
print(a)
type(a)
<class 'int'>
#a is object with unlimited value
```

```
a=['python', 2, 'data']
```
5. **Python is Dynamically typed and High level programming** <br>
Dynamically typed means python does not require to  declare data types of variables. Python decide himself what type does  variable belongs to.
<br> High Level means it can also understnad machine code as input <br>
Example:
```
a=0b100
print(a) i.e 4
```























