import openai
import certifi
import httpx
import ssl

# Initializing OpenAI client
openai.api_key = 'sk-proj-8gosgQLsvWUoF6g4iPgnT3BlbkFJZHxOCpHPNV6S1DxfvEZ7'

# Creating custom SSL context using certifi's CA bundle
ssl_context = ssl.create_default_context(cafile=certifi.where())

# Creating custom HTTPX transport using the SSL context
transport = httpx.HTTPTransport(ssl_context=ssl_context)

# Creating custom HTTPX client with the custom transport
httpx_client = httpx.Client(transport=transport)

# Override the default HTTPX client in OpenAI
openai.httpx_client = httpx_client

job_id = 'ftjob-hKg8nEs2YLge5cHprJLkozv7'

# Retrieving the fine-tuning job
response = openai.FineTune.retrieve(id=job_id)

print(response)