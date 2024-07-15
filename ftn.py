import openai
import certifi
import httpx

# Custom function to handle the file upload using HTTPX directly
def upload_file_with_httpx(file_path, purpose):
    url = "https://api.openai.com/v1/files"
    headers = {
        "Authorization": f"Bearer {openai.api_key}",
    }
    files = {
        "file": open(file_path, "rb"),
        "purpose": (None, purpose),
    }

    # Use HTTPX with certifi's CA bundle for SSL verification
    with httpx.Client(verify=certifi.where()) as client:
        response = client.post(url, headers=headers, files=files)
        response.raise_for_status()
        return response.json()

# Ensure you set your OpenAI API key
openai.api_key = 'sk-proj-2vkoZfiMB1YJXyltgtNWT3BlbkFJX7efKeVVtQ3qfrWQBhqb'

# Path to your fine-tuning data file
file_path = "finetuning_data.jsonl"
purpose = "fine-tune"

# Upload the file and handle any errors
try:
    response = upload_file_with_httpx(file_path, purpose)
    print(response)
except httpx.ConnectError as e:
    print(f"Connection error: {e}")
except httpx.HTTPStatusError as e:
    print(f"HTTP error occurred: {e}")
except Exception as e:
    print(f"An error occurred: {e}")