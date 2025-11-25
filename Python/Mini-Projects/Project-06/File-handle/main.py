#Write a program to read only the first 3 lines of a file.
#Create a script that writes a user input message into a file.
#Read all lines of a file and count how many lines it has.
#Create a program that overwrites a file with "Hello DevOps!".

#Write a script that creates 5 folders in a loop (folder1 to folder5).
#Delete all .log files inside a directory.
#Check if a folder exists; if not, create it.
#Recursively delete a directory named build-output.
#Create a script that lists all files with .txt extension in a directory.

'''
with open('sample.html', 'r') as file:
    content = file.readlines()
    print(f"Total lines in file: {len(content)}")
    for line in content[:3]:
        print(line.strip())

user_message =  input("Enter a message to write to the file: ")

with open('user_message.txt', 'w') as file:
    file.write(user_message)        

    

with open('sample.html', 'r') as file:
    contents = file.readlines()
    print(f"The file has {len(contents)} lines. \n")
    print("Contents of the file:")
    for line in contents:
        print(line.strip()) 

with open('devops.txt', 'w') as file:
    file.write("Hello DevOps!\n")   



    






import os
import shutil

for i in range(1, 6):
    folder_name = f"folder{i}"
    os.makedirs(folder_name, exist_ok=True)
    print(f"Created folder: {folder_name}")


directory = '/home/amit/Downloads/logss/'  # Current directory
for filename in os.listdir(directory):
    if filename.endswith('.log'):
        #os.remove(filename)
        os.remove(os.path.join(directory, filename))        

        
folder_path = '/home/amit/Downloads/logss/new_folder33/'
#if not os.path.exists(folder_path):
if not os.path.isdir(folder_path):
    os.makedirs(folder_path)
    print(f"Folder created at: {folder_path}")    

folder_to_delete = '/home/amit/Downloads/logss/'  
if os.path.exists(folder_to_delete):
    import shutil
    shutil.rmtree(folder_to_delete)
    print(f"Deleted folder: {folder_to_delete}")
else:
    print(f"Folder does not exist: {folder_to_delete}")    


directory = '/home/amit/Downloads/logss/'  

if os.path.isdir(directory):
    for files in os.listdir(directory):
        if files.endswith('.txt'):
            print(files)
else:
    print(f"The directory {directory} does not exist.")     
'''

# Append timestamped logs into a file every time the script runs.

from datetime import datetime
with open('logfile.txt', 'a') as file:
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    file.write(f"Log entry at: {current_time}\n")
    


