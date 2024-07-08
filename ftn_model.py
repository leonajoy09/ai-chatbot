from openai import OpenAI
import certifi
import httpx


client = OpenAI()


#  OpenAI API key
client.api_key = 'sk-proj-8gosgQLsvWUoF6g4iPgnT3BlbkFJZHxOCpHPNV6S1DxfvEZ7'

# Creating a custom HTTPX client using certifi's CA bundle for verification
httpx_client = httpx.Client(verify=certifi.where())

# Set the custom HTTPX client for OpenAI
client.http_client = httpx_client

# Creating a fine-tuning job
response = client.fine_tuning.jobs.create(
    model="ft:gpt-3.5-turbo-0125:personal::9bmeZOoz",
    training_file="file-XB7nBNZCXZnjn8QcnHYmKO3U",
   
)

print(response)
