import psutil
import time
from datetime import datetime

cpu= psutil.cpu_percent(interval=1)

ram = psutil.virtual_memory().percent

disk = psutil.disk_usage('/').percent

count_process = psutil.pids()


while True:
    with open("helath.log" , "a") as file:

        
        current_time = datetime.now().strftime("%H:%M:%S")

        cpu= psutil.cpu_percent(interval=1)

        ram = psutil.virtual_memory().percent

        disk = psutil.disk_usage('/').percent

        count_process = psutil.pids()

        file.write(f"{current_time} | CPU: {cpu}% | RAM: {ram}% | DISK: {disk}% | PROCESSES: {len(count_process)}\n")

        print(f"CPU Usage: {cpu}%")
        print(f"RAM Usage:  {ram}%")
        print(f"Disk Usage: {disk}%")
        print(f"Total number of processes running: {len(count_process)}")

    time.sleep(10)