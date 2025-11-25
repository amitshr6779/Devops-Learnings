# 🚀 8. Mini Project — User Profile Manager


candidate_details ={
    "name": "John Doe",
    "age": 28,
    "is_employed": True,
    "skills": ["Python", "Data Analysis", "Machine Learning"],
    "achivements_ids": [101, 102, 103,101, 103,105]
}

while True:
    user_skill = input("Enter a skill to check (or type 'exit' to quit): ")
    if user_skill.lower() == 'exit':
        break
    else:
        candidate_details["skills"].append(user_skill)

print("Candidate Details:")

print(f"""
      
Name: {candidate_details['name']},
Age: {candidate_details['age']},
Employed: {candidate_details['is_employed']},
Skills: {candidate_details['skills']}
Immutable_skills: {tuple(candidate_details['skills'])}
Achivements IDs : { set(candidate_details['achivements_ids']) }

""")

