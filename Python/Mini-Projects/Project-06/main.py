'''

Log File Manager

Objective

Automate log file management using Python.

Requirements

Create a folder named logs/ if it does not exist.

Create a log file named app.log inside it.

Append the following information each time script runs:

Current timestamp

Random log message (e.g., "Process started", "Backup completed")

If log file size > 1MB:

Move file to archive/ folder

Create a new app.log

Print all log files stored in archive/.

'''

import os
import shutil
from datetime import datetime
import random

# Step 1: Create logs/ directory if it doesn't exist
logs_dir = '/home/amit/Downloads/logs'
if os.path.exists(logs_dir):
    print(f"Directory already exists: {logs_dir}")
else:
    os.makedirs(logs_dir)
    print(f"Created directory: {logs_dir}")

with open(os.path.join(logs_dir, 'app.log'), 'a') as log_file:
    print("Log file is ready.")
    # Step 2: Append timestamp and random log message
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    log_messages = ["Process started", "Backup completed", "Error encountered", "User logged in", "Data synced"]
    random_msg = random.choice(log_messages)
    log_file.write(f"{current_time} - {random_msg}\n")
    print("Appended log entry.")

    # Step 3: Check log file size and archive if > 1MB
    log_file_path = os.path.join(logs_dir, 'app.log')
    if os.path.getsize(log_file_path) > 1 * 1024 * 1024:  # 1MB
    #here 1mb = 1024 k and 1kb = 1024 bytes so 1mb = 1024 * 1024 bytes
        archive_dir = os.path.join(logs_dir, 'archive')
        if not os.path.exists(archive_dir):
            os.makedirs(archive_dir)
            print(f"Created archive directory: {archive_dir}")
        archive_file_path = os.path.join(archive_dir, f"app_{datetime.now().strftime('%Y%m%d_%H%M%S')}.log")
        shutil.move(log_file_path, archive_file_path)
        print(f"Archived log file to: {archive_file_path}")
        # Create a new app.log file
        open(log_file_path, 'w').close()
        print("Created new app.log file.")


# Step 4: Print all log files in archive/
archive_dir = os.path.join(logs_dir, 'archive')
if os.path.exists(archive_dir):
    print("Archived log files:")
    for filename in os.listdir(archive_dir):
        if filename.endswith('.log'):
            print(filename.read())

else:   
    print("No archived log files found.")       


    





