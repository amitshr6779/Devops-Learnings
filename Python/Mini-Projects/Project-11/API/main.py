import requests

'''
api_url = "https://jsonplaceholder.typicode.com/posts/3"

response = requests.get(api_url)
if response.status_code == 200:
    data = response.json()
    print(f"api response: {data}")
else:
    print(f"Failed to retrieve data. Status code: {response.status_code}")


    
#POST request    

data = {
    "title": "Updated Title",
    "body": "Updated Body",
    "userId": 1
}

try:
    post_response = requests.post(f'{"https://jsonplaceholder.typicode.com/posts/"}' , json=data)
    if post_response.status_code == 201:
        post_data = post_response.json()
        print(f"Post Response: {post_data}")
    else:
        print(f"Failed to create post. Status code: {post_response.status_code}")
except requests.exceptions.RequestException as e:
    print(f"An error occurred while making the POST request: {e}")


#PUT request
put_data = {
    "title": "Updated Title via PUT",
    "body": "Updated Body via PUT",
    "userId": 1
}
put_response = requests.put("https://jsonplaceholder.typicode.com/posts/1", json=put_data)

try:
    if put_response.status_code == 200:
        updated_data = put_response.json()
        print(f"PUT Response: {updated_data}")
    else:
        print(f"Failed to update post. Status code: {put_response.status_code}")
except requests.exceptions.RequestException as e:
    print(f"An error occurred while making the PUT request: {e}")


#delete request
delete_response = requests.delete("https://jsonplaceholderx.typicode.com/posts/1")

try:
    if delete_response.status_code == 200:
        print("Post deleted successfully.")
    else:
        print(f"Failed to delete post. Status code: {delete_response.status_code}")
except requests.exceptions.RequestException as e:
    print(f"An error occurred while making the DELETE request: {e}")    

'''

import sys
import base64
import json

ORG = "<your-organization>"
PROJECT = "<your-project>"
PIPELINE_ID = 533
PAT = "<Your-Personal-Access-Token>"  # Personal Access Token

BASE_URL = f"https://dev.azure.com/{ORG}/{PROJECT}/_apis/pipelines/{PIPELINE_ID}/runs?api-version=6.0-preview.1"

enc_pat = base64.b64encode(f":{PAT}".encode()).decode()

headers = {
    "Authorization": f"Basic {enc_pat}",
    "Content-Type": "application/json"
}

payload = {
    "resources": {
        "repositories": {
            "self": {
                "refName": "refs/heads/main"   # ← your branch name
            }
        }
    },
    "templateParameters": {}   # optional but avoids null error
}

#response = requests.post(BASE_URL, headers=headers , json=json.dumps(payload))
response = requests.post(BASE_URL, headers=headers , json=payload)
if response.status_code == 200 or response.status_code == 201:
    print("Pipeline triggered successfully.")
    print("Response:", response.json())
else:
    print(f"Failed to trigger pipeline. Status code: {response.status_code}")
    print("Response:", response.text)