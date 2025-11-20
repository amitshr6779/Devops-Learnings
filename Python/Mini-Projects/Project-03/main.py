import os

folder = '/home/amit/Downloads/Demo-Folder'

if os.path.isdir(folder):
    print("The folder exists.")
else:
    print("The folder does not exist.")
    print("Creating the folder...")
    os.makedirs(folder, exist_ok=True)
    print("Folder created.")