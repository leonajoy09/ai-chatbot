from openai import OpenAI
import certifi
import httpx


client = OpenAI()


#  OpenAI API key
client.api_key = 'sk-proj-2vkoZfiMB1YJXyltgtNWT3BlbkFJX7efKeVVtQ3qfrWQBhqb'

# Creating a custom HTTPX client using certifi's CA bundle for verification
httpx_client = httpx.Client(verify=certifi.where())

# Set the custom HTTPX client for OpenAI
client.http_client = httpx_client

# Creating a fine-tuning job
response = client.fine_tuning.jobs.create(
    model="ft:gpt-3.5-turbo-0125:personal::9f77V0px",
    training_file="file-iVyu4g9aqHyR5jYfjPJb3Jiw",
   
)

print(response)