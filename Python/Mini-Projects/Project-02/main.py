
file_path = '/home/amit/test.py'

with open(file_path, 'r') as file:
    for line in file:
        print(line.strip())