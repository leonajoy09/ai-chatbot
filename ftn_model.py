from openai import OpenAI
import certifi
import httpx


client = OpenAI()


# Creating a custom HTTPX client using certifi's CA bundle for verification
httpx_client = httpx.Client(verify=certifi.where())

# Set the custom HTTPX client for OpenAI
client.http_client = httpx_client

# Creating a fine-tuning job
response = client.fine_tuning.jobs.create(
    model="ft:gpt-3.5-turbo-0125:personal::9lGcgU7m",
    training_file="file-Tb2PvrRWQ0BHILFdfQQAOTEX",
   
)

print(response)