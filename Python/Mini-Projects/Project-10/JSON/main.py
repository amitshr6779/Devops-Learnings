import json

'''
#This module provides functions to load and save JSON data.

def load_json(file_path):
    """Load JSON data from a file."""
    with open(file_path, 'r') as file:
        data = json.load(file)
    return data

def save_json(data, file_path):
    """Save JSON data to a file."""
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

if __name__ == "__main__":
    # Example usage
    sample_data = {
        "name": "John Doe",
        "age": 30,
        "city": "New York"
    }
    
    # Save the sample data to a JSON file
    save_json(sample_data, 'sample.json')
    
    # Load the data back from the JSON file
    loaded_data = load_json('sample.json')
    print(loaded_data)

'''
#Create a JSON string with your own details (name, age, city) and parse it.
#Access and print each value separately.
#Modify the city field and print the updated JSON.

json_string = {"name": "Alice Smith", "age": 28, "city": "Los Angeles"}

# here, Convert dictionary to JSON string
json_string_data = json.dumps(json_string)

parsed_data = json.loads(json_string_data)
print(parsed_data)

for key, value in parsed_data.items():
    print(f"{key}: {value}")

parsed_data["city"] = "San Francisco"
print("Updated JSON:", json.dumps(parsed_data, indent=4))

#Add a new key: "skills": ["python", "devops", "linux"].
#Write the updated JSON to a file.
#Read it back and print all skill values.

parsed_data["skills"] = ["python", "devops", "linux"]

with open("updated_data.json", "w") as file:
    json.dump(parsed_data, file, indent=4)

with open("updated_data.json", "r") as file:
    data_from_file = json.load(file)

print("Skills:", data_from_file["skills"])

#Create a JSON file containing: employee details salary department, list of projects
#Read this JSON and: Increase salary by 10% ,Add a new project . Save the updated JSON to a new file

employee_data = {
    "name": "Bob Johnson",
    "age": 35,
    "department": "Engineering",
    "salary": 85000,
    "projects": ["Project A", "Project B", "Project C"]
}

def save_employee_data_json(data, file_path):
    with open(file_path, 'w') as file:
        json.dump(data, file, indent=4)

save_employee_data_json(employee_data, 'employee_data.json')      

with open('employee_data.json', 'r') as file:
    employee_data = json.load(file)
    employee_data["salary"] = round(employee_data["salary"] * 1.10, 2)
    employee_data["projects"].append("Project D")

save_employee_data_json(employee_data, 'updated_employee_data.json')