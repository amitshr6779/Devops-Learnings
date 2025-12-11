'''
Docstring for Python.Mini-Projects.Project-11.main
To trigger/Cancel Azure DevOps Pipeline using REST API and Python
'''


import base64
import requests

ORG = "<your-organization>"
PROJECT = "<your-project>"
#PIPELINE_ID = 533
FOLDER_PATH = "\\Iris-Svc\\QA"
PAT = "<Your-Personal-Access-Token>"  # Personal Access Token

token = base64.b64encode(f":{PAT}".encode()).decode()
headers = { 
    "Authorization": f"Basic {token}",
    "Content-Type": "application/json"
}

#get all pipelines in a folder
pipelines_url = f"https://dev.azure.com/{ORG}/{PROJECT}/_apis/pipelines?api-version=7.1-preview.1"
response = requests.get(pipelines_url, headers=headers)
all_pipelines = response.json().get("value", [])

#folder_pipelines = [p for p in all_pipelines if p.get("folder") == FOLDER_PATH]
folder_pipelines = []
for p in all_pipelines:
    if p.get("folder", "") == FOLDER_PATH:
        folder_pipelines.append(p)
        #print(f"Found pipeline: ID={p['id']}, Name={p['name']}, Folder={p['folder']}")
        #print(f"\nFound {len(folder_pipelines)} pipelines in folder: {FOLDER_PATH}")

# Print once after loop completes
if folder_pipelines:
    print(f"\nFound {len(folder_pipelines)} pipelines in folder: {FOLDER_PATH} ")
else:
    print(f"\nNo pipelines found in folder: {FOLDER_PATH}")

## 2. STOP RUNNING RUNS FOR EACH PIPELINE
for pipeline in folder_pipelines:
    pipeline_id = pipeline["id"]
    pipeline_name = pipeline["name"]
    runs_url = f"https://dev.azure.com/{ORG}/{PROJECT}/_apis/pipelines/{pipeline_id}/runs?api-version=7.1-preview.1"
    runs_response = requests.get(runs_url, headers=headers)
    #print(runs_response)
    for run in runs_response.json().get("value", []):
        state = run.get("state")
        run_id = run.get("id")
        #print(f"Pipeline: {pipeline_name} (ID: {pipeline_id}) - Run ID: {run_id}, State: {state}")
        if state in ["inProgress", "notStarted"]:
            # Use Build API instead of Pipeline API for cancellation
            cancel_url = f"https://dev.azure.com/{ORG}/{PROJECT}/_apis/build/builds/{run_id}?api-version=7.1"
            cancel_payload = {"status": "Cancelling"}  # Note: "status" not "state"
            cancel_response = requests.patch(cancel_url, headers=headers, json=cancel_payload)
            if cancel_response.status_code in [200, 202]:
                print(f"Cancelled run ID {run_id} for pipeline '{pipeline_name}' (ID: {pipeline_id})")
            else:
                print(f"Failed to cancel run ID {run_id} for pipeline '{pipeline_name}' (ID: {pipeline_id}). Status Code: {cancel_response.status_code}")

print("Done.")






