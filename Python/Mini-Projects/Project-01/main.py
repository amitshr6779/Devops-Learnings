import shutil
import os

source_file = '/home/amit/skills/IaaC/2025-Terraform/Devops-Learnings/Python/Mini-Projects/Project-1/README.md'
destination_folder = '/tmp/test'

#shutil.copy(source_file,destination_folder)

#os.path.exists(path) : Checks if anything exists at the given path.

if os.path.isfile(source_file):
    if os.path.isdir(destination_folder):
        shutil.copy(source_file, destination_folder)
        print(f"File copied to {destination_folder}")

    else:
        print("Destination folder does not exist.")
        print("Creating destination folder...")
        os.makedirs(destination_folder, exist_ok=True)
        shutil.copy(source_file, destination_folder)
else:
    print("Source file does not exist.")


#copy recursively into existing folder  copytree(..., dirs_exist_ok=True)
